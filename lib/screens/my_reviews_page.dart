import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/review.dart'; // Assicurati che il path sia corretto
import '../widgets/review_card.dart';
import '../utils/premium_manager.dart';
import '../widgets/upgrade_premium_modal.dart';
import '../widgets/review_filters_dialog.dart';
// import '../widgets/review_stats_dialog.dart'; // Commentato se non più usato direttamente qui
import '../screens/add_review_page.dart'; // << IMPORT PER NAVIGARE ALLA PAGINA DI MODIFICA
import '../services/review_service.dart'; // << IMPORT PER IL SERVIZIO DI REVIEW
import '../screens/review_stats_page.dart'; // Verifica che questo path sia corretto

import 'package:jetpin_app/l10n/app_localizations.dart';

class MyReviewsPage extends StatelessWidget {
  const MyReviewsPage({super.key});

  String? getSuggestedPremiumModalAirline(List<Review> reviews, {int threshold = 5}) {
    if (reviews.isEmpty) return null;
    final Map<String, int> airlineCount = {};
    for (final review in reviews) {
      airlineCount[review.airline] = (airlineCount[review.airline] ?? 0) + 1;
    }
    String? suggestedAirline;
    int maxCount = threshold - 1; // Inizia sotto la soglia
    airlineCount.forEach((airline, count) {
      if (count > maxCount) {
        maxCount = count;
        suggestedAirline = airline;
      }
    });
    // Restituisce solo se la soglia è effettivamente raggiunta o superata
    return maxCount >= threshold ? suggestedAirline : null;
  }

  void _showSmartPremiumModal(BuildContext context, String airline, int count) {
    final S localizations = S.of(context)!;
    showDialog(
      context: context,
      builder: (BuildContext dialogContext) {
        final S dialogLocalizations = S.of(dialogContext)!;
        return AlertDialog(
          title: Text(dialogLocalizations.myReviewsSmartModalTitle),
          content: Text(dialogLocalizations.myReviewsSmartModalContent(count, airline)),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(dialogContext).pop(),
              child: Text(dialogLocalizations.myReviewsSmartModalLaterButton),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.of(dialogContext).pop();
                Navigator.of(context).pushNamed('/upgrade');
              },
              child: Text(dialogLocalizations.myReviewsSmartModalDiscoverButton),
            ),
          ],
        );
      },
    );
  }

  // --- NUOVO METODO PER GESTIRE LA MODIFICA DI UNA RECENSIONE ---
  void _handleEditReview(BuildContext context, Review review) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => AddReviewPage(existingReview: review),
      ),
    ).then((result) {
      // 'result' potrebbe essere la recensione aggiornata, se AddReviewPage la restituisce.
      // Dato che usiamo StreamBuilder, la UI si aggiornerà automaticamente quando i dati
      // in Firestore cambiano. Possiamo mostrare uno SnackBar di conferma se AddReviewPage non lo fa.
      // AddReviewPage mostra già uno SnackBar per la modifica riuscita.
      if (result is Review && context.mounted) { // Esempio se volessimo fare qualcosa con la recensione ritornata
        // print("Recensione modificata ritornata: ${result.comment}");
      }
    });
  }

  // --- NUOVO METODO PER GESTIRE L'ELIMINAZIONE DI UNA RECENSIONE ---
  Future<void> _handleDeleteReview(BuildContext context, Review review, S localizations) async {
    final bool? confirmDelete = await showDialog<bool>(
      context: context,
      builder: (BuildContext dialogContext) {
        return AlertDialog(
          title: Text(localizations.deleteReviewConfirmTitle),
          content: Text(localizations.deleteReviewConfirmMessage),
          actions: <Widget>[
            TextButton(
              child: Text(localizations.cancelButton),
              onPressed: () => Navigator.of(dialogContext).pop(false),
            ),
            TextButton(
              style: TextButton.styleFrom(foregroundColor: Theme.of(context).colorScheme.error),
              child: Text(localizations.deleteButton), // O usa deleteReviewButtonLabel se preferisci
              onPressed: () => Navigator.of(dialogContext).pop(true),
            ),
          ],
        );
      },
    );

    if (confirmDelete == true) {
      if (review.id == null || review.userId.isEmpty) {
        print("Errore: ID recensione o ID utente mancante per l'eliminazione.");
         if (context.mounted) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text(localizations.errorDeletingReview)),
            );
         }
        return;
      }

      final reviewService = ReviewService();
      final bool success = await reviewService.deleteReview(review.id!, review.userId, context);

      if (context.mounted) {
        if (success) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(localizations.reviewDeletedSuccessMessage)),
          );
          // Lo StreamBuilder aggiornerà automaticamente la lista
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(localizations.errorDeletingReview)),
          );
        }
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final user = FirebaseAuth.instance.currentUser;
    final S localizations = S.of(context)!;

    if (user == null) {
      return Center(child: Text(localizations.myReviewsLoginPrompt));
    }

    final String currentUserId = user.uid; // ID dell'utente loggato

    return Scaffold(
      appBar: AppBar(
        title: Text(localizations.myReviewsAppBarTitle),
        // Potresti voler aggiungere qui un pulsante per i filtri se li rimuovi dal corpo
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: Wrap(
              spacing: 8.0,
              runSpacing: 8.0,
              alignment: WrapAlignment.center,
              children: [
                ElevatedButton.icon(
                  onPressed: () async {
                    final isPremium = await PremiumManager.isPremium();
                    if (!context.mounted) return;
                    if (!isPremium) {
                      showPremiumBlockDialog(context, 'review_filters');
                      return;
                    }
                    // TODO: Implementare la logica di filtraggio effettiva basata sul risultato del dialogo
                    final selectedFilter = await showDialog<String>( // Salva il risultato del filtro
                      context: context,
                      builder: (_) => const ReviewFiltersDialog(),
                    );
                    if (selectedFilter != null) {
                      print("Filtro selezionato: $selectedFilter");
                      // Qui dovrai aggiornare lo stream o il query in base al filtro.
                      // Questo richiederà di rendere MyReviewsPage uno StatefulWidget
                      // per poter cambiare dinamicamente la query dello StreamBuilder.
                    }
                  },
                  icon: const Icon(Icons.filter_alt),
                  label: Text(localizations.myReviewsAdvancedFiltersButton),
                ),
                // Il pulsante Stats potrebbe portare a ReviewStatsPage invece di mostrare un dialogo
                ElevatedButton.icon(
                  onPressed: () {
                     Navigator.push(
                        context,
                        MaterialPageRoute(builder: (_) => const ReviewStatsPage()),
                      );
                  },
                  icon: const Icon(Icons.bar_chart),
                  label: Text(localizations.myReviewsStatsButton),
                ),
              ],
            ),
          ),
          Expanded(
            child: StreamBuilder<QuerySnapshot>(
              stream: FirebaseFirestore.instance
                  .collection('reviews')
                  .where('userId', isEqualTo: user.uid) // Mostra solo le recensioni dell'utente loggato
                  .orderBy('date', descending: true)
                  .snapshots(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                }
                if (snapshot.hasError) {
                  return Center(child: Text(localizations.errorLoadingData + '\n${snapshot.error}'));
                }
                if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
                  return Center(child: Text(localizations.myReviewsNoReviews));
                }

                final reviews = snapshot.data!.docs.map((doc) {
                  final data = doc.data() as Map<String, dynamic>;
                  // --- MODIFICA PER PASSARE L'ID DEL DOCUMENTO ---
                  return Review.fromMap(data, doc.id);
                }).toList(); // Rimosso .whereType<Review>() perché fromMap ora dovrebbe sempre restituire Review

                // Logica Smart Premium Modal (invariata, ma assicurati che il contesto sia corretto)
                // Eseguita in un post-frame callback per evitare di chiamare showDialog durante il build
                WidgetsBinding.instance.addPostFrameCallback((_) {
                  if (context.mounted) { // Controlla se il widget è ancora nel tree
                     PremiumManager.isPremium().then((isPremium) async {
                        if (!isPremium && await PremiumManager.shouldShowSmartModal()) {
                          final airline = getSuggestedPremiumModalAirline(reviews, threshold: 3); // Soglia ridotta per test
                          if (airline != null && context.mounted) { 
                            final count = reviews.where((r) => r.airline == airline).length;
                             // Ulteriore controllo mounted prima di chiamare _showSmartPremiumModal
                            if (context.mounted) {
                               _showSmartPremiumModal(context, airline, count);
                               PremiumManager.setSmartModalShownNow();
                            }
                          }
                        }
                      });
                  }
                });


                return ListView.builder(
                  itemCount: reviews.length,
                  itemBuilder: (context, index) {
                    final review = reviews[index];
                    // --- LOGICA PER MOSTRARE/NASCONDERE PULSANTI AZIONE ---
                    bool isOwner = review.userId == currentUserId;

                    return ReviewCard(
                      review: review,
                      onEditPressed: isOwner ? () => _handleEditReview(context, review) : null,
                      onDeletePressed: isOwner ? () => _handleDeleteReview(context, review, localizations) : null,
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
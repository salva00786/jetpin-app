import 'package:flutter/material.dart';

// Import per la localizzazione (ASSUMENDO che il tuo file generato sia qui e definisca 'S')
import 'package:jetpin_app/l10n/app_localizations.dart'; // Sostituisci 'jetpin_app' con il nome del tuo package se diverso

class ReviewStatsDialog extends StatelessWidget {
  final int totalReviews;
  final double averageRating;
  // final String? longestReviewText; // Se la recensione più lunga dovesse diventare dinamica

  const ReviewStatsDialog({
    super.key,
    required this.totalReviews,
    required this.averageRating,
    // this.longestReviewText,
  });

  @override
  Widget build(BuildContext context) {
    // CORREZIONE: Aggiunto '!'
    final S localizations = S.of(context)!;

    return AlertDialog(
      title: Text(localizations.reviewStatsDialogTitle),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('${localizations.reviewStatsTotalReviewsLabel} $totalReviews'),
          const SizedBox(height: 12.0),
          Text('${localizations.reviewStatsAverageRatingLabel} ${averageRating.toStringAsFixed(1)} ⭐'),
          const SizedBox(height: 12.0),
          Text(localizations.reviewStatsLongestReviewLabel),
          // Commenti per la gestione dinamica della recensione più lunga mantenuti
          // if (longestReviewText != null && longestReviewText!.isNotEmpty)
          //   Text(
          //     longestReviewText!,
          //     style: const TextStyle(fontStyle: FontStyle.italic),
          //     maxLines: 3,
          //     overflow: TextOverflow.ellipsis,
          //   )
          // else
          //   Text(
          //     localizations.reviewStatsNoLongestReview,
          //     style: const TextStyle(fontStyle: FontStyle.italic, color: Colors.grey),
          //   ),
          Text(
            localizations.reviewStatsLongestReviewExample, // Testo statico localizzato
            style: const TextStyle(fontStyle: FontStyle.italic),
          ),
        ],
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: Text(localizations.closeButton), // Chiave da ARB
        ),
      ],
    );
  }
}
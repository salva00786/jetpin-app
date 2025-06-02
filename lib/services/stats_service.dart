import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../models/review.dart';

class StatsService {
  static Future<List<Review>> getUserReviews() async {
    final User? user = FirebaseAuth.instance.currentUser;
    if (user == null) {
      return [];
    }

    try {
      final QuerySnapshot snapshot = await FirebaseFirestore.instance
          .collection('reviews')
          .where('userId', isEqualTo: user.uid)
          .orderBy('date', descending: true)
          .get();

      return snapshot.docs.map((doc) {
        final data = doc.data() as Map<String, dynamic>?;
        if (data == null) {
          print('Attenzione: dati null per un documento nella collezione reviews (ID: ${doc.id})');
          return null; 
        }
        // --- MODIFICATO PER PASSARE doc.id ---
        return Review.fromMap(data, doc.id);
      }).whereType<Review>().toList(); // Filtra eventuali null se data era null
    } catch (e) {
      print('Errore durante il recupero delle recensioni utente: $e');
      return [];
    }
  }

  static double getAverageRating(List<Review> reviews) {
    if (reviews.isEmpty) return 0.0;
    final double totalRating = reviews.fold<double>(0.0, (sum, r) => sum + r.rating);
    return totalRating / reviews.length;
  }

  static Map<String, int> getReviewsByAirline(List<Review> reviews) {
    final Map<String, int> result = {};
    for (final Review review in reviews) {
      result[review.airline] = (result[review.airline] ?? 0) + 1;
    }
    return result;
  }

  static Map<String, int> getReviewsByMonth(List<Review> reviews) {
    final Map<String, int> result = {};
    for (final Review review in reviews) {
      final String key = "${review.date.year}-${review.date.month.toString().padLeft(2, '0')}";
      result[key] = (result[key] ?? 0) + 1;
    }
    return result;
  }
}
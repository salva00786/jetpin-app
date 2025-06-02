// models/review.dart
import 'package:cloud_firestore/cloud_firestore.dart';

class Review {
  final String? id;
  final String airline;
  final String? airlineIcao; // Campo ICAO
  final String flightNumber;
  final int rating;
  final String comment;
  final String userId;
  final String userName;
  final DateTime date;
  final DateTime? lastEditedAt;
  final int helpfulCount;

  const Review({
    this.id,
    required this.airline,
    this.airlineIcao,
    required this.flightNumber,
    required this.rating,
    required this.comment,
    required this.userId,
    required this.userName,
    required this.date,
    this.lastEditedAt,
    this.helpfulCount = 0,
  });

  Map<String, dynamic> toMap() {
    return {
      'airline': airline,
      'airlineIcao': airlineIcao, // Inviato anche se null
      'flightNumber': flightNumber,
      'rating': rating,
      'comment': comment,
      'userId': userId,
      'userName': userName,
      'date': date.toIso8601String(),
      'helpfulCount': helpfulCount,
      // 'lastEditedAt' NON viene inviato qui, è per gli update
    };
  }

  static Review fromMap(Map<String, dynamic> map, String documentId) {
    DateTime reviewDate;
    if (map['date'] is String) {
      reviewDate = DateTime.tryParse(map['date'] as String) ?? DateTime.now();
    } else if (map['date'] is Timestamp) {
      reviewDate = (map['date'] as Timestamp).toDate();
    } else {
      print("Attenzione: campo 'date' mancante o formato non valido. Utilizzata data corrente. Valore: ${map['date']}");
      reviewDate = DateTime.now();
    }

    DateTime? lastEditedDate;
    if (map['lastEditedAt'] is String) {
      lastEditedDate = DateTime.tryParse(map['lastEditedAt'] as String);
    } else if (map['lastEditedAt'] is Timestamp) {
      lastEditedDate = (map['lastEditedAt'] as Timestamp).toDate();
    }

    return Review(
      id: documentId,
      airline: map['airline'] as String? ?? '',
      airlineIcao: map['airlineIcao'] as String?,
      flightNumber: map['flightNumber'] as String? ?? '',
      rating: map['rating'] as int? ?? 0,
      comment: map['comment'] as String? ?? '',
      userId: map['userId'] as String? ?? '',
      userName: map['userName'] as String? ?? '',
      date: reviewDate,
      lastEditedAt: lastEditedDate,
      helpfulCount: map['helpfulCount'] as int? ?? 0,
    );
  }

  Review copyWith({
    String? id,
    String? airline,
    String? airlineIcao,
    String? flightNumber,
    int? rating,
    String? comment,
    String? userId,
    String? userName,
    DateTime? date,
    DateTime? lastEditedAt,
    int? helpfulCount,
  }) {
    return Review(
      id: id ?? this.id,
      airline: airline ?? this.airline,
      airlineIcao: airlineIcao ?? this.airlineIcao,
      flightNumber: flightNumber ?? this.flightNumber,
      rating: rating ?? this.rating,
      comment: comment ?? this.comment,
      userId: userId ?? this.userId,
      userName: userName ?? this.userName,
      date: date ?? this.date,
      lastEditedAt: lastEditedAt ?? this.lastEditedAt,
      helpfulCount: helpfulCount ?? this.helpfulCount,
    );
  }
}
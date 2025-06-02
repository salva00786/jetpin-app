import 'package:cloud_firestore/cloud_firestore.dart';

class Reply {
  final String? id;
  final String reviewId;
  final String reviewOwnerId;
  final String replierId;
  final String replierName;
  final String replyText;
  final DateTime timestamp;
  final DateTime? lastEditedAt; // << NUOVO CAMPO: Data ultima modifica della risposta

  const Reply({
    this.id,
    required this.reviewId,
    required this.reviewOwnerId,
    required this.replierId,
    required this.replierName,
    required this.replyText,
    required this.timestamp,
    this.lastEditedAt, // << NUOVO: Aggiunto al costruttore
  });

  Map<String, dynamic> toMap() {
    return {
      'reviewId': reviewId,
      'reviewOwnerId': reviewOwnerId,
      'replierId': replierId,
      'replierName': replierName,
      'replyText': replyText,
      'timestamp': Timestamp.fromDate(timestamp),
      // 'lastEditedAt' sarà gestito da FieldValue.serverTimestamp() nel servizio durante l'update,
      // ma il modello lo prevede per quando si leggono i dati.
    };
  }

  static Reply fromMap(Map<String, dynamic> map, String documentId) {
    DateTime replyTimestamp;
    if (map['timestamp'] is Timestamp) {
      replyTimestamp = (map['timestamp'] as Timestamp).toDate();
    } else if (map['timestamp'] is String) {
      replyTimestamp = DateTime.tryParse(map['timestamp'] as String) ?? DateTime.now();
    } else {
      replyTimestamp = DateTime.now();
      print("Attenzione: campo 'timestamp' mancante o formato non valido per la risposta. Valore: ${map['timestamp']}");
    }

    DateTime? lastEditedDate; // << NUOVO: Logica per leggere lastEditedAt
    if (map['lastEditedAt'] is Timestamp) {
      lastEditedDate = (map['lastEditedAt'] as Timestamp).toDate();
    } else if (map['lastEditedAt'] is String) {
      lastEditedDate = DateTime.tryParse(map['lastEditedAt'] as String);
    }

    return Reply(
      id: documentId,
      reviewId: map['reviewId'] as String? ?? '',
      reviewOwnerId: map['reviewOwnerId'] as String? ?? '',
      replierId: map['replierId'] as String? ?? '',
      replierName: map['replierName'] as String? ?? '',
      replyText: map['replyText'] as String? ?? '',
      timestamp: replyTimestamp,
      lastEditedAt: lastEditedDate, // << NUOVO: Assegnazione di lastEditedAt
    );
  }

  // --- NUOVO METODO copyWith ---
  Reply copyWith({
    String? id,
    String? reviewId,
    String? reviewOwnerId,
    String? replierId,
    String? replierName,
    String? replyText,
    DateTime? timestamp,
    DateTime? lastEditedAt, // Opzionale per permettere di impostarlo a null o a un valore
    bool forceNullLastEditedAt = false, // Per resettare esplicitamente lastEditedAt
  }) {
    return Reply(
      id: id ?? this.id,
      reviewId: reviewId ?? this.reviewId,
      reviewOwnerId: reviewOwnerId ?? this.reviewOwnerId,
      replierId: replierId ?? this.replierId,
      replierName: replierName ?? this.replierName,
      replyText: replyText ?? this.replyText,
      timestamp: timestamp ?? this.timestamp,
      lastEditedAt: forceNullLastEditedAt ? null : (lastEditedAt ?? this.lastEditedAt),
    );
  }
  // --- FINE NUOVO METODO copyWith ---
}
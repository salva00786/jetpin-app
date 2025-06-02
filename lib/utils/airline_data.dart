// lib/utils/airline_data.dart
import 'dart:convert';
import 'package:flutter/services.dart' show rootBundle;

// Semplice classe per contenere le informazioni sulla compagnia aerea
class Airline {
  final String name;
  final String icao;
  final String? iata;

  Airline({required this.name, required this.icao, this.iata});

  // Utile per il widget Autocomplete per mostrare il nome nel campo di testo
  // e per il confronto nell'optionsBuilder se necessario.
  @override
  String toString() {
    return name;
  }

  // Necessario per confronti in Autocomplete se si usano oggetti complessi
  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is Airline &&
        other.name == name &&
        other.icao == icao;
  }

  @override
  int get hashCode => name.hashCode ^ icao.hashCode;
}

Future<List<Airline>> loadAirlinesData(String assetPath) async {
  try {
    final String jsonString = await rootBundle.loadString(assetPath);
    // Assicurati che il JSON sia effettivamente una lista alla radice
    final List<dynamic> jsonList = json.decode(jsonString) as List<dynamic>;

    List<Airline> airlines = [];
    for (var item in jsonList) {
      if (item is Map<String, dynamic>) {
        final String name = item['name'] as String? ?? 'Unknown';
        final String? icao = item['icao'] as String?;
        final String? iata = item['iata'] as String?; // Opzionale
        final String active = item['active'] as String? ?? 'N';

        if (active == 'Y' &&
            name.isNotEmpty && name != '\\N' && name != 'Unknown' && name != 'Private flight' &&
            icao != null && icao.isNotEmpty && icao != '\\N' && icao != 'N/A' &&
            RegExp(r"^[A-Z0-9]{3,4}$").hasMatch(icao)) { // ICAO può essere 3 o 4
          airlines.add(Airline(name: name, icao: icao, iata: (iata != null && iata != "\\N" && iata.isNotEmpty) ? iata : null));
        }
      }
    }
    airlines.sort((a, b) => a.name.toLowerCase().compareTo(b.name.toLowerCase()));
    print("[AirlineDataLoader] Caricate e filtrate ${airlines.length} compagnie aeree attive.");
    return airlines;
  } catch (e, s) {
    print("Errore durante il caricamento o il parsing di airlines.json: $e");
    print(s);
    return [];
  }
}
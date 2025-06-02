// lib/utils/logo_helper.dart

// Questa mappa diventa un fallback o per nomi non standard
// che potrebbero non avere un ICAO diretto o per usi specifici.
const Map<String, String> airlineIcaoCodes = {
  'ryanair': 'RYR', // Esempio, assicurati che i codici siano MAIUSCOLI
  'easyjet': 'EZY',
  'lufthansa': 'DLH',
  'ita airways': 'ITY',
  'air france': 'AFR',
  // ... altre voci che potresti voler mantenere per un matching per nome specifico
};

/// Restituisce il percorso dell'asset per il logo di una compagnia aerea, data il NOME.
/// Usa la mappa interna `airlineIcaoCodes` come fallback.
/// Ora cerca file .webp.
String getLogoPathByName(String airlineName) {
  final String normalizedKey = airlineName.toLowerCase().trim();
  final String? icaoCode = airlineIcaoCodes[normalizedKey];

  if (icaoCode != null && icaoCode.isNotEmpty) {
    // Assumiamo che i codici ICAO nella mappa siano già corretti per il nome del file
    return 'assets/logos/${icaoCode.toUpperCase()}.webp';
  }
  // Potresti voler aggiungere una logica per tentare di inferire l'ICAO dal nome
  // o cercare in una lista più grande se disponibile qui, ma per ora ci affidiamo alla mappa.
  print('Logo non trovato tramite NOME in airlineIcaoCodes per: $airlineName (normalizzato: $normalizedKey)');
  return ''; // Restituisce stringa vuota se non trovato
}

/// Restituisce il percorso dell'asset per il logo di una compagnia aerea, dato il CODICE ICAO.
/// Ora cerca file .webp.
String getLogoPathByIcao(String? icaoCode) {
  if (icaoCode != null && icaoCode.isNotEmpty && RegExp(r"^[A-Z0-9]{3,4}$").hasMatch(icaoCode.toUpperCase())) {
    return 'assets/logos/${icaoCode.toUpperCase()}.webp';
  }
  if (icaoCode != null && icaoCode.isNotEmpty) {
     print('Codice ICAO "$icaoCode" non valido per getLogoPathByIcao o logo non trovato.');
  }
  return ''; // Restituisce stringa vuota se non valido o non trovato
}
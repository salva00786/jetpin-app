// lib/services/notification_service.dart
import 'package:flutter/material.dart'; // Necessario per BuildContext nella richiesta permessi
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:timezone/data/latest.dart' as tz; // Per la schedulazione avanzata
import 'package:timezone/timezone.dart' as tz;   // Per la schedulazione avanzata

// Import per la localizzazione, se questo servizio dovesse usare stringhe localizzate
// per nomi di canali o descrizioni (anche se è meglio passarle da chi chiama se il context è disponibile lì).
// Per ora, i nomi dei canali sono statici o potrebbero essere passati.
// import 'package:jetpin_app/l10n/app_localizations.dart'; // Sostituisci 'jetpin_app' se necessario

class NotificationService {
  static final FlutterLocalNotificationsPlugin _flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();

  // Definisci gli ID e i nomi dei canali qui per coerenza
  // Potresti volerli localizzare se il nome del canale è molto visibile all'utente
  // nelle impostazioni di sistema, ma spesso un nome tecnico in inglese va bene.
  static const String _androidChannelId = 'jetpin_default_channel';
  static const String _androidChannelName = 'JetPin Notifications';
  static const String _androidChannelDescription = 'General notifications from JetPin app';

  static bool _isInitialized = false;

  static Future<void> initialize(BuildContext context) async {
    if (_isInitialized) {
      print("[NotificationService] Already initialized.");
      return;
    }
    print("[NotificationService] Initializing with flutter_local_notifications...");

    // Inizializza i fusi orari per la schedulazione (necessario per zonedSchedule)
    try {
      tz.initializeTimeZones();
      // Imposta il fuso orario locale se prevedi di fare schedulazioni basate su di esso
      // Potrebbe essere necessario chiedere all'utente o derivarlo.
      // tz.setLocalLocation(tz.getLocation('Europe/Rome')); // Esempio
      print("[NotificationService] Timezones initialized.");
    } catch (e) {
      print("[NotificationService] Failed to initialize timezones: $e");
      // L'app può continuare, ma la schedulazione con fusi orari potrebbe non funzionare come previsto
    }


    // Sostituisci 'default_notification_icon' con il nome ESATTO del tuo file icona
    // (senza estensione .png) che hai messo in android/app/src/main/res/drawable/
    // DEVE essere un'icona piccola e preferibilmente bianca/trasparente.
    const AndroidInitializationSettings initializationSettingsAndroid =
        AndroidInitializationSettings('default_notification_icon'); 

    const DarwinInitializationSettings initializationSettingsIOS =
        DarwinInitializationSettings(
      requestAlertPermission: true, // Chiedi i permessi all'avvio per iOS durante l'init
      requestBadgePermission: true,
      requestSoundPermission: true,
      // onDidReceiveLocalNotification: onIOSReceiveLocalNotification, // Per iOS < 10
    );

    const InitializationSettings initializationSettings = InitializationSettings(
      android: initializationSettingsAndroid,
      iOS: initializationSettingsIOS,
    );

    try {
      await _flutterLocalNotificationsPlugin.initialize(
        initializationSettings,
        onDidReceiveNotificationResponse: _onDidReceiveNotificationResponse,
        onDidReceiveBackgroundNotificationResponse: notificationTapBackground,
      );
      print("[NotificationService] Plugin initialized.");

      await _createOrUpdateAndroidNotificationChannel();
      print("[NotificationService] Android channel ensured.");

      // Richiesta permessi esplicita per Android 13+ (il plugin la gestisce, ma possiamo farla qui)
      // Su iOS, i permessi sono richiesti da requestAlertPermission, ecc. sopra.
      if (Theme.of(context).platform == TargetPlatform.android) {
          final AndroidFlutterLocalNotificationsPlugin? androidImplementation =
              _flutterLocalNotificationsPlugin.resolvePlatformSpecificImplementation<
                  AndroidFlutterLocalNotificationsPlugin>();
          final bool? granted = await androidImplementation?.requestNotificationsPermission();
          print("[NotificationService] Android POST_NOTIFICATIONS permission granted: $granted");
      }
      _isInitialized = true;
      print("[NotificationService] Initialization complete.");

    } catch (e, s) {
      print("[NotificationService] ERRORE durante l'inizializzazione: $e");
      print(s);
    }
  }

  static Future<void> _createOrUpdateAndroidNotificationChannel() async {
    // Prendi S se ti servono stringhe localizzate per nome/descrizione canale
    // final S localizations = S.of(context)!; // Richiederebbe BuildContext
    const AndroidNotificationChannel channel = AndroidNotificationChannel(
      _androidChannelId,
      _androidChannelName, // Usa stringa statica o localizzata
      description: _androidChannelDescription, // Usa stringa statica o localizzata
      importance: Importance.high, // O max, a seconda della priorità
      playSound: true,
      // enableLights: true, // Opzionale
      // ledColor: Colors.blue, // Opzionale
    );

    await _flutterLocalNotificationsPlugin
        .resolvePlatformSpecificImplementation<
            AndroidFlutterLocalNotificationsPlugin>()
        ?.createNotificationChannel(channel);
  }

  // Callback per quando l'utente tocca una notifica e l'app è in foreground/background (non terminata)
  static void _onDidReceiveNotificationResponse(NotificationResponse notificationResponse) async {
    final String? payload = notificationResponse.payload;
    print('[NotificationService] Notification TAPPED (foreground/background). Payload: $payload');
    if (payload != null) {
      debugPrint('notification payload: $payload');
      // Qui puoi implementare la logica per navigare a una schermata specifica
      // basandoti sul payload. Avrai bisogno di un modo per accedere al Navigator.
      // Esempio: if (payload == 'open_reviews') { MyApp.navigatorKey.currentState?.pushNamed('/my-reviews'); }
    }
  }

  // Metodo per mostrare una notifica semplice
  static Future<void> showSimpleNotification({
    required int id,
    required String title,
    required String body,
    String? payload,
  }) async {
    if (!_isInitialized) {
      print("[NotificationService] Attempted to show notification but service not initialized.");
      // Potresti voler tentare un'inizializzazione tardiva qui o loggare un errore più serio.
      // Per ora, non fa nulla se non inizializzato.
      return;
    }
    print("[NotificationService] Showing notification: id=$id, title='$title'");

    const AndroidNotificationDetails androidNotificationDetails =
        AndroidNotificationDetails(
            _androidChannelId, // ID del canale (deve corrispondere a quello creato)
            _androidChannelName,
            channelDescription: _androidChannelDescription,
            importance: Importance.high, // O max
            priority: Priority.high,
            ticker: 'ticker');
    
    const DarwinNotificationDetails iosNotificationDetails =
        DarwinNotificationDetails(
          presentAlert: true,
          presentBadge: true,
          presentSound: true,
        );
        
    const NotificationDetails notificationDetails = NotificationDetails(
      android: androidNotificationDetails,
      iOS: iosNotificationDetails
    );

    try {
      await _flutterLocalNotificationsPlugin.show(
        id,
        title,
        body,
        notificationDetails,
        payload: payload,
      );
      print("[NotificationService] Notification $id shown successfully.");
    } catch (e,s) {
      print("[NotificationService] ERROR showing notification $id: $e");
      print(s);
    }
  }

  // Aggiungi qui altri metodi come scheduleNotification, cancelNotification, ecc. se necessario
  // ... (il metodo scheduleNotificationInMinutes che ti ho fornito prima andrebbe qui) ...
}

// Questa funzione DEVE essere top-level o statica per funzionare come callback
// quando l'app è terminata o in background.
@pragma('vm:entry-point')
void notificationTapBackground(NotificationResponse notificationResponse) {
  // handle action
  print('BACKGROUND/TERMINATED notification(${notificationResponse.id}) action tapped: '
      '${notificationResponse.actionId} with'
      ' payload: ${notificationResponse.payload}');
  if (notificationResponse.input?.isNotEmpty ?? false) {
    print('notification action input: ${notificationResponse.input}');
  }
  // Qui non puoi fare navigazione diretta facilmente perché l'app potrebbe non essere "viva"
  // nello stesso modo. Di solito si salvano i dati del payload e si gestiscono
  // al prossimo avvio dell'app o quando l'app torna in foreground.
}
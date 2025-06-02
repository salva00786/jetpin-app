// main.dart
import 'dart:async';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart'; // Assicurati che sia importato

// Import per la localizzazione
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:jetpin_app/l10n/app_localizations.dart';

// Schermate
import 'screens/review_home_page.dart'; // Usata come fallback se non loggato
import 'screens/my_reviews_page.dart';
import 'screens/profile_page.dart';
import 'screens/add_review_page.dart';
import 'screens/review_stats_page.dart';
import 'screens/upgrade_premium_screen.dart';

// Manager e Servizi
import 'utils/premium_manager.dart';
import 'utils/referral_manager.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'ads/ad_manager.dart';
import 'utils/ad_frequency_manager.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
// import 'services/notification_service.dart' as AppNotificationService; // Se centralizzato

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  print("[main] Firebase.initializeApp START");
  await Firebase.initializeApp();
  print("[main] Firebase.initializeApp DONE");
  runApp(const JetPinApp());
}

class JetPinApp extends StatelessWidget {
  const JetPinApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      onGenerateTitle: (BuildContext context) {
        final S? localizations = S.of(context);
        return localizations?.appTitle ?? 'JetPin';
      },
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.indigo),
        useMaterial3: true,
      ),
      localizationsDelegates: const [
        S.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: S.supportedLocales,
      routes: {
        '/': (context) => const InitAppWrapper(),
        '/add-review': (context) => const AddReviewPage(),
        '/review-stats': (context) => const ReviewStatsPage(),
        '/upgrade': (context) => const UpgradePremiumScreen(),
      },
    );
  }
}

class InitAppWrapper extends StatefulWidget {
  const InitAppWrapper({super.key});

  @override
  State<InitAppWrapper> createState() => _InitAppWrapperState();
}

class _InitAppWrapperState extends State<InitAppWrapper> {
  Future<void>? _initializationProcessFuture;
  final AdManager _adManager = AdManager();
  final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();

  @override
  void initState() {
    super.initState();
    print("[InitAppWrapper] initState CALLED");
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (mounted) {
        setState(() {
          _initializationProcessFuture = _performInitialSetupAndTestNotification();
        });
      }
    });
  }

  @override
  void dispose() {
    print("[InitAppWrapper] dispose CALLED");
    _adManager.disposeInterstitialAd();
    super.dispose();
  }

  Future<void> _initializeFlutterLocalNotifications() async {
    print("[InitAppWrapper] Initializing flutter_local_notifications...");
    const AndroidInitializationSettings initializationSettingsAndroid =
        AndroidInitializationSettings('default_notification_icon');

    const DarwinInitializationSettings initializationSettingsIOS =
        DarwinInitializationSettings(
      requestAlertPermission: true,
      requestBadgePermission: true,
      requestSoundPermission: true,
    );

    const InitializationSettings initializationSettings = InitializationSettings(
      android: initializationSettingsAndroid,
      iOS: initializationSettingsIOS,
    );

    await flutterLocalNotificationsPlugin.initialize(
      initializationSettings,
      onDidReceiveNotificationResponse: (NotificationResponse notificationResponse) async {
        print("[InitAppWrapper] Notification tapped with payload: ${notificationResponse.payload}");
      },
      onDidReceiveBackgroundNotificationResponse: notificationTapBackground,
    );
    print("[InitAppWrapper] flutter_local_notifications initialized successfully.");

    const AndroidNotificationChannel channel = AndroidNotificationChannel(
      'jetpin_main_channel',
      'JetPin Notifiche Principali',
      description: 'Notifiche importanti da JetPin.',
      importance: Importance.max,
      playSound: true,
    );

    await flutterLocalNotificationsPlugin
        .resolvePlatformSpecificImplementation<AndroidFlutterLocalNotificationsPlugin>()
        ?.createNotificationChannel(channel);
    print("[InitAppWrapper] Android notification channel created/ensured.");

    if (mounted && Theme.of(context).platform == TargetPlatform.android) {
        final AndroidFlutterLocalNotificationsPlugin? androidImplementation =
            flutterLocalNotificationsPlugin.resolvePlatformSpecificImplementation<
                AndroidFlutterLocalNotificationsPlugin>();
        final bool? granted = await androidImplementation?.requestNotificationsPermission();
        print("[InitAppWrapper] Android POST_NOTIFICATIONS permission granted: $granted");
    }
  }

  Future<void> _showTestNotification() async {
    // ... (codice _showTestNotification invariato, assicurati che usi S.of(context) se serve per il testo)
    if (!mounted) return;
    print("[InitAppWrapper] Showing personalized test notification...");
    
    const String notificationTitle = "JetPin: Un Saluto dall'Italia! 🇮🇹"; // Potrebbe essere localizzato
    const String notificationBody = "Ciao! Sono Salvo00786, lo sviluppatore di JetPin. Quest'app nasce dalla passione italiana. Se ti piace, aiutala a volare: condividila! Grazie ✈️"; // Potrebbe essere localizzato

    const AndroidNotificationDetails androidNotificationDetails =
        AndroidNotificationDetails(
            'jetpin_main_channel', 
            'JetPin Notifiche Principali',
            channelDescription: 'Notifiche importanti da JetPin.',
            importance: Importance.high,
            priority: Priority.high,
            ticker: 'Notifica da JetPin');
            
    const DarwinNotificationDetails iosNotificationDetails = DarwinNotificationDetails(
      presentAlert: true,
      presentBadge: true,
      presentSound: true,
    );
        
    const NotificationDetails notificationDetails = NotificationDetails(
      android: androidNotificationDetails,
      iOS: iosNotificationDetails,
    );

    await flutterLocalNotificationsPlugin.show(
        0, 
        notificationTitle,
        notificationBody,
        notificationDetails,
        payload: 'jetpin_test_payload');
    print("[InitAppWrapper] Personalized test notification shown (or attempted).");
  }


  Future<void> _performInitialSetupAndTestNotification() async {
    print("[InitAppWrapper] _performInitialSetupAndTestNotification START");
    // Precondizione: il context deve essere disponibile per _initializeFlutterLocalNotifications
    if (!mounted) return; 
    
    try {
      await _initializeFlutterLocalNotifications();
      await _showTestNotification();
    } catch (e, s) {
      print("[InitAppWrapper] ERRORE durante inizializzazione/test notifiche: $e");
      print(s);
    }

    final user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      print("[InitAppWrapper] User FOUND: ${user.uid}. Running premium and referral checks...");
      try {
        await PremiumManager.syncPremiumFromCloud(user.uid);
        print("[InitAppWrapper] syncPremiumFromCloud DONE");
        PremiumManager.startPremiumAutoSync(user.uid);
        print("[InitAppWrapper] startPremiumAutoSync CALLED");
        // _checkStoredReferralLogic necessita di context, assicurati sia valido
        if (mounted) {
          await _checkStoredReferralLogic(user.uid);
          print("[InitAppWrapper] _checkStoredReferralLogic DONE");
        }
      } catch (e,s) {
        print("[InitAppWrapper] ERRORE durante _handlePremiumStartup/checkReferral: $e");
        print(s);
      }
    } else {
      print("[InitAppWrapper] No current user found during initial setup.");
    }

    final bool isCurrentlyPremium = await PremiumManager.isPremium();
    if (!isCurrentlyPremium && await AdFrequencyManager.canShowAppLaunchInterstitialToday()) {
      print("[InitAppWrapper] Attempting to load and show App Launch Interstitial Ad.");
      final Completer<void> adCompleter = Completer<void>();
      _adManager.preloadInterstitialAd(
        onAdLoaded: () async {
          print("[InitAppWrapper] App Launch Interstitial Ad loaded. Showing...");
          if (mounted) {
             _adManager.showInterstitialAdIfReady();
             await AdFrequencyManager.recordAppLaunchInterstitialShownToday();
          }
          if(!adCompleter.isCompleted) adCompleter.complete();
        },
        onAdFailedToLoad: (String errorMessage) {
          print("[InitAppWrapper] Failed to load App Launch Interstitial Ad: $errorMessage");
          if(!adCompleter.isCompleted) adCompleter.complete();
        }
      );
      try {
        await adCompleter.future.timeout(const Duration(seconds: 10));
      } catch (e) {
        print("[InitAppWrapper] Timeout o errore attesa annuncio: $e");
        if(!adCompleter.isCompleted) adCompleter.complete();
      }
    } else {
      print("[InitAppWrapper] Not showing App Launch Interstitial Ad. Premium: $isCurrentlyPremium, CanShowToday: ${await AdFrequencyManager.canShowAppLaunchInterstitialToday()}");
    }
    print("[InitAppWrapper] _performInitialSetupAndTestNotification COMPLETE");
  }

  Future<void> _checkStoredReferralLogic(String userId) async {
    print("[InitAppWrapper] _checkStoredReferralLogic START for $userId");
    if (!mounted) return; // Controllo mounted prima di accedere a S.of(context)

    try {
      final prefs = await SharedPreferences.getInstance();
      final referrerId = prefs.getString('pending_referral');
      final S localizations = S.of(context)!;

      if (referrerId != null && referrerId.isNotEmpty) {
        print('Attempting to apply stored referral for $userId from $referrerId');
        bool success = await ReferralManager.applyReferral(referrerId, userId);
        if(success){
            print('🎁 Referral applicato per $userId da $referrerId (da InitAppWrapper).');
            await prefs.remove('pending_referral');
        } else {
            print('❌ Fallimento applicazione referral (da ReferralManager) per $userId da $referrerId.');
        }
      } else {
        print("No pending referral or referrerId is empty.");
      }
    } catch (e, s) {
      print('❌ Errore applicazione referral in _checkStoredReferralLogic: $e');
      print(s);
    }
    print("[InitAppWrapper] _checkStoredReferralLogic END for $userId");
  }

  @override
  Widget build(BuildContext context) {
    print("[InitAppWrapper] build CALLED. _initializationProcessFuture is null: ${_initializationProcessFuture == null}");

    if (_initializationProcessFuture == null) {
      return const Scaffold(
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CircularProgressIndicator(),
              SizedBox(height: 20),
              Text("Inizializzazione JetPin..."),
            ],
          ),
        ),
      );
    }

    return FutureBuilder<void>(
      future: _initializationProcessFuture,
      builder: (context, snapshotInitialization) { // Rinominato snapshot per chiarezza
        if (snapshotInitialization.connectionState == ConnectionState.waiting) {
          print("[InitAppWrapper] FutureBuilder: Waiting for _initializationProcessFuture...");
           return const Scaffold(
            body: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CircularProgressIndicator(),
                  SizedBox(height: 20),
                  Text("Caricamento in corso..."),
                ],
              ),
            ),
          );
        }
        if (snapshotInitialization.hasError) {
            print("[InitAppWrapper] FutureBuilder: ERRORE in _initializationProcessFuture: ${snapshotInitialization.error}");
            return Scaffold(
              body: Center(
                child: Text("Errore durante l'inizializzazione: ${snapshotInitialization.error}"),
              ),
            );
        }
        // Quando _initializationProcessFuture è completo, ascolta lo stato di autenticazione
        print("[InitAppWrapper] FutureBuilder: _initializationProcessFuture COMPLETE. Listening to auth state.");
        
        // --- NUOVO: STREAMBUILDER PER AUTHSTATECHANGES ---
        return StreamBuilder<User?>(
          stream: FirebaseAuth.instance.authStateChanges(),
          builder: (context, snapshotAuth) { // Rinominato snapshot per chiarezza
            if (snapshotAuth.connectionState == ConnectionState.waiting) {
              return const Scaffold( // O uno splash screen più coerente
                body: Center(child: CircularProgressIndicator()),
              );
            }
            if (snapshotAuth.hasData && snapshotAuth.data != null) {
              // Utente loggato
              print("[InitAppWrapper] AuthState: User is LOGGED IN (${snapshotAuth.data!.uid}). Showing MainNavigation.");
              return const MainNavigation();
            } else {
              // Utente non loggato
              // Mostra ReviewHomePage che contiene il pulsante di login nell'AppBar.
              // In un'architettura diversa, potresti navigare a una schermata di login dedicata.
              print("[InitAppWrapper] AuthState: User is LOGGED OUT. Showing ReviewHomePage (for login).");
              return const ReviewHomePage(); // ReviewHomePage gestisce il login dalla sua AppBar
            }
          },
        );
        // --- FINE STREAMBUILDER ---
      },
    );
  }
}

@pragma('vm:entry-point')
void notificationTapBackground(NotificationResponse notificationResponse) {
  // (codice invariato)
  print('notification(${notificationResponse.id}) action tapped from background: '
      '${notificationResponse.actionId} with'
      ' payload: ${notificationResponse.payload}');
  if (notificationResponse.input?.isNotEmpty ?? false) {
    print('notification action input: ${notificationResponse.input}');
  }
}

class MainNavigation extends StatefulWidget {
  const MainNavigation({super.key});

  @override
  State<MainNavigation> createState() => _MainNavigationState();
}

class _MainNavigationState extends State<MainNavigation> with WidgetsBindingObserver {
  int _currentIndex = 0;

  final List<Widget> _pages = const [
    ReviewHomePage(),
    MyReviewsPage(),
    ProfilePage(),
  ];

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    super.didChangeAppLifecycleState(state);
    if (state == AppLifecycleState.resumed) {
      final uid = FirebaseAuth.instance.currentUser?.uid;
      if (uid != null) {
        print('🔄 App ripresa – Forzando aggiornamento stato Premium per $uid');
        PremiumManager.forceRefresh(uid);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    // Verifica se l'utente è loggato. Se no, MainNavigation non dovrebbe essere mostrata affatto
    // grazie allo StreamBuilder in InitAppWrapper. Questo è un controllo di sicurezza aggiuntivo.
    final currentUser = FirebaseAuth.instance.currentUser;
    if (currentUser == null) {
        // Questo non dovrebbe accadere se InitAppWrapper funziona correttamente,
        // ma come fallback, potresti mostrare una pagina di errore o di login.
        // Per ora, consideriamo che InitAppWrapper gestisca questo.
        print("[MainNavigation] Tentativo di build senza utente loggato. Questo non dovrebbe succedere.");
        // Potrebbe essere meglio non ritornare ReviewHomePage qui per evitare loop o stati UI imprevisti.
        // Idealmente, InitAppWrapper non dovrebbe mai arrivare a costruire MainNavigation senza un utente.
        return const Scaffold(body: Center(child: Text("Errore: Utente non autenticato.")));
    }

    final S localizations = S.of(context)!;

    return Scaffold(
      body: IndexedStack(
        index: _currentIndex,
        children: _pages,
      ),
      bottomNavigationBar: NavigationBar(
        selectedIndex: _currentIndex,
        onDestinationSelected: (int index) {
          setState(() => _currentIndex = index);
        },
        destinations: [
          NavigationDestination(
            icon: const Icon(Icons.map_outlined),
            selectedIcon: const Icon(Icons.map),
            label: localizations.navigationReviews,
          ),
          NavigationDestination(
            icon: const Icon(Icons.list_alt_outlined),
            selectedIcon: const Icon(Icons.list_alt),
            label: localizations.navigationMyReviews,
          ),
          NavigationDestination(
            icon: const Icon(Icons.person_outline),
            selectedIcon: const Icon(Icons.person),
            label: localizations.navigationProfile,
          ),
        ],
      ),
    );
  }
}
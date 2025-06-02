import 'package:flutter/material.dart';

// Import per la localizzazione (ASSUMENDO che il tuo file generato sia qui e definisca 'S')
import 'package:jetpin_app/l10n/app_localizations.dart'; // Sostituisci 'jetpin_app' con il nome del tuo package se diverso

class JetPinAppBar extends StatelessWidget implements PreferredSizeWidget {
  const JetPinAppBar({super.key});

  static const String _logoAssetPath = 'assets/images/jetpin_logo.png';

  @override
  Widget build(BuildContext context) {
    // CORREZIONE: Aggiunto '!'
    final S localizations = S.of(context)!;

    return AppBar(
      title: Image.asset(
        _logoAssetPath,
        height: 48, 
        fit: BoxFit.contain,
        errorBuilder: (BuildContext context, Object error, StackTrace? stackTrace) {
          // Log dell'errore per debug, se necessario
          // print('Errore caricamento logo AppBar: $error');
          return Text(
            localizations.jetpinAppBarLogoError, // Chiave da ARB
            style: const TextStyle(fontSize: 12, color: Colors.redAccent),
          );
        },
      ),
      centerTitle: false,
      // elevation: 1.0, // Esempio per una leggera ombra se desiderato
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
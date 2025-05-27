import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart';
import 'package:flutter/services.dart';
import 'dart:convert';

void main() {
  runApp(const JetPinApp());
}

class JetPinApp extends StatefulWidget {
  const JetPinApp({Key? key}) : super(key: key);

  @override
  _JetPinAppState createState() => _JetPinAppState();
}

class _JetPinAppState extends State<JetPinApp> {
  Map<String, String> localizedStrings = {};

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    loadLocalizedStrings();
  }

  Future<void> loadLocalizedStrings() async {
    Locale locale = Localizations.localeOf(context);
    String jsonString = await rootBundle.loadString('assets/lang/\${locale.languageCode}.json');
    Map<String, dynamic> jsonMap = json.decode(jsonString);
    setState(() {
      localizedStrings = jsonMap.map((key, value) => MapEntry(key, value.toString()));
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'JetPin',
      localizationsDelegates: const [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: const [
        Locale('en', ''),
        Locale('it', ''),
      ],
      home: Scaffold(
        appBar: AppBar(
          title: Text(localizedStrings['title'] ?? 'JetPin'),
        ),
        body: Center(
          child: Text(localizedStrings['welcome'] ?? 'Welcome'),
        ),
      ),
    );
  }
}

import 'package:app/screens/pdf_view.dart';
import 'package:app/screens/search_page.dart';
import 'package:app/screens/intro_page.dart';
import 'package:flutter/material.dart';
import 'theme.dart';
import 'util.dart';

void main() {
  runApp(const ChatApp());
}

class ChatApp extends StatelessWidget {
  const ChatApp({super.key});

  @override
  Widget build(BuildContext context) {
    TextTheme textTheme = createTextTheme(
      context,
      "Inter",
      "Plus Jakarta Sans",
    );
    
    MaterialTheme theme = MaterialTheme(textTheme);
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Mam AI Chat',
      theme: theme.light(),
      home: const IntroPage(),
      routes: {
        '/chat': (context) => const SearchPage(),
        '/pdf': (context) => const PdfView(),
      },
    );
  }
}

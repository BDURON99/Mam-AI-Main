import 'package:flutter/material.dart';
import 'package:flutter_pdfview/flutter_pdfview.dart';
import '../theme.dart';

const DEEP_RED_BRAND_COLOR = Color.fromARGB(255, 170, 43, 66);

class PdfView extends StatelessWidget {
  const PdfView({super.key});

  @override
  Widget build(BuildContext context) {
    PdfViewArguments args =
        ModalRoute.of(context)!.settings.arguments as PdfViewArguments;

    print(args.path);
    print(args.page);

    return Material(
      child: Scaffold(
        appBar: AppBar(
          toolbarHeight: 80,
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(bottom: Radius.circular(20)),
          ),
          iconTheme: IconThemeData(color: Colors.white),
          title: Text(args.title, style: const TextStyle(color: Colors.white)),
          centerTitle: true,
          backgroundColor: DEEP_RED_BRAND_COLOR,
        ),
        body: PDFView(
          filePath: args.path,
          // enableSwipe: true,
          // swipeHorizontal: true,
          autoSpacing: false,
          pageFling: false,
          defaultPage: args.page,
          backgroundColor: Colors.grey,
        ),
      ),
    );
  }
}

class PdfViewArguments {
  const PdfViewArguments({
    required this.path,
    required this.title,
    required this.page,
  });
  final String path;
  final String title;
  final int page;
}

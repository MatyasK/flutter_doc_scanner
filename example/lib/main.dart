import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_doc_scanner/flutter_doc_scanner.dart';
import 'package:flutter_doc_scanner/models/scan_result.dart';
import 'package:flutter_pdfview/flutter_pdfview.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  DocumentScanResult? _scannedDocuments;
  List<String> _imageFiles = [];
  int _currentPage = 0;
  int _totalPages = 0;

  Future<void> scanDocument() async {
    DocumentScanResult? scannedDocuments;
    try {
      scannedDocuments = await FlutterDocScanner().getScanDocuments();
    } on PlatformException catch (e) {
      debugPrint('Failed to get scanned documents: ${e.message}');
    }

    if (!mounted) return;
    setState(() {
      _scannedDocuments = scannedDocuments;
      if (scannedDocuments?.pageUris != null) {
        _imageFiles = scannedDocuments!.pageUris!;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Document Scanner example app'),
        ),
        body: Column(
          children: [
            if (_scannedDocuments == null)
              const Expanded(
                child: Center(
                  child: Text("No Documents Scanned"),
                ),
              )
            else
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      if (_scannedDocuments?.pdfUri != null) ...[
                        const Padding(
                          padding: EdgeInsets.all(8.0),
                          child: Text('PDF Document:',
                              style: TextStyle(fontWeight: FontWeight.bold)),
                        ),
                        SizedBox(
                          height: 400,
                          child: Stack(
                            children: [
                              PDFView(
                                filePath: _scannedDocuments!.pdfUri!,
                                enableSwipe: true,
                                swipeHorizontal: true,
                                autoSpacing: true,
                                pageFling: true,
                                pageSnap: true,
                                defaultPage: _currentPage,
                                onRender: (pages) {
                                  setState(() {
                                    _totalPages = pages!;
                                  });
                                },
                                onPageChanged: (page, total) {
                                  setState(() {
                                    _currentPage = page!;
                                  });
                                },
                                onError: (error) {
                                  debugPrint('PDF Error: $error');
                                },
                              ),
                              Positioned(
                                bottom: 16,
                                left: 0,
                                right: 0,
                                child: Center(
                                  child: Container(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 12, vertical: 4),
                                    decoration: BoxDecoration(
                                      color: Colors.black54,
                                      borderRadius: BorderRadius.circular(16),
                                    ),
                                    child: Text(
                                      'Page ${_currentPage + 1} of $_totalPages',
                                      style: const TextStyle(
                                        color: Colors.white,
                                        fontSize: 16,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        const Divider(height: 32),
                      ],
                      if (_imageFiles.isNotEmpty) ...[
                        const Padding(
                          padding: EdgeInsets.all(8.0),
                          child: Text('Individual Pages:',
                              style: TextStyle(fontWeight: FontWeight.bold)),
                        ),
                        ...List.generate(_imageFiles.length, (index) {
                          return Card(
                            margin: const EdgeInsets.all(8.0),
                            child: Column(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Text('Page ${index + 1}'),
                                ),
                                Image.file(
                                  File(_imageFiles[index]),
                                  fit: BoxFit.contain,
                                ),
                              ],
                            ),
                          );
                        }),
                      ],
                    ],
                  ),
                ),
              ),
          ],
        ),
        floatingActionButton: Padding(
          padding: const EdgeInsets.only(bottom: 16.0),
          child: FloatingActionButton.extended(
            onPressed: scanDocument,
            label: const Text("Scan Document"),
            icon: const Icon(Icons.document_scanner),
          ),
        ),
      ),
    );
  }
}

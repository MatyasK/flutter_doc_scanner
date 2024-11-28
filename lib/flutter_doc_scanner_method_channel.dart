import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:pdf/widgets.dart' as pw;

import 'flutter_doc_scanner_platform_interface.dart';
import 'models/scan_result.dart';

/// An implementation of [FlutterDocScannerPlatform] that uses method channels.
class MethodChannelFlutterDocScanner extends FlutterDocScannerPlatform {
  /// The method channel used to interact with the native platform.
  @visibleForTesting
  final methodChannel = const MethodChannel('flutter_doc_scanner');

  @override
  Future<String?> getPlatformVersion() async {
    final version =
        await methodChannel.invokeMethod<String>('getPlatformVersion');
    return version;
  }

  @override
  Future<DocumentScanResult> getScanDocuments() async {
    final Map<String, dynamic>? result = await methodChannel
        .invokeMapMethod<String, dynamic>('getScanDocuments');
    if (result == null) throw Exception('Failed to get scan documents');
    final scanResult = DocumentScanResult.fromMap(result);
    final pdfUri = await getPdfUri(scanResult);
    return scanResult.copyWith(pdfUri: pdfUri);
  }

  @override
  Future<DocumentScanResult> getScanDocumentsUri() async {
    final Map<String, dynamic>? result = await methodChannel
        .invokeMapMethod<String, dynamic>('getScanDocumentsUri');
    if (result == null) throw Exception('Failed to get scan documents');
    return DocumentScanResult.fromMap(result);
  }
}

/// Gets the PDF URI regardless of platform.
/// On Android, returns the native PDF URI.
/// On iOS, generates a PDF from the scanned images.
Future<String> getPdfUri(DocumentScanResult result) async {
  // If we already have a PDF URI (Android), return it
  if (result.pdfUri != null) {
    return result.pdfUri!;
  }

  // If we have page URIs (iOS), generate PDF
  if (result.pageUris != null && result.pageUris!.isNotEmpty) {
    print('[DocumentScanner]: generating PDF from pageUris: $result.pageUris');
    final pdf = pw.Document();

    for (final pageUri in result.pageUris!) {
      final image = File(pageUri);
      final imageBytes = await image.readAsBytes();
      final pdfImage = pw.MemoryImage(imageBytes);

      pdf.addPage(
        pw.Page(
          build: (context) {
            return pw.Center(
              child: pw.Image(pdfImage, fit: pw.BoxFit.contain),
            );
          },
        ),
      );
    }

    // Save the PDF to the same directory as the images
    final directory = Directory(result.pageUris!.first).parent;
    final pdfPath =
        '${directory.path}/scan_${DateTime.now().millisecondsSinceEpoch}.pdf';
    final file = File(pdfPath);
    await file.writeAsBytes(await pdf.save());

    return pdfPath;
  }

  throw Exception('No PDF URI or page images available');
}

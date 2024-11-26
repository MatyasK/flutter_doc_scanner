import 'dart:io';
import 'package:path/path.dart' as path;
import 'package:path_provider/path_provider.dart';

class DocumentScanResult {
  final String? pdfUri;
  final int? pageCount;
  final List<String>? pageUris;

  DocumentScanResult._({
    this.pdfUri,
    this.pageCount,
    this.pageUris,
  });

  static Future<DocumentScanResult> fromMap(Map<String, dynamic> map) async {
    String? processedPdfUri;
    List<String>? processedPageUris;

    // Process PDF URI if available
    if (map['pdfUri'] != null) {
      processedPdfUri = await _processUri(map['pdfUri'] as String);
    }

    // Process page URIs if available
    if (map['Uri'] != null) {
      final uris = (map['Uri'] as String).split(', ');
      processedPageUris = [];
      for (final uri in uris) {
        final processedUri = await _processUri(uri);
        processedPageUris.add(processedUri);
      }
    }

    return DocumentScanResult._(
      pdfUri: processedPdfUri,
      pageCount: map['pageCount'] as int?,
      pageUris: processedPageUris,
    );
  }

  static Future<String> _processUri(String uri) async {
    final filePath = uri.replaceFirst('file://', '');
    
    if (filePath.startsWith('content://')) {
      final bytes = await File(filePath).readAsBytes();
      final tempDir = await getTemporaryDirectory();
      final tempFile = File(path.join(tempDir.path, path.basename(filePath)));
      await tempFile.writeAsBytes(bytes);
      return tempFile.path;
    }
    return filePath;
  }
}

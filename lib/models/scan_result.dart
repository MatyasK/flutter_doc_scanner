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
      processedPdfUri = _processUri(map['pdfUri'] as String);
    }

    // Process page URIs if available
    if (map['Uri'] != null) {
      final uris = (map['Uri'] as String).split(', ');
      processedPageUris = [];
      for (final uri in uris) {
        final processedUri = _processUri(uri);
        processedPageUris.add(processedUri);
      }
    }

    return DocumentScanResult._(
      pdfUri: processedPdfUri,
      pageCount: map['pageCount'] as int?,
      pageUris: processedPageUris,
    );
  }

  static String _processUri(String uri) => uri.replaceFirst('file://', '');
}

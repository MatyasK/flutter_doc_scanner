class DocumentScanResult {
  final String? pdfUri;
  final int? pageCount;
  final List<String>? pageUris;

  const DocumentScanResult({
    this.pdfUri,
    this.pageCount,
    this.pageUris,
  });

  factory DocumentScanResult.fromMap(Map<String, dynamic> map) {
    return DocumentScanResult(
      pdfUri: map['pdfUri']?.toString().replaceFirst('file://', ''),
      pageCount: map['pageCount'] as int?,
      pageUris: map['Uri']?.toString().split(', ')
          .map((uri) => uri.replaceFirst('file://', ''))
          .toList(),
    );
  }

  /// Creates a copy of this DocumentScanResult with the given fields replaced with new values
  DocumentScanResult copyWith({
    String? pdfUri,
    int? pageCount,
    List<String>? pageUris,
  }) {
    return DocumentScanResult(
      pdfUri: pdfUri ?? this.pdfUri,
      pageCount: pageCount ?? this.pageCount,
      pageUris: pageUris ?? this.pageUris,
    );
  }
}

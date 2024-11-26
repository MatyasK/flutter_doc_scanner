import 'package:flutter_doc_scanner/flutter_doc_scanner.dart';
import 'package:flutter_doc_scanner/flutter_doc_scanner_method_channel.dart';
import 'package:flutter_doc_scanner/flutter_doc_scanner_platform_interface.dart';
import 'package:flutter_doc_scanner/models/scan_result.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:plugin_platform_interface/plugin_platform_interface.dart';

class MockFlutterDocScannerPlatform
    with MockPlatformInterfaceMixin
    implements FlutterDocScannerPlatform {
  @override
  Future<String?> getPlatformVersion() => Future.value('42');

  @override
  Future<DocumentScanResult> getScanDocuments() => Future.value(
        DocumentScanResult.fromMap({
          'pdfUri': 'test.pdf',
          'pageCount': 1,
          'Uri': 'test.jpg',
        }),
      );

  @override
  Future<DocumentScanResult> getScanDocumentsUri() => Future.value(
        DocumentScanResult.fromMap({
          'pdfUri': 'test.pdf',
          'pageCount': 1,
          'Uri': 'test.jpg',
        }),
      );
}

void main() {
  final FlutterDocScannerPlatform initialPlatform =
      FlutterDocScannerPlatform.instance;

  test('$MethodChannelFlutterDocScanner is the default instance', () {
    expect(initialPlatform, isInstanceOf<MethodChannelFlutterDocScanner>());
  });

  test('getPlatformVersion', () async {
    FlutterDocScanner flutterDocScannerPlugin = FlutterDocScanner();
    MockFlutterDocScannerPlatform fakePlatform =
        MockFlutterDocScannerPlatform();
    FlutterDocScannerPlatform.instance = fakePlatform;

    expect(await flutterDocScannerPlugin.getPlatformVersion(), '42');
  });
}

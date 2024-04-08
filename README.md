# flutter_doc_scanner

A Flutter plugin for document scanning on Android and iOS using ML Kit Document Scanner API and VisionKit.

## Example

Check out the `example` directory for a sample Flutter app using `flutter_doc_scanner`.

## Document Scanner Demo
![Document Scanner Demo](https://github.com/shirsh94/flutter_doc_scanner/blob/main/demo/doc_scan_demo.gif)

## Screenshots
| ![Screenshot 1](https://raw.githubusercontent.com/shirsh94/country_picker_pro/main/assets/Screenshot_first.jpg)  | ![Screenshot 2](https://github.com/shirsh94/country_picker_pro/blob/main/assets/Screenshot_second.jpg?raw=true) | ![Screenshot 3](https://github.com/shirsh94/country_picker_pro/blob/main/assets/Screenshot_third.jpg?raw=true) |
|------------------------------------------------------------------------------------------------------------------|-----------------------------------------------------------------------------------------------------------------|----------------------------------------------------------------------------------------------------------------|
| ![Screenshot 4](https://raw.githubusercontent.com/shirsh94/country_picker_pro/main/assets/Screenshot_fourth.jpg) | ![Screenshot 5](https://github.com/shirsh94/country_picker_pro/blob/main/assets/Screenshot_fifth.jpg?raw=true)  | ![Screenshot 6](https://github.com/shirsh94/country_picker_pro/blob/main/assets/Screenshot_sixth.jpg?raw=true) |


## Features

- High-quality and consistent user interface for digitizing physical documents.
- Accurate document detection with precise corner and edge detection for optimal scanning results.
- Flexible functionality allows users to crop scanned documents, apply filters, remove fingers, remove stains and other blemishes.
- On-device processing helps preserve privacy.
- Support for sending digitized files in PDF and JPEG formats back to your app.
- No need for camera permission.

## Installation

To use this plugin, add `flutter_doc_scanner` as a dependency in your `pubspec.yaml` file.

```yaml
dependencies:
  flutter:
    sdk: flutter
  flutter_doc_scanner: ^0.0.3
```

## Usage

```dart
import 'package:flutter_doc_scanner/flutter_doc_scanner.dart';

// Use the `FlutterDocScanner` class to start the document scanning process.
dynamic scannedDocuments;
try {
  scannedDocuments = await FlutterDocScanner().getScanDocuments() ??
      'Unknown platform documents';
} on PlatformException {
  scannedDocuments = 'Failed to get scanned documents.';
}
print(scannedDocuments.toString());
```

## Screenshots

| ![Screenshot 1](https://github.com/shirsh94/flutter_doc_scanner/blob/main/demo/screen_shot_1.jpg) | ![Screenshot 2](https://github.com/shirsh94/flutter_doc_scanner/blob/main/demo/screen_shot_2.jpg) |

## Issues and Feedback

Please file [issues](https://github.com/shirsh94/flutter_doc_scanner/issues) to send feedback or report a bug. Thank you!

## License

The MIT License (MIT) Copyright (c) 2024 Shirsh Shukla

Permission is hereby granted, free of charge, to any person obtaining a copy of this software and
associated documentation files (the "Software"), to deal in the Software without restriction,
including without limitation the rights to use, copy, modify, merge, publish, distribute,
sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all copies or substantial
portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT
NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND
NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES
OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN
CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
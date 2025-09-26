import 'dart:async';
import 'dart:html' as html;
import 'dart:typed_data';

import 'package:flutter/foundation.dart';
import 'dart:js_util' as js_util;

const String _pdfLibScriptId = '_pdf_lib_script';
const String _pdfLibSrc =
    'https://cdn.jsdelivr.net/npm/pdf-lib@1.17.1/dist/pdf-lib.min.js';

Future<void> _loadPdfLibIfNeeded() {
  if (!kIsWeb) {
    return Future.error(
      UnsupportedError('PDF 병합은 현재 웹 플랫폼에서만 지원됩니다.'),
    );
  }

  final existingScript = html.document.getElementById(_pdfLibScriptId);
  if (existingScript != null) {
    final script = existingScript as html.ScriptElement;
    if (script.dataset['loaded'] == 'true') {
      return Future.value();
    }

    final completer = Completer<void>();
    script.onLoad.first.then((_) => completer.complete());
    script.onError.first.then((event) {
      completer.completeError(StateError('pdf-lib 스크립트를 불러오지 못했습니다.'));
    });
    return completer.future;
  }

  final completer = Completer<void>();
  final script = html.ScriptElement()
    ..id = _pdfLibScriptId
    ..src = _pdfLibSrc
    ..type = 'application/javascript';

  script.onLoad.first.then((_) {
    script.dataset['loaded'] = 'true';
    completer.complete();
  });
  script.onError.first.then((event) {
    completer.completeError(StateError('pdf-lib 스크립트를 불러오지 못했습니다.'));
  });

  html.document.head?.append(script);
  return completer.future;
}

Future<Uint8List> mergePdfBytes(List<Uint8List> pdfByteChunks) async {
  if (pdfByteChunks.isEmpty) {
    throw ArgumentError('병합할 PDF 데이터가 없습니다.');
  }

  await _loadPdfLibIfNeeded();

  final pdfLib = js_util.getProperty(js_util.globalThis, 'PDFLib');
  if (pdfLib == null) {
    throw StateError('pdf-lib 라이브러리를 로드하지 못했습니다.');
  }

  final pdfDocument = js_util.getProperty(pdfLib, 'PDFDocument');
  final mergedDoc = await js_util.promiseToFuture<dynamic>(
    js_util.callMethod(pdfDocument, 'create', []),
  );

  final typedArrayConstructor =
      js_util.getProperty(js_util.globalThis, 'Uint8Array');

  for (final chunk in pdfByteChunks) {
    final jsBytes = js_util.callConstructor(typedArrayConstructor, [chunk]);
    final sourceDoc = await js_util.promiseToFuture<dynamic>(
      js_util.callMethod(pdfDocument, 'load', [jsBytes]),
    );

    final pageCount =
        (js_util.callMethod(sourceDoc, 'getPageCount', []) as num).toInt();
    if (pageCount == 0) {
      continue;
    }

    final pageIndices = List<int>.generate(pageCount, (index) => index);
    final copiedPages = await js_util.promiseToFuture<List<dynamic>>(
      js_util.callMethod(
        mergedDoc,
        'copyPages',
        [sourceDoc, js_util.jsify(pageIndices)],
      ),
    );

    for (final page in copiedPages) {
      js_util.callMethod(mergedDoc, 'addPage', [page]);
    }
  }

  final savedBytes = await js_util.promiseToFuture<dynamic>(
    js_util.callMethod(mergedDoc, 'save', []),
  );

  final List<int> dartBytes =
      List<int>.from(js_util.dartify(savedBytes) as List<dynamic>);
  return Uint8List.fromList(dartBytes);
}

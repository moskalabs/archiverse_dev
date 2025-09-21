import 'dart:convert';
import 'dart:typed_data';
import 'package:http/http.dart' as http;
import 'package:syncfusion_flutter_pdf/pdf.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'dart:html'; // For web-specific download

/// Fetches document URLs for a given class from multiple Supabase tables.
/// This is a private helper function.
Future<List<String>> _getClassDocuments(String classId, SupabaseClient supabase) async {
  List<String> urls = [];
  print('Fetching documents for class ID: $classId');

  // A helper to safely extract URLs from a query response
  void addUrlsFromResponse(List<Map<String, dynamic>> data, String tableName) {
    if (data.isNotEmpty) {
      for (var row in data) {
        final url = row['url'];
        if (url != null && url is String && url.isNotEmpty) {
          urls.add(url);
        }
      }
    }
    print('Found ${data.length} documents in $tableName');
  }

  // Define all tables to query
  final tablesToQuery = {
    'class': 'id',
    'subjectportpolio': 'class',
    'midterm_results': 'class',
    'final_results': 'class',
    'courseplan': 'class',
    'gradesheet': 'class',
  };

  for (var table in tablesToQuery.entries) {
    try {
      final response = await supabase.from(table.key).select('url').eq(table.value, classId);
      addUrlsFromResponse(response, table.key);
    } catch (e) {
      print('Error fetching from ${table.key} table: $e');
    }
  }

  print('Total documents found: ${urls.length}');
  return urls;
}


/// The main public function to be called from the UI.
/// It orchestrates fetching URLs, merging PDFs, and triggering the download.
Future<void> generateAndDownloadPortfolio({
  required String classId,
  required String firstCoverUrl,
  required String lastCoverUrl,
}) async {
  final supabase = Supabase.instance.client;

  // 1. Fetch all content URLs
  final contentUrls = await _getClassDocuments(classId, supabase);

  if (contentUrls.isEmpty) {
    print('No content documents found for class $classId. Aborting.');
    throw Exception('다운로드할 문서가 없습니다.');
  }

  // 2. Prepare the full list of URLs
  List<String> allPdfUrls = [];
  if (firstCoverUrl.isNotEmpty) allPdfUrls.add(firstCoverUrl);
  allPdfUrls.addAll(contentUrls);
  if (lastCoverUrl.isNotEmpty) allPdfUrls.add(lastCoverUrl);

  // 3. Merge and download
  final PdfDocument finalDoc = PdfDocument();
  finalDoc.pageSettings.margins.all = 0;

  try {
    for (final url in allPdfUrls) {
      try {
        final response = await http.get(Uri.parse(url)).timeout(const Duration(minutes: 2));
        if (response.statusCode == 200) {
          final sourceDoc = PdfDocument(inputBytes: response.bodyBytes);
          for (int i = 0; i < sourceDoc.pages.count; i++) {
            finalDoc.importPage(sourceDoc, i);
          }
          sourceDoc.dispose();
        } else {
          print('Failed to download $url: Status ${response.statusCode}');
        }
      } catch (e) {
        print('Error processing URL $url: $e. Skipping.');
      }
    }

    if (finalDoc.pages.count == 0) {
      throw Exception('PDF 생성에 실패했습니다. 유효한 문서가 없습니다.');
    }

    final bytes = await finalDoc.save();
    final fileName = 'portfolio_${classId}_${DateTime.now().toIso8601String().split('T').first}.pdf';

    final base64 = base64Encode(bytes);
    final anchor = AnchorElement(href: 'data:application/octet-stream;base64,$base64')
      ..setAttribute('download', fileName)
      ..click();
    document.body?.children.remove(anchor);

  } catch (e) {
    print('A critical error occurred during the merge process: $e');
    rethrow; // Rethrow to be caught by the UI
  } finally {
    finalDoc.dispose();
  }
}

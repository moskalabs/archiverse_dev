import 'dart:convert';
import 'dart:typed_data';
import 'package:http/http.dart' as http;
import 'package:syncfusion_flutter_pdf/pdf.dart';
import 'dart:html'; // For web-specific download

// Assuming these are part of the FlutterFlow project structure
import '/backend/supabase/supabase.dart';
import '/flutter_flow/flutter_flow_util.dart';

// --- HELPER FUNCTION ---

/// Fetches all necessary document URLs for a given class from Supabase.
/// This includes class documents, portfolios, and assessment results.
Future<List<String>> getClassDocuments(String classId) async {
  List<String> urls = [];
  print('Fetching documents for class ID: $classId');

  // 1. Get base documents from the 'class' table
  try {
    final classData = await ClassTable().queryRows(
      queryFn: (q) => q.eq('id', classId),
    );
    if (classData.isNotEmpty &&
        classData.first.url != null &&
        classData.first.url!.isNotEmpty) {
      urls.add(classData.first.url!);
      print('Found class document: ${classData.first.url!}');
    }
  } catch (e) {
    print('Error fetching from ClassTable: $e');
  }

  // 2. Get student portfolios from 'subjectportpolio'
  try {
    final portfolioData = await SubjectportpolioTable().queryRows(
      queryFn: (q) => q.eq('class', classId).order('created_date', ascending: true),
    );
    for (var portfolio in portfolioData) {
      if (portfolio.url != null && portfolio.url!.isNotEmpty) {
        urls.add(portfolio.url!);
      }
    }
    print('Found ${portfolioData.length} portfolio documents.');
  } catch (e) {
    print('Error fetching from SubjectportpolioTable: $e');
  }

  // 3. Get midterm and final results
  try {
    final assessmentData = await Future.wait([
      MidtermResultsTable().queryRows(
        queryFn: (q) => q.eq('class', classId),
      ),
      FinalResultsTable().queryRows(
        queryFn: (q) => q.eq('class', classId),
      ),
    ]);

    final combinedResults = assessmentData.expand((list) => list).toList();
    for (var result in combinedResults) {
      if (result.url != null && result.url!.isNotEmpty) {
        urls.add(result.url!);
      }
    }
    print('Found ${combinedResults.length} assessment documents.');
  } catch (e) {
    print('Error fetching from Midterm/Final Results tables: $e');
  }

  print('Total documents found: ${urls.length}');
  return urls;
}


// --- CUSTOM ACTIONS ---

/// Prepares the list of PDFs to be merged by adding covers and content.
/// The list is stored in FFAppState().mergepdfs for the next action to use.
Future<void> mergePdfs(
  String firstCoverUrl,
  List<String> contentUrls,
  String lastCoverUrl,
) async {
  List<String> pdfsToMerge = [];

  if (firstCoverUrl.isNotEmpty) {
    pdfsToMerge.add(firstCoverUrl);
  }

  pdfsToMerge.addAll(contentUrls.where((url) => url.isNotEmpty));

  if (lastCoverUrl.isNotEmpty) {
    pdfsToMerge.add(lastCoverUrl);
  }

  FFAppState().mergepdfs = pdfsToMerge;
  print('Prepared ${FFAppState().mergepdfs.length} PDFs for merging.');
}


/// Downloads, merges, and initiates the download of the final PDF in the browser.
Future<void> mergeAndDownloadPdf(List<String> pdfUrls) async {
  if (pdfUrls.isEmpty) {
    print('No PDF URLs provided to merge.');
    throw Exception('병합할 PDF가 없습니다.');
  }

  final PdfDocument finalDoc = PdfDocument();
  finalDoc.pageSettings.margins.all = 0;

  int processedFiles = 0;
  int totalFiles = pdfUrls.length;
  print('Starting PDF merge process for $totalFiles files.');

  try {
    for (final url in pdfUrls) {
      processedFiles++;
      print('Processing file $processedFiles of $totalFiles...');

      try {
        final response = await http.get(Uri.parse(url)).timeout(const Duration(minutes: 2));

        if (response.statusCode == 200) {
          final PdfDocument sourceDoc = PdfDocument(inputBytes: response.bodyBytes);
          for (int i = 0; i < sourceDoc.pages.count; i++) {
            finalDoc.importPage(sourceDoc, i);
          }
          sourceDoc.dispose();
        } else {
          print('Download failed for $url with status: ${response.statusCode}');
        }
      } catch (e) {
        print('Error processing URL $url: $e. Skipping file.');
      }
    }

    if (finalDoc.pages.count == 0) {
      print('Merge result is empty. No PDF will be downloaded.');
      throw Exception('PDF 생성에 실패했습니다. 유효한 문서가 없습니다.');
    }

    final List<int> bytes = await finalDoc.save();
    final String fileName = 'class_portfolio_${DateTime.now().toIso8601String().split('.').first}.pdf';

    final base64 = base64Encode(bytes);
    final anchor = AnchorElement(href: 'data:application/octet-stream;base64,$base64')
      ..setAttribute('download', fileName)
      ..click();
    document.body?.children.remove(anchor);
    print('Successfully triggered download for $fileName');

  } catch (e) {
    print('A critical error occurred during the merge process: $e');
    throw Exception('PDF 병합 중 오류가 발생했습니다.');
  } finally {
    finalDoc.dispose();
  }
}

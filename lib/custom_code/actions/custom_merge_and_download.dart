// Automatic FlutterFlow imports
import '/backend/schema/structs/index.dart';
import '/backend/schema/enums/enums.dart';
import '/backend/supabase/supabase.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'index.dart'; // Imports other custom actions
import 'package.flutter/material.dart';
// Begin custom action code
// DO NOT REMOVE OR MODIFY THE CODE ABOVE!

Future<void> customMergeAndDownload(int classId) async {
  // TODO: Implement data fetching logic here.
  List<String> pdfUrls = [];

  // Static cover pages
  final String firstCoverUrl =
      'https://ygagwsshehmtfqlkjwmv.supabase.co/storage/v1/object/public/fileupload/setting/PDF_COVER.pdf';
  final String lastCoverUrl =
      'https://ygagwsshehmtfqlkjwmv.supabase.co/storage/v1/object/public/fileupload/setting/20.PDF_COVER_LAST.pdf';

  pdfUrls.add(firstCoverUrl);

  // Fetch data from Supabase
  // 1. 수업계획서 (courseplan)
  final courseplan = await CourseplanTable().queryRows(
    queryFn: (q) => q.eq('class', classId),
  );
  if (courseplan.isNotEmpty) {
    for (var doc in courseplan) {
      if (doc.file != null) {
        pdfUrls.add(doc.file!);
      }
    }
  }

  // 2. 강의계획서 (lecturematerial)
  final lecturematerial = await LecturematerialTable().queryRows(
    queryFn: (q) => q.eq('class', classId),
  );
  if (lecturematerial.isNotEmpty) {
    for (var doc in lecturematerial) {
      if (doc.fileUrl != null) {
        pdfUrls.add(doc.fileUrl!);
      }
    }
  }

  // 3. 성적기록표 (gradesheet)
  final gradesheet = await GradesheetTable().queryRows(
    queryFn: (q) => q.eq('class', classId),
  );
  if (gradesheet.isNotEmpty) {
    for (var doc in gradesheet) {
      if (doc.fileUrl != null) {
        pdfUrls.add(doc.fileUrl!);
      }
    }
  }

  // 4. 소속된 학생들 포트폴리오 (subjectportpolio)
  final courseStudents = await CourseStudentTable().queryRows(
    queryFn: (q) => q.eq('classid', classId),
  );
  if (courseStudents.isNotEmpty) {
    for (var student in courseStudents) {
      final portfolios = await SubjectportpolioTable().queryRows(
        queryFn: (q) =>
            q.eq('class', classId).eq('studentId', student.studentId),
      );
      for (var portfolio in portfolios) {
        if (portfolio.fileUrl != null) {
          pdfUrls.add(portfolio.fileUrl!);
        }
      }
    }
  }

  // 5. 중간 결과물 (midterm_results)
  final midtermResults = await MidtermResultsTable().queryRows(
    queryFn: (q) => q.eq('class', classId),
  );
  if (midtermResults.isNotEmpty) {
    for (var doc in midtermResults) {
      if (doc.fileUrl != null) {
        pdfUrls.add(doc.fileUrl!);
      }
    }
  }

  // 6. 기말 결과물 (final_results)
  final finalResults = await FinalResultsTable().queryRows(
    queryFn: (q) => q.eq('class', classId),
  );
  if (finalResults.isNotEmpty) {
    for (var doc in finalResults) {
      if (doc.fileUrl != null) {
        pdfUrls.add(doc.fileUrl!);
      }
    }
  }

  pdfUrls.add(lastCoverUrl);

  // Call the merge and download action
  await mergeAndDownloadPdf(pdfUrls);
}

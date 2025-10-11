// Automatic FlutterFlow imports
import '/backend/schema/structs/index.dart';
import '/backend/schema/enums/enums.dart';
import '/backend/supabase/supabase.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'index.dart'; // Imports other custom actions
import 'package:flutter/material.dart';
// Begin custom action code
// DO NOT REMOVE OR MODIFY THE CODE ABOVE!

import '/backend/lecture_material_template.dart';
import 'package:syncfusion_flutter_pdf/pdf.dart';

/// 기존 PDF에 강의자료 페이지를 rotation 적용하여 추가하는 함수
Future<void> addLectureMaterialRotation({
  required PdfDocument finalDoc,
  int? classId,
  String? year,
  String? semester,
  String? professorName,
}) async {
  print('======= 강의자료 ROTATION 추가 시작 =======');
  
  // 진행률 업데이트 함수
  void updateProgress(double progress, String message) {
    try {
      FFAppState().update(() {
        FFAppState().downloadProgress = progress.clamp(0.0, 1.0);
        FFAppState().downloadProgressMessage = message;
      });
      print('진행률: ${(progress * 100).toStringAsFixed(1)}% - $message');
    } catch (e) {
      print('진행률 업데이트 실패: $e');
    }
  }
  
  // 강의자료 URL 찾기
  String? lectureMaterialUrl;
  
  if (classId != null) {
    try {
      final lectureMaterialRecords = await LecturematerialTable().queryRows(
        queryFn: (q) => q.eq('class', classId),
      );
      if (lectureMaterialRecords.isNotEmpty) {
        lectureMaterialUrl = lectureMaterialRecords.first.url;
      }
      print('강의자료 URL: $lectureMaterialUrl');
    } catch (e) {
      print('강의자료 URL 조회 실패: $e');
    }
  }
  
  // 강의자료 rotation 적용하여 추가
  if (lectureMaterialUrl != null && lectureMaterialUrl!.isNotEmpty) {
    await LectureMaterialTemplate.addLectureMaterialPages(
      finalDoc: finalDoc,
      lectureMaterialUrl: lectureMaterialUrl!,
      year: year ?? '2025',
      semester: semester ?? '1학기',
      professorName: professorName ?? '교수명',
      updateProgress: updateProgress,
      startProgress: 0.8,
      endProgress: 0.95,
    );
  } else {
    print('강의자료 URL이 없음: $lectureMaterialUrl');
    updateProgress(0.95, '강의자료 없음 - 스킵');
  }
  
  print('======= 강의자료 ROTATION 추가 완료 =======');
}
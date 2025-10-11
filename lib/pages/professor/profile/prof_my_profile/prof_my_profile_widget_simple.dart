import 'package:flutter/material.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'prof_my_profile_model.dart';
export 'prof_my_profile_model.dart';

// 간단한 테스트 버전
class ProfMyProfileWidgetSimple extends StatefulWidget {
  const ProfMyProfileWidgetSimple({super.key});

  static String routeName = 'Prof_MyProfile_Simple';
  static String routePath = '/profMyProfileSimple';

  @override
  State<ProfMyProfileWidgetSimple> createState() => _ProfMyProfileWidgetSimpleState();
}

class _ProfMyProfileWidgetSimpleState extends State<ProfMyProfileWidgetSimple> {
  late ProfMyProfileModel _model;
  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => ProfMyProfileModel());
  }

  @override
  void dispose() {
    _model.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      backgroundColor: FlutterFlowTheme.of(context).secondaryBackground,
      appBar: AppBar(
        title: Text('교수 마이페이지'),
        backgroundColor: Color(0xFF284E75),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              '교수 마이페이지',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 20),
            Text('페이지 로딩 테스트 중...'),
          ],
        ),
      ),
    );
  }
}

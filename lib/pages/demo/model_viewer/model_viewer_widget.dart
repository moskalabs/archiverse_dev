import '/backend/supabase/supabase.dart';
import '/flutter_flow/flutter_flow_icon_button.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import '/flutter_flow/upload_data.dart';
import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';

import 'model_viewer_model.dart';
export 'model_viewer_model.dart';

class ModelViewerWidget extends StatefulWidget {
  const ModelViewerWidget({super.key});

  static const routeName = 'ModelViewer';
  static const routePath = '/model-viewer';

  @override
  State<ModelViewerWidget> createState() => _ModelViewerWidgetState();
}

class _ModelViewerWidgetState extends State<ModelViewerWidget> {
  late ModelViewerModel _model;
  InAppWebViewController? _webViewController;

  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => ModelViewerModel());
  }

  @override
  void dispose() {
    _model.dispose();
    super.dispose();
  }

  String _getHtmlContent() {
    final modelUrl = _model.selectedModelUrl ??
        'https://raw.githubusercontent.com/KhronosGroup/glTF-Sample-Models/master/2.0/BoomBox/glTF-Binary/BoomBox.glb';

    return '''<!DOCTYPE html>
<html>
<head>
  <meta charset="utf-8">
  <meta name="viewport" content="width=device-width, initial-scale=1">
  <script type="module" src="https://ajax.googleapis.com/ajax/libs/model-viewer/3.5.0/model-viewer.min.js"></script>
  <style>
    * { margin: 0; padding: 0; box-sizing: border-box; }
    html, body {
      width: 100%;
      height: 100%;
      overflow: hidden;
    }
    body {
      background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
      display: flex;
      align-items: center;
      justify-content: center;
    }
    model-viewer {
      width: 100%;
      height: 100%;
      background-color: transparent;
    }
  </style>
</head>
<body>
  <model-viewer
    src="$modelUrl"
    alt="3D Model"
    auto-rotate
    camera-controls
    shadow-intensity="1"
    exposure="1"
    camera-orbit="45deg 75deg 2.5m">
  </model-viewer>
</body>
</html>''';
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        key: scaffoldKey,
        backgroundColor: FlutterFlowTheme.of(context).primaryBackground,
        appBar: AppBar(
          backgroundColor: FlutterFlowTheme.of(context).primary,
          automaticallyImplyLeading: false,
          leading: FlutterFlowIconButton(
            borderColor: Colors.transparent,
            borderRadius: 30,
            borderWidth: 1,
            buttonSize: 60,
            icon: Icon(
              Icons.arrow_back_rounded,
              color: Colors.white,
              size: 30,
            ),
            onPressed: () async {
              context.pop();
            },
          ),
          title: Text(
            '3D Model Viewer',
            style: FlutterFlowTheme.of(context).headlineMedium.override(
                  fontFamily: 'Outfit',
                  color: Colors.white,
                  fontSize: 22,
                  letterSpacing: 0.0,
                ),
          ),
          actions: [],
          centerTitle: true,
          elevation: 2,
        ),
        body: SafeArea(
          top: true,
          child: Column(
            mainAxisSize: MainAxisSize.max,
            children: [
              // 상단 정보 영역
              Container(
                width: double.infinity,
                decoration: BoxDecoration(
                  color: FlutterFlowTheme.of(context).secondaryBackground,
                  boxShadow: [
                    BoxShadow(
                      blurRadius: 3,
                      color: Color(0x33000000),
                      offset: Offset(0, 1),
                    )
                  ],
                ),
                child: Padding(
                  padding: EdgeInsetsDirectional.fromSTEB(24, 16, 24, 16),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        '건축 3D 모델 뷰어 데모',
                        style: FlutterFlowTheme.of(context).headlineSmall.override(
                              fontFamily: 'Outfit',
                              letterSpacing: 0.0,
                            ),
                      ),
                      SizedBox(height: 8),
                      Text(
                        'Google Model Viewer 기반 3D 모델을 표시합니다.',
                        style: FlutterFlowTheme.of(context).bodyMedium.override(
                              fontFamily: 'Readex Pro',
                              color: FlutterFlowTheme.of(context).secondaryText,
                              letterSpacing: 0.0,
                            ),
                      ),
                    ],
                  ),
                ),
              ),

              // 파일 업로드 버튼
              Padding(
                padding: EdgeInsetsDirectional.fromSTEB(24, 24, 24, 0),
                child: FFButtonWidget(
                  onPressed: () async {
                    final selectedFiles = await selectFiles(
                      allowedExtensions: ['glb', 'gltf', 'skp'],
                      multiFile: false,
                    );
                    if (selectedFiles != null && selectedFiles.isNotEmpty) {
                      setState(() {
                        _model.isDataUploading = true;
                        _model.uploadedLocalFile = FFUploadedFile(
                          name: selectedFiles.first.storagePath.split('/').last,
                          bytes: selectedFiles.first.bytes,
                        );
                      });

                      try {
                        // Upload to Supabase Storage
                        final fileName = '${DateTime.now().millisecondsSinceEpoch}_${_model.uploadedLocalFile.name}';
                        await SupaFlow.client.storage
                            .from('3d-models')
                            .uploadBinary(
                              fileName,
                              _model.uploadedLocalFile.bytes!,
                            );

                        // Get public URL
                        final publicUrl = SupaFlow.client.storage
                            .from('3d-models')
                            .getPublicUrl(fileName);

                        setState(() {
                          _model.uploadedFileUrl = publicUrl;
                          _model.selectedModelUrl = publicUrl;
                          _model.isDataUploading = false;
                        });

                        // Reload WebView with new model
                        if (_webViewController != null) {
                          await _webViewController!.loadData(data: _getHtmlContent());
                        }

                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text('파일이 업로드되었습니다!'),
                            backgroundColor: FlutterFlowTheme.of(context).success,
                            duration: Duration(seconds: 2),
                          ),
                        );
                      } catch (e) {
                        setState(() {
                          _model.isDataUploading = false;
                        });

                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text('업로드 실패: ${e.toString()}'),
                            backgroundColor: FlutterFlowTheme.of(context).error,
                            duration: Duration(seconds: 3),
                          ),
                        );
                      }
                    }
                  },
                  text: _model.isDataUploading ? '업로드 중...' : '3D 모델 파일 업로드',
                  icon: Icon(
                    _model.isDataUploading ? Icons.hourglass_empty : Icons.upload_file,
                    size: 20,
                  ),
                  options: FFButtonOptions(
                    width: double.infinity,
                    height: 50,
                    padding: EdgeInsetsDirectional.fromSTEB(0, 0, 0, 0),
                    iconPadding: EdgeInsetsDirectional.fromSTEB(0, 0, 0, 0),
                    color: FlutterFlowTheme.of(context).primary,
                    textStyle: FlutterFlowTheme.of(context).titleSmall.override(
                          fontFamily: 'Readex Pro',
                          color: Colors.white,
                          letterSpacing: 0.0,
                        ),
                    elevation: 2,
                    borderSide: BorderSide(
                      color: Colors.transparent,
                      width: 1,
                    ),
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
              ),

              // 파일 정보 표시
              if (_model.uploadedLocalFile.bytes?.isNotEmpty ?? false)
                Padding(
                  padding: EdgeInsetsDirectional.fromSTEB(24, 16, 24, 0),
                  child: Container(
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: FlutterFlowTheme.of(context).accent1,
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(
                        color: FlutterFlowTheme.of(context).primary,
                        width: 1,
                      ),
                    ),
                    child: Padding(
                      padding: EdgeInsetsDirectional.fromSTEB(16, 12, 16, 12),
                      child: Row(
                        mainAxisSize: MainAxisSize.max,
                        children: [
                          Icon(
                            Icons.check_circle,
                            color: FlutterFlowTheme.of(context).primary,
                            size: 24,
                          ),
                          SizedBox(width: 12),
                          Expanded(
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  '업로드된 파일',
                                  style: FlutterFlowTheme.of(context)
                                      .bodySmall
                                      .override(
                                        fontFamily: 'Readex Pro',
                                        letterSpacing: 0.0,
                                      ),
                                ),
                                Text(
                                  _model.uploadedLocalFile.name ?? 'Unknown',
                                  style: FlutterFlowTheme.of(context)
                                      .bodyMedium
                                      .override(
                                        fontFamily: 'Readex Pro',
                                        fontWeight: FontWeight.w600,
                                        letterSpacing: 0.0,
                                      ),
                                ),
                                Text(
                                  '크기: ${(_model.uploadedLocalFile.bytes!.length / 1024 / 1024).toStringAsFixed(2)} MB',
                                  style: FlutterFlowTheme.of(context)
                                      .bodySmall
                                      .override(
                                        fontFamily: 'Readex Pro',
                                        color: FlutterFlowTheme.of(context).secondaryText,
                                        letterSpacing: 0.0,
                                      ),
                                ),
                              ],
                            ),
                          ),
                          if (_model.uploadedFileUrl.isNotEmpty)
                            FlutterFlowIconButton(
                              borderColor: FlutterFlowTheme.of(context).primary,
                              borderRadius: 8,
                              borderWidth: 1,
                              buttonSize: 40,
                              fillColor: FlutterFlowTheme.of(context).accent1,
                              icon: Icon(
                                Icons.download,
                                color: FlutterFlowTheme.of(context).primary,
                                size: 20,
                              ),
                              onPressed: () async {
                                await launchURL(_model.uploadedFileUrl);
                              },
                            ),
                        ],
                      ),
                    ),
                  ),
                ),

              // 3D 모델 뷰어 영역
              Expanded(
                child: Padding(
                  padding: EdgeInsetsDirectional.fromSTEB(24, 24, 24, 24),
                  child: Container(
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: FlutterFlowTheme.of(context).secondaryBackground,
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(
                        color: FlutterFlowTheme.of(context).alternate,
                        width: 2,
                      ),
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child: InAppWebView(
                        initialData: InAppWebViewInitialData(
                          data: _getHtmlContent(),
                        ),
                        initialSettings: InAppWebViewSettings(
                          javaScriptEnabled: true,
                          useHybridComposition: true,
                          allowsInlineMediaPlayback: true,
                          mediaPlaybackRequiresUserGesture: false,
                        ),
                        onWebViewCreated: (controller) {
                          _webViewController = controller;
                        },
                        onLoadStop: (controller, url) {
                          print('WebView loaded: $url');
                        },
                        onConsoleMessage: (controller, consoleMessage) {
                          print('Console: ${consoleMessage.message}');
                        },
                      ),
                    ),
                  ),
                ),
              ),

              // 하단 안내 영역
              Container(
                width: double.infinity,
                decoration: BoxDecoration(
                  color: FlutterFlowTheme.of(context).secondaryBackground,
                  boxShadow: [
                    BoxShadow(
                      blurRadius: 3,
                      color: Color(0x33000000),
                      offset: Offset(0, -1),
                    )
                  ],
                ),
                child: Padding(
                  padding: EdgeInsetsDirectional.fromSTEB(24, 16, 24, 16),
                  child: Row(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.info_outline,
                        color: FlutterFlowTheme.of(context).secondaryText,
                        size: 20,
                      ),
                      SizedBox(width: 8),
                      Expanded(
                        child: Text(
                          'Model Viewer • 드래그로 회전 • 휠로 확대/축소 • 자동 회전',
                          textAlign: TextAlign.center,
                          style: FlutterFlowTheme.of(context).bodySmall.override(
                                fontFamily: 'Readex Pro',
                                color: FlutterFlowTheme.of(context).secondaryText,
                                letterSpacing: 0.0,
                              ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

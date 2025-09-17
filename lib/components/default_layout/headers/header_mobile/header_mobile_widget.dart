import '/flutter_flow/flutter_flow_icon_button.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'header_mobile_model.dart';
export 'header_mobile_model.dart';

class HeaderMobileWidget extends StatefulWidget {
  const HeaderMobileWidget({
    super.key,
    String? years,
    String? semesterType,
  })  : this.years = years ?? '2025',
        this.semesterType = semesterType ?? '1gkrrl';

  final String years;
  final String semesterType;

  @override
  State<HeaderMobileWidget> createState() => _HeaderMobileWidgetState();
}

class _HeaderMobileWidgetState extends State<HeaderMobileWidget> {
  late HeaderMobileModel _model;

  @override
  void setState(VoidCallback callback) {
    super.setState(callback);
    _model.onUpdate();
  }

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => HeaderMobileModel());

    WidgetsBinding.instance.addPostFrameCallback((_) => safeSetState(() {}));
  }

  @override
  void dispose() {
    _model.maybeDispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    context.watch<FFAppState>();

    return Visibility(
      visible: responsiveVisibility(
        context: context,
        tabletLandscape: false,
        desktop: false,
      ),
      child: Container(
        width: double.infinity,
        height: MediaQuery.sizeOf(context).height * 0.06,
        decoration: BoxDecoration(
          color: FlutterFlowTheme.of(context).primaryBackground,
        ),
        child: Stack(
          children: [
            Row(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Flexible(
                  child: Align(
                    alignment: AlignmentDirectional(0.0, 0.0),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(8.0),
                      child: Image.asset(
                        'assets/images/_2.png',
                        width: double.infinity,
                        height: double.infinity,
                        fit: BoxFit.contain,
                        alignment: Alignment(0.0, 0.0),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            Padding(
              padding: EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 5.0, 0.0),
              child: Row(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Expanded(
                    child: Align(
                      alignment: AlignmentDirectional(1.0, 0.0),
                      child: FlutterFlowIconButton(
                        borderRadius: 8.0,
                        buttonSize: 40.0,
                        fillColor: FFAppState().channelTalk == false
                            ? Color(0xFF284E75)
                            : FlutterFlowTheme.of(context).primaryBackground,
                        hoverColor:
                            FlutterFlowTheme.of(context).primaryBackground,
                        hoverIconColor: Color(0xFF284E75),
                        icon: Icon(
                          Icons.quora_rounded,
                          color: valueOrDefault<Color>(
                            FFAppState().channelTalk == false
                                ? FlutterFlowTheme.of(context).primaryBackground
                                : Color(0xFF284E75),
                            FlutterFlowTheme.of(context).primaryBackground,
                          ),
                          size: 24.0,
                        ),
                        onPressed: () async {
                          FFAppState().channelTalk =
                              !(FFAppState().channelTalk);
                          _model.updatePage(() {});
                        },
                      ),
                    ),
                  ),
                ].divide(SizedBox(width: 24.0)),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

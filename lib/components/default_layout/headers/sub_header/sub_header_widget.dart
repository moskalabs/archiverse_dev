import '/flutter_flow/flutter_flow_icon_button.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'sub_header_model.dart';
export 'sub_header_model.dart';

class SubHeaderWidget extends StatefulWidget {
  const SubHeaderWidget({
    super.key,
    required this.title,
    bool? showBackBtn,
  }) : this.showBackBtn = showBackBtn ?? false;

  final String? title;
  final bool showBackBtn;

  @override
  State<SubHeaderWidget> createState() => _SubHeaderWidgetState();
}

class _SubHeaderWidgetState extends State<SubHeaderWidget> {
  late SubHeaderModel _model;

  @override
  void setState(VoidCallback callback) {
    super.setState(callback);
    _model.onUpdate();
  }

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => SubHeaderModel());

    WidgetsBinding.instance.addPostFrameCallback((_) => safeSetState(() {}));
  }

  @override
  void dispose() {
    _model.maybeDispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50.0,
      decoration: BoxDecoration(),
      child: Row(
        mainAxisSize: MainAxisSize.max,
        children: [
          if (widget.showBackBtn)
            FlutterFlowIconButton(
              borderRadius: 20.0,
              borderWidth: 0.0,
              buttonSize: 40.0,
              icon: Icon(
                Icons.keyboard_arrow_left_sharp,
                color: FlutterFlowTheme.of(context).primaryText,
                size: 24.0,
              ),
              onPressed: () async {
                context.safePop();
              },
            ),
          Flexible(
            child: Text(
              widget.title!,
              style: FlutterFlowTheme.of(context).headlineSmall.override(
                    font: GoogleFonts.openSans(
                      fontWeight: FontWeight.bold,
                      fontStyle:
                          FlutterFlowTheme.of(context).headlineSmall.fontStyle,
                    ),
                    letterSpacing: 0.0,
                    fontWeight: FontWeight.bold,
                    fontStyle:
                        FlutterFlowTheme.of(context).headlineSmall.fontStyle,
                  ),
            ),
          ),
        ],
      ),
    );
  }
}

import '/backend/schema/enums/enums.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'portfolio_type_chip_model.dart';
export 'portfolio_type_chip_model.dart';

class PortfolioTypeChipWidget extends StatefulWidget {
  const PortfolioTypeChipWidget({
    super.key,
    required this.portfolioType,
    this.selectedPortfolioType,
    required this.callbackType,
    required this.title,
  });

  final PortfolioType? portfolioType;
  final PortfolioType? selectedPortfolioType;
  final Future Function(PortfolioType returnPortfolioType)? callbackType;
  final String? title;

  @override
  State<PortfolioTypeChipWidget> createState() =>
      _PortfolioTypeChipWidgetState();
}

class _PortfolioTypeChipWidgetState extends State<PortfolioTypeChipWidget> {
  late PortfolioTypeChipModel _model;

  @override
  void setState(VoidCallback callback) {
    super.setState(callback);
    _model.onUpdate();
  }

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => PortfolioTypeChipModel());

    WidgetsBinding.instance.addPostFrameCallback((_) => safeSetState(() {}));
  }

  @override
  void dispose() {
    _model.maybeDispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return FFButtonWidget(
      onPressed: () async {
        await widget.callbackType?.call(
          widget.portfolioType!,
        );
      },
      text: widget.title!,
      options: FFButtonOptions(
        width: 180.0,
        height: 35.0,
        padding: EdgeInsetsDirectional.fromSTEB(16.0, 0.0, 16.0, 0.0),
        iconPadding: EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 0.0, 0.0),
        color: widget.portfolioType == widget.selectedPortfolioType
            ? FlutterFlowTheme.of(context).mainColor1
            : Color(0xFFEEF1F6),
        textStyle: FlutterFlowTheme.of(context).titleSmall.override(
              font: GoogleFonts.notoSansKr(
                fontWeight: FontWeight.bold,
                fontStyle: FlutterFlowTheme.of(context).titleSmall.fontStyle,
              ),
              color: widget.portfolioType == widget.selectedPortfolioType
                  ? Colors.white
                  : Color(0xFF666666),
              fontSize: 20.0,
              letterSpacing: 0.0,
              fontWeight: FontWeight.bold,
              fontStyle: FlutterFlowTheme.of(context).titleSmall.fontStyle,
            ),
        elevation: 0.0,
        borderRadius: BorderRadius.circular(5.0),
      ),
    );
  }
}

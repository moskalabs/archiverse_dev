import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'menu_item_copy_model.dart';
export 'menu_item_copy_model.dart';

class MenuItemCopyWidget extends StatefulWidget {
  const MenuItemCopyWidget({
    super.key,
    bool? isActivePage,
    required this.text,
    required this.icon,
    bool? hasNumberTag,
    int? number,
    Color? tagColor,
    bool? hasSubMenu,
    bool? subMenuExpanded,
  })  : this.isActivePage = isActivePage ?? false,
        this.hasNumberTag = hasNumberTag ?? false,
        this.number = number ?? 0,
        this.tagColor = tagColor ?? const Color(0xFF6C94E5),
        this.hasSubMenu = hasSubMenu ?? false,
        this.subMenuExpanded = subMenuExpanded ?? false;

  final bool isActivePage;
  final String? text;
  final Widget? icon;
  final bool hasNumberTag;
  final int number;
  final Color tagColor;
  final bool hasSubMenu;
  final bool subMenuExpanded;

  @override
  State<MenuItemCopyWidget> createState() => _MenuItemCopyWidgetState();
}

class _MenuItemCopyWidgetState extends State<MenuItemCopyWidget> {
  late MenuItemCopyModel _model;

  @override
  void setState(VoidCallback callback) {
    super.setState(callback);
    _model.onUpdate();
  }

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => MenuItemCopyModel());

    WidgetsBinding.instance.addPostFrameCallback((_) => safeSetState(() {}));
  }

  @override
  void dispose() {
    _model.maybeDispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      opaque: false,
      cursor: MouseCursor.defer,
      child: Container(
        height: 50.0,
        decoration: BoxDecoration(
          color: valueOrDefault<Color>(
            () {
              if (widget.isActivePage) {
                return FlutterFlowTheme.of(context).brand100;
              } else if (!widget.isActivePage && _model.mouseRegionHovered) {
                return FlutterFlowTheme.of(context).neutral100;
              } else {
                return Color(0x00FFFFFF);
              }
            }(),
            Color(0x00FFFFFF),
          ),
          borderRadius: BorderRadius.circular(8.0),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 50.0,
              height: 50.0,
              decoration: BoxDecoration(),
              child: widget.icon!,
            ),
            if (responsiveVisibility(
              context: context,
              phone: false,
              tablet: false,
              tabletLandscape: false,
            ))
              Container(
                width: 200.0,
                height: 50.0,
                decoration: BoxDecoration(),
                child: Row(
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    Expanded(
                      child: Padding(
                        padding:
                            EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 5.0, 0.0),
                        child: Text(
                          widget.text!,
                          maxLines: 1,
                          style: FlutterFlowTheme.of(context)
                              .bodyLarge
                              .override(
                                font: GoogleFonts.openSans(
                                  fontWeight: FontWeight.w600,
                                  fontStyle: FlutterFlowTheme.of(context)
                                      .bodyLarge
                                      .fontStyle,
                                ),
                                color: valueOrDefault<Color>(
                                  widget.isActivePage
                                      ? FlutterFlowTheme.of(context).primary
                                      : FlutterFlowTheme.of(context)
                                          .secondaryText,
                                  FlutterFlowTheme.of(context).secondaryText,
                                ),
                                letterSpacing: 0.0,
                                fontWeight: FontWeight.w600,
                                fontStyle: FlutterFlowTheme.of(context)
                                    .bodyLarge
                                    .fontStyle,
                              ),
                        ),
                      ),
                    ),
                    if (widget.hasSubMenu)
                      Container(
                        width: 24.0,
                        height: 24.0,
                        child: Stack(
                          alignment: AlignmentDirectional(0.0, 0.0),
                          children: [
                            if (widget.subMenuExpanded)
                              Icon(
                                Icons.keyboard_arrow_up,
                                color:
                                    FlutterFlowTheme.of(context).secondaryText,
                                size: 20.0,
                              ),
                            if (!widget.subMenuExpanded)
                              Icon(
                                Icons.keyboard_arrow_down_sharp,
                                color:
                                    FlutterFlowTheme.of(context).secondaryText,
                                size: 20.0,
                              ),
                          ],
                        ),
                      ),
                    if (widget.hasNumberTag)
                      Padding(
                        padding:
                            EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 4.0, 0.0),
                        child: Container(
                          height: 17.0,
                          decoration: BoxDecoration(
                            color: widget.tagColor,
                            borderRadius: BorderRadius.circular(100.0),
                          ),
                          alignment: AlignmentDirectional(0.0, 0.0),
                          child: Padding(
                            padding: EdgeInsetsDirectional.fromSTEB(
                                5.0, 0.0, 5.0, 0.0),
                            child: Text(
                              valueOrDefault<String>(
                                widget.number.toString(),
                                '0',
                              ),
                              style: FlutterFlowTheme.of(context)
                                  .bodyMedium
                                  .override(
                                    font: GoogleFonts.openSans(
                                      fontWeight: FontWeight.w600,
                                      fontStyle: FlutterFlowTheme.of(context)
                                          .bodyMedium
                                          .fontStyle,
                                    ),
                                    color: FlutterFlowTheme.of(context)
                                        .primaryBackground,
                                    fontSize: 12.0,
                                    letterSpacing: 0.0,
                                    fontWeight: FontWeight.w600,
                                    fontStyle: FlutterFlowTheme.of(context)
                                        .bodyMedium
                                        .fontStyle,
                                  ),
                            ),
                          ),
                        ),
                      ),
                  ],
                ),
              ),
          ],
        ),
      ),
      onEnter: ((event) async {
        safeSetState(() => _model.mouseRegionHovered = true);
      }),
      onExit: ((event) async {
        safeSetState(() => _model.mouseRegionHovered = false);
      }),
    );
  }
}

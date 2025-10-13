import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'student_menu_item_model.dart';
export 'student_menu_item_model.dart';

class StudentMenuItemWidget extends StatefulWidget {
  const StudentMenuItemWidget({
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
  State<StudentMenuItemWidget> createState() => _StudentMenuItemWidgetState();
}

class _StudentMenuItemWidgetState extends State<StudentMenuItemWidget> {
  late StudentMenuItemModel _model;

  @override
  void setState(VoidCallback callback) {
    super.setState(callback);
    _model.onUpdate();
  }

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => StudentMenuItemModel());

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

    return MouseRegion(
      opaque: false,
      cursor: MouseCursor.defer,
      child: Container(
        width: 250.0,
        height: () {
          if (MediaQuery.sizeOf(context).width < kBreakpointSmall) {
            return 32.0;
          } else if (MediaQuery.sizeOf(context).width < kBreakpointMedium) {
            return 38.0;
          } else if (MediaQuery.sizeOf(context).width < kBreakpointLarge) {
            return 42.0;
          } else {
            return 48.0;
          }
        }(),
        decoration: BoxDecoration(
          color: valueOrDefault<Color>(
            () {
              if (widget.isActivePage) {
                return FlutterFlowTheme.of(context).tertiary;
              } else if (!widget.isActivePage && _model.mouseRegionHovered) {
                return Color(0xCCFFC7AD);
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
            if ((FFAppState().navOpen == true) &&
                responsiveVisibility(
                  context: context,
                  phone: false,
                ))
              Expanded(
                child: Container(
                  width: 200.0,
                  height: 50.0,
                  decoration: BoxDecoration(),
                  child: Row(
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      Flexible(
                        child: AutoSizeText(
                          widget.text!,
                          maxLines: 1,
                          style: FlutterFlowTheme.of(context)
                              .bodyLarge
                              .override(
                                font: GoogleFonts.poppins(
                                  fontWeight: FontWeight.w500,
                                  fontStyle: FlutterFlowTheme.of(context)
                                      .bodyLarge
                                      .fontStyle,
                                ),
                                color: valueOrDefault<Color>(
                                  widget.isActivePage
                                      ? Color(0xFF284E75)
                                      : FlutterFlowTheme.of(context)
                                          .primaryBackground,
                                  FlutterFlowTheme.of(context).secondaryText,
                                ),
                                fontSize: () {
                                  if (MediaQuery.sizeOf(context).width <
                                      kBreakpointSmall) {
                                    return 8.0;
                                  } else if (MediaQuery.sizeOf(context).width <
                                      kBreakpointMedium) {
                                    return 12.0;
                                  } else if (MediaQuery.sizeOf(context).width <
                                      kBreakpointLarge) {
                                    return 15.0;
                                  } else {
                                    return 15.0;
                                  }
                                }(),
                                letterSpacing: 0.0,
                                fontWeight: FontWeight.w500,
                                fontStyle: FlutterFlowTheme.of(context)
                                    .bodyLarge
                                    .fontStyle,
                              ),
                        ),
                      ),
                      if (valueOrDefault<bool>(
                        widget.hasSubMenu,
                        false,
                      ))
                        Container(
                          width: 24.0,
                          height: 24.0,
                          child: Stack(
                            alignment: AlignmentDirectional(0.0, 0.0),
                            children: [
                              if (valueOrDefault<bool>(
                                widget.subMenuExpanded,
                                false,
                              ))
                                Icon(
                                  Icons.keyboard_arrow_up,
                                  color: FlutterFlowTheme.of(context)
                                      .secondaryText,
                                  size: 20.0,
                                ),
                              if (!valueOrDefault<bool>(
                                widget.subMenuExpanded,
                                false,
                              ))
                                Icon(
                                  Icons.keyboard_arrow_down_sharp,
                                  color: FlutterFlowTheme.of(context)
                                      .secondaryText,
                                  size: 20.0,
                                ),
                            ],
                          ),
                        ),
                    ],
                  ),
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

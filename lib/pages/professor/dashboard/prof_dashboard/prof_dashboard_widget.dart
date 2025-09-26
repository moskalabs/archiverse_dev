import '/core/font_constants.dart';
import '/core/responsive_wrapper.dart';
    Key? key,
    this.tabIndex,
  }) : super(key: key);
  final int? tabIndex;
  static String routeName = 'ProfDashboard';
  static String routePath = '/prof-dashboard';
    return Scaffold(
      key: scaffoldKey,
      backgroundColor: FlutterFlowTheme.of(context).secondaryBackground,
      body: ResponsiveWrapper(
        child: SafeArea(
          top: true,
                height: 60,
                color: FlutterFlowTheme.of(context).primaryBackground,
                alignment: Alignment.centerLeft,
                padding: const EdgeInsets.symmetric(horizontal: 24),
                child: Text(
                  'Professor Dashboard',
                  style: FlutterFlowTheme.of(context).titleLarge.override(
                        fontFamily: FlutterFlowTheme.of(context).titleLargeFamily,
                        fontSize: FontConstants.sizeXLarge,
                        useGoogleFonts: GoogleFonts.asMap().containsKey(
                          FlutterFlowTheme.of(context).titleLargeFamily,
                ),
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(24),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Container(
                        padding: const EdgeInsets.all(16),
                        decoration: BoxDecoration(
                          color:
                              FlutterFlowTheme.of(context).secondaryBackground,
                          borderRadius: BorderRadius.circular(12),
                        child: Text(
                          'Professor Content',
                          style:
                              FlutterFlowTheme.of(context).bodyLarge.override(
                                    fontFamily: FlutterFlowTheme.of(context)
                                        .bodyLargeFamily,
                                    fontSize: FontConstants.sizeLarge,
                                    useGoogleFonts:
                                        GoogleFonts.asMap().containsKey(
                                      FlutterFlowTheme.of(context)
                                          .bodyLargeFamily,
                                    ),
                    ],
                  ),

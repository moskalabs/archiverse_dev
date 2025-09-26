import '/core/font_constants.dart';
    Key? key,
  }) : super(key: key);
    return Scaffold(
      key: scaffoldKey,
      backgroundColor: FlutterFlowTheme.of(context).secondaryBackground,
      body: ResponsiveWrapper(
        child: SafeArea(
          top: true,
          child: Column(
            mainAxisSize: MainAxisSize.max,
            children: [
              Container(
                width: double.infinity,
                height: 60,
                color: FlutterFlowTheme.of(context).primaryBackground,
                alignment: Alignment.centerLeft,
                padding: const EdgeInsets.symmetric(horizontal: 24),
                child: Text(
                  'Dashboard',
                  style: FlutterFlowTheme.of(context).titleLarge.override(
                        fontFamily: FlutterFlowTheme.of(context).titleLargeFamily,
                        fontSize: FontConstants.sizeXLarge,
                        useGoogleFonts: GoogleFonts.asMap().containsKey(
                          FlutterFlowTheme.of(context).titleLargeFamily,
                        ),
                      ),
              Expanded(
                child: Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(24),
                    crossAxisAlignment: CrossAxisAlignment.start,
                      Container(
                        width: 260,
                        margin: const EdgeInsets.only(right: 24),
                        padding: const EdgeInsets.all(16),
                        decoration: BoxDecoration(
                          color:
                              FlutterFlowTheme.of(context).secondaryBackground,
                          borderRadius: BorderRadius.circular(12),
                        child: Text(
                          'Sidebar',
                          style: FlutterFlowTheme.of(context).bodyMedium.override(
                                fontFamily:
                                    FlutterFlowTheme.of(context).bodyMediumFamily,
                                fontSize: FontConstants.sizeMedium,
                                useGoogleFonts: GoogleFonts.asMap().containsKey(
                                  FlutterFlowTheme.of(context).bodyMediumFamily,
                      ),
                        child: Container(
                          padding: const EdgeInsets.all(16),
                          decoration: BoxDecoration(
                            color:
                                FlutterFlowTheme.of(context).secondaryBackground,
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Text(
                            'Main Content',
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
                          ),
            ],

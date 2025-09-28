          child: Stack(
              InteractiveViewer(
                minScale: 0.5,
                maxScale: 2.0,
                child: SingleChildScrollView(
                  scrollDirection: Axis.both,
                  child: ConstrainedBox(
                    constraints: BoxConstraints(
                      minWidth: 1200.0,
                      minHeight: MediaQuery.sizeOf(context).height,
                    ),
                    child: Align(
                      alignment: AlignmentDirectional(0.0, -1.0),
                      child: Container(
                        width: 1920.0,
                        child: Column(
                          mainAxisSize: MainAxisSize.max,
                          children: [
                            Container(
                            minWidth: 200.0,
              Container(
                width: MediaQuery.sizeOf(context).width * 1.0,
                height: MediaQuery.sizeOf(context).height * 0.87,
                decoration: BoxDecoration(
                  color: FlutterFlowTheme.of(context).secondaryBackground,
                  shape: BoxShape.rectangle,
                ),
                child: Column(
                            Flexible(
                            if (_model.buttonGrades != null)
                            if (((_model.courseSectionOutputV.isNotEmpty) ==
                                    true) &&
                                (_model.courseSelected1 == true))
                                                          Flexible(
                                                              child: Padding(
                                                                padding: EdgeInsetsDirectional
                                                                    .fromSTEB(
                                                                        0.0,
                                                                        3.0,
                                                                        0.0,
                                                                        0.0),
                                                                child: Row(
                                                                  mainAxisSize:
                                                                      MainAxisSize
                                                                          .min,
                                                                  mainAxisAlignment:
                                                                      MainAxisAlignment
                                                                          .start,
                                                                  children: [
                                                                              fontSize: 12.0,
                                                                                  fontSize: 12.0,
                                                                      maxLines: 1,
                                                                      overflow: TextOverflow.ellipsis,
                                                                    child: SingleChildScrollView(
                                                                      scrollDirection: Axis.horizontal,
                                                                      child: Row(
                                                                        children: [
                                                                          ConstrainedBox(
                                                                            constraints: BoxConstraints(
                                                                              minWidth: 200.0,
                                                                            ),
                                                                            child: Column(
                                                                              mainAxisSize:
                                                                                  MainAxisSize
                                                                                      .min,
                                                                              children: [
                                                                            constraints: BoxConstraints(
                                                                              minWidth: 200.0,
                                                                            ),
                                                                            constraints: BoxConstraints(
                                                                              minWidth: 200.0,
                                                                            ),
                                                                            constraints: BoxConstraints(
                                                                              minWidth: 200.0,
                                                                            ),
                                                                            constraints: BoxConstraints(
                                                                              minWidth: 200.0,
                                                                            ),
                                                                            constraints: BoxConstraints(
                                                                              minWidth: 200.0,
                                                                            ),
                                                                            constraints: BoxConstraints(
                                                                              minWidth: 200.0,
                                                                            ),
                                                                            constraints: BoxConstraints(
                                                                              minWidth: 200.0,
                                                                            ),
                                                                            constraints: BoxConstraints(
                                                                              minWidth: 200.0,
                                                                            ),
                                                                      maxLines: 1,
                boundaryMargin: const EdgeInsets.all(24.0),
                        width: 1200.0,
                        padding: const EdgeInsets.all(24.0),
                  width: MediaQuery.sizeOf(context).width * 1.0,
                  height: 55.0,
                  decoration: BoxDecoration(
                    color: Color(0xFFEEF1F6),
                    shape: BoxShape.rectangle,
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Padding(
                        padding:
                            EdgeInsetsDirectional.fromSTEB(10.0, 0.0, 0.0, 0.0),
                        child: Container(
                          width: MediaQuery.sizeOf(context).width * 0.35,
                          constraints: BoxConstraints(
                            minWidth: 200.0,
                            maxWidth: 500.0,
                          ),
                          decoration: BoxDecoration(),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                                  Padding(
                                    padding: EdgeInsetsDirectional.fromSTEB(
                                        10.0, 0.0, 0.0, 0.0),
                                    child: Container(
                                      width:
                                          MediaQuery.sizeOf(context).width * 0.35,
                                      constraints: BoxConstraints(
                                        minWidth: 200.0,
                                        maxWidth: 500.0,
                                      ),
                                      decoration: BoxDecoration(),
                                      child: Row(
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                            queryFn: (q) => q,
                                          ),
                                          builder: (context, snapshot) {
                                            // Customize what your widget looks like when it's loading.
                                            if (!snapshot.hasData) {
                                              return Center(
                                                child: SizedBox(
                                                  width: 50.0,
                                                  height: 50.0,
                                                  child:
                                                      CircularProgressIndicator(
                                                    valueColor:
                                                        AlwaysStoppedAnimation<
                                                            Color>(
                                                      Color(0xFF284E75),
                                                    ),
                                                  ),
                                                ),
                                              );
                                            }
                                            List<YearsRow>
                                                dropDown1YearsRowList =
                                                snapshot.data!;
                                            return FlutterFlowDropDown<String>(
                                              controller: _model
                                                      .dropDown1ValueController ??=
                                                  FormFieldController<String>(
                                                _model.dropDown1Value ??=
                                                    valueOrDefault<String>(
                                                  dropDown1YearsRowList
                                                      .lastOrNull?.year,
                                                  '2025',
                                                ),
                                              ),
                                              options: dropDown1YearsRowList
                                                  .map((e) => e.year)
                                                  .withoutNulls
                                                  .toList(),
                                              onChanged: (val) async {
                                                safeSetState(() => _model
                                                    .dropDown1Value = val);
                                                _model.years =
                                                    _model.dropDown1Value;
                                                safeSetState(() {});
                                              },
                                              width: 160.0,
                                              height: 40.0,
                                                    fontSize: 16.0,
                                                              safeSetState(() =>
                                                                  _model.dropDown1Value =
                                                                      val);
                                                              _model.years = _model
                                                                  .dropDown1Value;
                                                              safeSetState(() {});
                                                            },
                                                            width: 160.0,
                                                            height: 40.0,
                                                                                    .min,
                                                                            children: [
                                                                            constraints: BoxConstraints(
                                                                              minWidth: 200.0,
                                                                            ),
                                                                            constraints: BoxConstraints(
                                                                              minWidth: 200.0,
                                                                            ),
                                                                            constraints: BoxConstraints(
                                                                              minWidth: 200.0,
                                                                            ),
                                                                            constraints: BoxConstraints(
                                                                              minWidth: 200.0,
                                                                            ),
                                                                            constraints: BoxConstraints(
                                                                              minWidth: 200.0,
                                                                            ),
                                                                            constraints: BoxConstraints(
                                                                              minWidth: 200.0,
                                                                            ),
                                                                            constraints: BoxConstraints(
                                                                              minWidth: 200.0,
                                                                            constraints: BoxConstraints(
                                                                              minWidth: 200.0,
                                                                            ),
                            if (((_model.courseSectionOutputV.isNotEmpty) ==
                                    true) &&
                                (_model.courseSelected3 == true))
                                                                    maxLines: 1,
                                                                    overflow: TextOverflow.ellipsis,
                                                                  child: SingleChildScrollView(
                                                                    scrollDirection: Axis.horizontal,
                                                                    child: Row(
                                                                      children: [
                                                                        ConstrainedBox(
                                                                          constraints: BoxConstraints(
                                                                            minWidth: 200.0,
                                                                          ),
                                                                          child: Column(
                                                                            mainAxisSize:
                                                                                MainAxisSize
                                                                                    .min,
                                                                            children: [
                                                                            constraints: BoxConstraints(
                                                                              minWidth: 200.0,
                                                                            ),
                                                                            constraints: BoxConstraints(
                                                                              minWidth: 200.0,
                                                                            ),
                                                                            constraints: BoxConstraints(
                                                                              minWidth: 200.0,
                                                                            ),
                                                                            constraints: BoxConstraints(
                                                                              minWidth: 200.0,
                                                                            ),
                                                                            constraints: BoxConstraints(
                                                                              minWidth: 200.0,
                                                                            ),
                                                                            constraints: BoxConstraints(
                                                                              minWidth: 200.0,
                                                                            ),
                                                                            constraints: BoxConstraints(
                                                                              minWidth: 200.0,
                                                                            ),
                                                                            constraints: BoxConstraints(
                                                                              minWidth: 200.0,
                                                                            ),
                            if (((_model.courseSectionOutputV.isNotEmpty) ==
                                    true) &&
                                (_model.courseSelected4 == true))
                                                                    maxLines: 1,
                                                                    overflow: TextOverflow.ellipsis,
                                                                  child: SingleChildScrollView(
                                                                    scrollDirection: Axis.horizontal,
                                                                    child: Row(
                                                                      children: [
                                                                        ConstrainedBox(
                                                                          constraints: BoxConstraints(
                                                                            minWidth: 200.0,
                                                                          ),
                                                                          child: Column(
                                                                            mainAxisSize:
                                                                                MainAxisSize
                                                                                    .min,
                                                                            children: [
                                                                            constraints: BoxConstraints(
                                                                              minWidth: 200.0,
                                                                            ),
                                                                            constraints: BoxConstraints(
                                                                              minWidth: 200.0,
                                                                            ),
                                                                            constraints: BoxConstraints(
                                                                              minWidth: 200.0,
                                                                            ),
                                                                            constraints: BoxConstraints(
                                                                              minWidth: 200.0,
                                                                            ),
                                                                            constraints: BoxConstraints(
                                                                              minWidth: 200.0,
                                                                            ),
                                                                            constraints: BoxConstraints(
                                                                              minWidth: 200.0,
                                                                            ),
                                                                            constraints: BoxConstraints(
                                                                              minWidth: 200.0,
                                                                            ),
                                                                            constraints: BoxConstraints(
                                                                              minWidth: 200.0,
                                                                            ),
                                                                              fontSize: 22.0,
                                                                                      fontSize: 22.0,
                                                                                            fontSize: 18.0,
                                                                                      fontSize: 22.0,
                                                                                            fontSize: 18.0,
                                                                                      fontSize: 22.0,
                                                                                            fontSize: 18.0,
                                                                                      fontSize: 22.0,
                                                                                                fontSize: 18.0,
                                                                                      fontSize: 22.0,
                                                                                                fontSize: 18.0,
                                                                                      fontSize: 22.0,
                                                                                                fontSize: 18.0,
                                                  fontSize: 22.0,
                                                              child: Visibility(
                                                                visible: true,
                                                                child: Padding(
                                                                  padding: EdgeInsetsDirectional
                                                                      .fromSTEB(
                                                                          0.0,
                                                                          3.0,
                                                                          0.0,
                                                                          0.0),
                                                                  child: Row(
                                                                    mainAxisSize:
                                                                        MainAxisSize
                                                                            .min,
                                                                    mainAxisAlignment:
                                                                        MainAxisAlignment
                                                                            .start,
                                                                    children: [
                                                                        maxLines: 1,
                                                                        overflow: TextOverflow.ellipsis,
                                                                              fontSize: 14.0,
                                                                              fontSize: 14.0,
                                                                  child:
                                                                      SingleChildScrollView(
                                                                    scrollDirection:
                                                                        Axis.horizontal,
                                                                    child: Row(
                                                                      mainAxisSize:
                                                                          MainAxisSize
                                                                              .min,
                                                                      children: [
                                                                                              fontSize: 12.0,
                                                                                              fontSize: 12.0,
                                                                        ),
                                                                      ],
                                                                    ),
                                                                  child:
                                                                      SingleChildScrollView(
                                                                    scrollDirection:
                                                                        Axis.horizontal,
                                                                    child: Row(
                                                                      mainAxisSize:
                                                                          MainAxisSize
                                                                              .min,
                                                                      children: [
                                                                                              fontSize: 12.0,
                                                                                              fontSize: 12.0,
                                                                                              fontSize: 12.0,
                                                                                              fontSize: 12.0,
                                                                        maxLines: 1,
                                                                        overflow: TextOverflow.ellipsis,
                                                                              fontSize: 14.0,
                                                                              fontSize: 14.0,
                                                                  child:
                                                                      SingleChildScrollView(
                                                                    scrollDirection:
                                                                        Axis.horizontal,
                                                                    child: Row(
                                                                      mainAxisSize:
                                                                          MainAxisSize
                                                                              .min,
                                                                      children: [
                                                                                              fontSize: 12.0,
                                                                                              fontSize: 12.0,
                                                                  child:
                                                                      SingleChildScrollView(
                                                                    scrollDirection:
                                                                        Axis.horizontal,
                                                                    child: Row(
                                                                      mainAxisSize:
                                                                          MainAxisSize
                                                                              .min,
                                                                      children: [
                                                                                              fontSize: 12.0,
                                                                                              fontSize: 12.0,
                                                                                              fontSize: 12.0,
                                                                                              fontSize: 12.0,
                                                                        maxLines: 1,
                                                                        overflow: TextOverflow.ellipsis,
                                                                              fontSize: 14.0,
                                                                              fontSize: 14.0,
                                                                  child:
                                                                      SingleChildScrollView(
                                                                    scrollDirection:
                                                                        Axis.horizontal,
                                                                    child: Row(
                                                                      mainAxisSize:
                                                                          MainAxisSize
                                                                              .min,
                                                                      children: [
                                                                                              fontSize: 12.0,
                                                                                              fontSize: 12.0,
                                                                  child:
                                                                      SingleChildScrollView(
                                                                    scrollDirection:
                                                                        Axis.horizontal,
                                                                    child: Row(
                                                                      mainAxisSize:
                                                                          MainAxisSize
                                                                              .min,
                                                                      children: [
                                                                                              fontSize: 12.0,
                                                                                              fontSize: 12.0,
                                                                                              fontSize: 12.0,
                                                                                              fontSize: 12.0,
                                                  fontSize: 22.0,
                                                                                fontSize: 14.0,
                                                                  child:
                                                                      SingleChildScrollView(
                                                                    scrollDirection:
                                                                        Axis.horizontal,
                                                                    child: Row(
                                                                      mainAxisSize:
                                                                          MainAxisSize
                                                                              .min,
                                                                      children: [
                                                                                              fontSize: 12.0,
                                                                                              fontSize: 12.0,
                                                                  child:
                                                                      SingleChildScrollView(
                                                                    scrollDirection:
                                                                        Axis.horizontal,
                                                                    child: Row(
                                                                      mainAxisSize:
                                                                          MainAxisSize
                                                                              .min,
                                                                      children: [
                                                                                              fontSize: 12.0,
                                                                                              fontSize: 12.0,
                                                                                              fontSize: 12.0,
                                                                                              fontSize: 12.0,
                                                  fontSize: 22.0,
                                                                                fontSize: 14.0,
                                                                  child:
                                                                      SingleChildScrollView(
                                                                    scrollDirection:
                                                                        Axis.horizontal,
                                                                    child: Row(
                                                                      mainAxisSize:
                                                                          MainAxisSize
                                                                              .min,
                                                                      children: [
                                                                                              fontSize: 12.0,
                                                                                              fontSize: 12.0,
                                                                  child:
                                                                      SingleChildScrollView(
                                                                    scrollDirection:
                                                                        Axis.horizontal,
                                                                    child: Row(
                                                                      mainAxisSize:
                                                                          MainAxisSize
                                                                              .min,
                                                                      children: [
                                                child: Text(
                                                  valueOrDefault<String>(
                                                    _model.years,
                                                    '0000',
                                                  textAlign: TextAlign.center,
                                                ),
                                                  maxLines: 1,
                                                  overflow: TextOverflow.ellipsis,
                                              child: AnimatedDefaultTextStyle(
                                                   '5hv0jwqm' /* 년 */,
                                                 ),
                                                 textAlign: TextAlign.center,
                                                  maxLines: 1,
                                                  overflow: TextOverflow.ellipsis,
                                               ),
                                               child: Text(
                                                 valueOrDefault<String>(
                                                   _model.semester,
                                                   '-학기',
                                               child: AnimatedDefaultTextStyle(
                                                child: Text(
                                                  FFLocalizations.of(context)
                                                      .getText(
                                                    '5hv0jwqm' /* 년 */,
                                                  ),
                                                  textAlign: TextAlign.center,
                                                ),
                                                child: Text(
                                                  valueOrDefault<String>(
                                                    _model.semester,
                                                    '-학기',
                                                  ),
                                                  textAlign: TextAlign.center,
                                                ),
                    ),
              Flexible(
                child: Container(
                  width: MediaQuery.sizeOf(context).width * 1.0,
                  height: MediaQuery.sizeOf(context).height * 0.87,
                  decoration: BoxDecoration(
                    color: FlutterFlowTheme.of(context).secondaryBackground,
                    shape: BoxShape.rectangle,
                  ),
                  child: Column(
                          child: Row(
                            mainAxisSize: MainAxisSize.max,
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Flexible(
                                                                            fontSize: 22.0,
                                                                                  fontSize: 22.0,
                                                                                            fontSize: 20.0,
                                                                                            fontSize: 20.0,
                                                                                            fontSize: 20.0,
                                                                                                fontSize: 20.0,
                                                                                                fontSize: 20.0,
                                                                                                fontSize: 20.0,
                              if (_model.buttonGrades != null)
                              if (((_model.courseSectionOutputV.isNotEmpty) ==
                                      true) &&
                                  (_model.courseSelected1 == true))
                                                            Flexible(
                                                            Flexible(
                                                              child: Container(
                                                                height: double
                                                                    .infinity,
                                                                decoration:
                                                                    BoxDecoration(),
                                                                                fontSize: 12.0,
                                                                                fontSize: 12.0,
                                                                              fontSize: 15.0,
                                                                              fontSize: 15.0,
                                                                    child:
                                                                        Column(
                                                                      mainAxisSize:
                                                                          MainAxisSize
                                                                              .min,
                                                                      children: [
                                                                  child: Row(
                                                                    mainAxisSize:
                                                                        MainAxisSize
                                                                            .min,
                                                                    children: [
                                                                                              fontSize: 13.0,
                                                                                              fontSize: 13.0,
                                                                      ),
                                                                    ],
                                                                  child: Row(
                                                                    mainAxisSize:
                                                                        MainAxisSize
                                                                            .min,
                                                                    children: [
                                                                                              fontSize: 13.0,
                                                                                              fontSize: 13.0,
                                                                                              fontSize: 13.0,
                                                                                              fontSize: 13.0,
                                                                              fontSize: 15.0,
                                                                              fontSize: 15.0,
                                                                    child:
                                                                        Column(
                                                                      mainAxisSize:
                                                                          MainAxisSize
                                                                              .min,
                                                                      children: [
                                                                  child: Row(
                                                                    mainAxisSize:
                                                                        MainAxisSize
                                                                            .min,
                                                                    children: [
                                                                                              fontSize: 13.0,
                                                                                              fontSize: 13.0,
                                                                  child: Row(
                                                                    mainAxisSize:
                                                  maxLines: 1,
                                                  overflow: TextOverflow.ellipsis,
                                                                    children: [
                                                                                              fontSize: 13.0,
                                                                                              fontSize: 13.0,
                                                                                              fontSize: 13.0,
                                                                                              fontSize: 13.0,
                                                                              fontSize: 15.0,
                                                                              fontSize: 15.0,
                                                                    child:
                                                                        Column(
                                                                      mainAxisSize:
                                                                          MainAxisSize
                                                                              .min,
                                                                      children: [
                                                                  child: Row(
                                                                    mainAxisSize:
                                                                        MainAxisSize
                                                                            .min,
                                                                    children: [
                                                                                              fontSize: 13.0,
                                                                                              fontSize: 13.0,
                                                                  child: Row(
                                                                    mainAxisSize:
                                                                        MainAxisSize
                                                                            .min,
                                                                    children: [
                                                                                              fontSize: 13.0,
                                                                                              fontSize: 13.0,
                                                                                              fontSize: 13.0,
                                                                                              fontSize: 13.0,
                              if (((_model.courseBySelectOutputV.isNotEmpty) ==
                                      true) &&
                                  (_model.courseSelected2 == true))
                                                                                fontSize: 15.0,
                                                                  child: Column(
                                                                    mainAxisSize:
                                                                        MainAxisSize
                                                                            .min,
                                                                    children: [
                                                                  child: Row(
                                                                    mainAxisSize:
                                                                        MainAxisSize
                                                                            .min,
                                                                    children: [
                                                                                              fontSize: 13.0,
                                                                                              fontSize: 13.0,
                                                                  child: Row(
                                                                    mainAxisSize:
                                                                        MainAxisSize
                                                                            .min,
                                                                    children: [
                                                                                              fontSize: 13.0,
                                                                                              fontSize: 13.0,
                                                                                              fontSize: 13.0,
                                                                                              fontSize: 13.0,
                              if (((_model.courseSectionOutputV.isNotEmpty) ==
                                      true) &&
                                  (_model.courseSelected3 == true))
                                                                                fontSize: 15.0,
                                                                  child: Column(
                                                                    mainAxisSize:
                                                                        MainAxisSize
                                                                            .min,
                                                                    children: [
                                                                  child: Row(
                                                                    mainAxisSize:
                                                                        MainAxisSize
                                                                            .min,
                                                                    children: [
                                                                                              fontSize: 13.0,
                                                                                              fontSize: 13.0,
                                                                  child: Row(
                                                                    mainAxisSize:
                                                                        MainAxisSize
                                                                            .min,
                                                                    children: [
              Flexible(
                child: Container(
                  width: MediaQuery.sizeOf(context).width * 1.0,
                  height: MediaQuery.sizeOf(context).height * 0.87,
                  decoration: BoxDecoration(
                    color: FlutterFlowTheme.of(context).secondaryBackground,
                    shape: BoxShape.rectangle,
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                            if (responsiveVisibility(
                              context: context,
                              phone: false,
                              tablet: false,
                            ))
                              Flexible(
                        child: Row(
                          mainAxisSize: MainAxisSize.max,
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Flexible(
                              child: SafeArea(
                                                                    children: [
                                                                                              fontSize: 13.0,
                                                                                              fontSize: 13.0,
                                                                                              fontSize: 13.0,
                                                                                              fontSize: 13.0,
                    ],
                                                                          22.0,
                                                                          22.0,
                                                                          22.0,
                                                                          22.0,
                                                                          22.0,
                                                                              fontSize: 22.0,
                                                                                      fontSize: 22.0,
                                                                                            fontSize: 18.0,
                                                                                            fontSize: 18.0,
                                                                                            fontSize: 18.0,
                                                                                                fontSize: 18.0,
                                                                                                fontSize: 18.0,
                                                                                                fontSize: 18.0,
                                SizedBox(
                                                                              22.0,
                                                                          22.0,
                                                                                    fontSize: 12.0,
                                                                              22.0,
                                                                              fontSize: 16.0,
                                                                              fontSize: 16.0,
                                                                                              fontSize: 12.0,
                                                                                              fontSize: 12.0,
                                                                                              fontSize: 12.0,
                                                                                              fontSize: 12.0,
                                                                                              fontSize: 12.0,
                                                                                              fontSize: 12.0,
                                                                              22.0,
                                                                              fontSize: 16.0,
                                                                              fontSize: 16.0,
                                                                                              fontSize: 12.0,
                                                                                              fontSize: 12.0,
                                                                                              fontSize: 12.0,
                                                                                              fontSize: 12.0,
                                                                                              fontSize: 12.0,
                                                                                              fontSize: 12.0,
                                                                              22.0,
                                                                              fontSize: 16.0,
                                                                              fontSize: 16.0,
                                                                                              fontSize: 12.0,
                                                                                              fontSize: 12.0,
                                                                                              fontSize: 12.0,
                                                                                              fontSize: 12.0,
                                                                                              fontSize: 12.0,
                                                                                              fontSize: 12.0,
                                                                              22.0,
                                                                          22.0,
                                                                                16.0,
                                                                                fontSize: 16.0,
                                                                            22.0,
                                                                                16.0,
                                                                                16.0,
                                                                                              fontSize: 12.0,
                                                                                              fontSize: 12.0,
                                                                                              fontSize: 12.0,
                                                                                              fontSize: 12.0,
                                                                                              fontSize: 12.0,
                                                                                              fontSize: 12.0,
                                                                              22.0,
                                                                          22.0,
                                                                                16.0,
                                                                                fontSize: 16.0,
                                                                            22.0,
                                                                                16.0,
                                                                                16.0,
                                                                                              fontSize: 12.0,
                                                                                              fontSize: 12.0,
                                                                                              fontSize: 12.0,
                                                                                              fontSize: 12.0,
                                                                                              fontSize: 12.0,
                                                                                              fontSize: 12.0,
                                                                              22.0,
                                                                          22.0,
                                                                                16.0,
                                                                                fontSize: 16.0,
                                                                            22.0,
                                                                                16.0,
                                                                                16.0,
                                                                                              fontSize: 12.0,
                                                                                              fontSize: 12.0,
                                                                                              fontSize: 12.0,
                                                                                              fontSize: 12.0,
                                                                                              fontSize: 12.0,
                                                                                              fontSize: 12.0,
                                                                          25.0,
                                                                          25.0,
                                                                          25.0,
                                                                          25.0,
                                                                          25.0,
                                                                              fontSize: 25.0,
                                                                                      fontSize: 25.0,
                                                                                            fontSize: 20.0,
                                                                                      fontSize: 25.0,
                                                                                            fontSize: 20.0,
                                                                                      fontSize: 25.0,
                                                                                            fontSize: 20.0,
                                                                                      fontSize: 25.0,
                                                                                                fontSize: 20.0,
                                                                                      fontSize: 25.0,
                                                                                                fontSize: 20.0,
                                                                                      fontSize: 25.0,
                                                                                                fontSize: 20.0,
                              SizedBox(
                                                  fontSize: 25.0,
                                                                              25.0,
                                                                          25.0,
                                                          Flexible(
                                                            child: Container(
                                                              height: double
                                                                  .infinity,
                                                              decoration:
                                                                  BoxDecoration(),
                                                              child: Padding(
                                                                              23.0,
                                                                              fontSize: 15.0,
                                                                              fontSize: 15.0,
                                                                      child: Text(
                                                                        FFLocalizations.of(
                                                                                context)
                                                                            .getText(
                                                                          'yc2tezrq' /* 교수님 업로드현황  */,
                                                                        ),
                                                                        maxLines: 1,
                                                                        overflow: TextOverflow.ellipsis,
                                                                        style: FlutterFlowTheme.of(
                                                                                context)
                                                                            .bodyMedium
                                                                            .override(
                                                                              font:
                                                                                  GoogleFonts.openSans(
                                                                                fontWeight: FontWeight.bold,
                                                                                fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                                                                              ),
                                                                              color:
                                                                                  FlutterFlowTheme.of(context).secondaryText,
                                                                              fontSize:
                                                                                  18.0,
                                                                              letterSpacing:
                                                                                  0.0,
                                                                              fontWeight:
                                                                                  FontWeight.bold,
                                                                              fontStyle:
                                                                                  FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                                                                      ),
                                                                                              fontSize: 13.0,
                                                                                              fontSize: 13.0,
                                                                                              fontSize: 13.0,
                                                                                              fontSize: 13.0,
                                                                                              fontSize: 13.0,
                                                                                              fontSize: 13.0,
                                                                              23.0,
                                                                              fontSize: 15.0,
                                                                              fontSize: 15.0,
                                                                      maxLines: 1,
                                                                      overflow: TextOverflow.ellipsis,
                                                                                              fontSize: 13.0,
                                                                                              fontSize: 13.0,
                                                                                              fontSize: 13.0,
                                                                                              fontSize: 13.0,
                                                                                              fontSize: 13.0,
                                                                                              fontSize: 13.0,
                                                                              23.0,
                                                                              fontSize: 15.0,
                                                                              fontSize: 15.0,
                                                                      maxLines: 1,
                                                                      overflow: TextOverflow.ellipsis,
                                                                                              fontSize: 13.0,
                                                                                              fontSize: 13.0,
                                                                                              fontSize: 13.0,
                                                                                              fontSize: 13.0,
                                                                                              fontSize: 13.0,
                                                                                              fontSize: 13.0,
                                                  fontSize: 25.0,
                                                                              25.0,
                                                                          25.0,
                                                                                15.0,
                                                                                fontSize: 15.0,
                                                                            23.0,
                                                                                15.0,
                                                                                15.0,
                                                                    maxLines: 1,
                                                                    overflow: TextOverflow.ellipsis,
                                                                                              fontSize: 13.0,
                                                                                              fontSize: 13.0,
                                                                                              fontSize: 13.0,
                                                                                              fontSize: 13.0,
                                                                                              fontSize: 13.0,
                                                                                              fontSize: 13.0,
                                                  fontSize: 25.0,
                                                                              25.0,
                                                                          25.0,
                                                                                15.0,
                                                                                fontSize: 15.0,
                                                                            23.0,
                                                                                15.0,
                                                                                15.0,
                                                                    maxLines: 1,
                                                                    overflow: TextOverflow.ellipsis,
                                                                                              fontSize: 13.0,
                                                                                              fontSize: 13.0,
                                                                                              fontSize: 13.0,
                                                                                              fontSize: 13.0,
                                                                                              fontSize: 13.0,
                                                                                              fontSize: 13.0,
                                                  fontSize: 25.0,
                                                                              25.0,
                                                                          25.0,
                                                                                15.0,
                                                                                fontSize: 15.0,
                                                                            23.0,
                                                                                15.0,
                                                                                15.0,
                                                                    maxLines: 1,
                                                                    overflow: TextOverflow.ellipsis,
                                                                                              fontSize: 13.0,
                                                                                              fontSize: 13.0,
                                                                                              fontSize: 13.0,
                                                                                              fontSize: 13.0,
                                                                                              fontSize: 13.0,
                                                                      fontSize:
                                                                          25.0,
                            if (((_model.courseSectionOutputV.isNotEmpty) ==
                                    true) &&
                                (_model.courseSelected1 == true))
                                                          Flexible(
                                                                padding: EdgeInsetsDirectional
                                                                    .fromSTEB(
                                                                        0.0,
                                                                        3.0,
                                                                        0.0,
                                                                        0.0),
                                                                child: Row(
                                                                  mainAxisSize:
                                                                      MainAxisSize
                                                                          .min,
                                                                  mainAxisAlignment:
                                                                      MainAxisAlignment
                                                                          .start,
                                                                  children: [
                                                                              fontSize: 12.0,
                                                                                  fontSize: 12.0,
                                                                    child: Text(
                                                                      FFLocalizations.of(
                                                                              context)
                                                                          .getText(
                                                                        'yc2tezrq' /* 교수님 업로드현황  */,
                                                                      maxLines: 1,
                                                                      overflow:
                                                                          TextOverflow
                                                                              .ellipsis,
                                                                      style: FlutterFlowTheme.of(
                                                                              context)
                                                                          .bodyMedium
                                                                          .override(
                                                                            font:
                                                                                GoogleFonts.openSans(
                                                                              fontWeight: FontWeight.bold,
                                                                              fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                                                                            ),
                                                                            color:
                                                                                FlutterFlowTheme.of(context).secondaryText,
                                                                            fontSize:
                                                                                18.0,
                                                                            letterSpacing:
                                                                                0.0,
                                                                            fontWeight:
                                                                                FontWeight.bold,
                                                                            fontStyle:
                                                                                FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                                                                          ),
                                                                    ),
                                                                      maxLines: 1,
                                                                      overflow:
                                                                          TextOverflow
                                                                              .ellipsis,
                                                                      overflow:
                                                                          TextOverflow
                                                                              .ellipsis,
                                                                      maxLines: 1,
                                                                      overflow:
                                                                          TextOverflow
                                                                              .ellipsis,
                                                                      overflow:
                                                                          TextOverflow
                                                                              .ellipsis,
                                                                      maxLines: 1,
                                                                      overflow:
                                                                          TextOverflow
                                                                              .ellipsis,
                            if (((_model.courseBySelectOutputV.isNotEmpty) ==
                                    true) &&
                                (_model.courseSelected2 == true))
                                                                          'enrol7sp' /* 교수님 업로드현황  */,
                                                                    overflow:
                                                                        TextOverflow
                                                                            .ellipsis,
                                                                      maxLines: 1,
                                                                      overflow:
                                                                          TextOverflow
                                                                              .ellipsis,
                            if (((_model.courseSectionOutputV.isNotEmpty) ==
                                    true) &&
                                (_model.courseSelected3 == true))
                                                                          'nxh0rhns' /* 교수님 업로드현황  */,
                                                                    overflow:
                                                                        TextOverflow
                                                                            .ellipsis,
                                                                      maxLines: 1,
                                                                      overflow:
                                                                          TextOverflow
                                                                              .ellipsis,
                            if (((_model.courseSectionOutputV.isNotEmpty) ==
                                    true) &&
                                (_model.courseSelected4 == true))
                                                                          'jo857j05' /* 교수님 업로드현황  */,
                                                                    overflow:
                                                                        TextOverflow
                                                                            .ellipsis,
                                                                      maxLines: 1,
                                                                      overflow:
                                                                          TextOverflow
                                                                              .ellipsis,
                                                                      fontSize: 22.0,
                                                                      fontSize: 22.0,
                                                                      fontSize: 22.0,
                                                                      fontSize: 22.0,
                                                                              fontSize: 22.0,
                                                                                      fontSize: 22.0,
                                                                                            fontSize: 18.0,
                                                                                      fontSize: 22.0,
                                                                                            fontSize: 18.0,
                                                                                      fontSize: 22.0,
                                                                                            fontSize: 18.0,
                                                                                      fontSize: 22.0,
                                                                                                fontSize: 18.0,
                                                                                      fontSize: 22.0,
                                                                                                fontSize: 18.0,
                                                                                      fontSize: 22.0,
                                                                                                fontSize: 18.0,
                                                  fontSize: 22.0,
                                                                          fontSize: 22.0,
                                                                      fontSize: 22.0,
                                                                          fontSize: 22.0,
                                                                              fontSize: 14.0,
                                                                              fontSize: 14.0,
                                                                                              fontSize: 12.0,
                                                                                              fontSize: 12.0,
                                                                                              fontSize: 12.0,
                                                                                              fontSize: 12.0,
                                                                                              fontSize: 12.0,
                                                                                              fontSize: 12.0,
                                                                          fontSize: 22.0,
                                                                              fontSize: 14.0,
                                                                              fontSize: 14.0,
                                                                                              fontSize: 12.0,
                                                                                              fontSize: 12.0,
                                                                                              fontSize: 12.0,
                                                                                              fontSize: 12.0,
                                                                                              fontSize: 12.0,
                                                                                              fontSize: 12.0,
                                                                          fontSize: 22.0,
                                                                              fontSize: 14.0,
                                                                              fontSize: 14.0,
                                                                                              fontSize: 12.0,
                                                                                              fontSize: 12.0,
                                                                                              fontSize: 12.0,
                                                                                              fontSize: 12.0,
                                                                                              fontSize: 12.0,
                                                                                              fontSize: 12.0,
                                                  fontSize: 22.0,
                                                                          fontSize: 22.0,
                                                                      fontSize: 22.0,
                                                                            fontSize: 14.0,
                                                                                fontSize: 14.0,
                                                                        fontSize: 22.0,
                                                                            fontSize: 14.0,
                                                                            fontSize: 14.0,
                                                                                              fontSize: 12.0,
                                                                                              fontSize: 12.0,
                                                                                              fontSize: 12.0,
                                                                                              fontSize: 12.0,
                                                                                              fontSize: 12.0,
                                                                                              fontSize: 12.0,
                                                  fontSize: 22.0,
                                                                          fontSize: 22.0,
                                                                      fontSize: 22.0,
                                                                            fontSize: 14.0,
                                                                                fontSize: 14.0,
                                                                        fontSize: 22.0,
                                                                            fontSize: 14.0,
                                                                            fontSize: 14.0,
                                                                                              fontSize: 12.0,
                                                                                              fontSize: 12.0,
                                                                                              fontSize: 12.0,
                                                                                              fontSize: 12.0,
                                                                                              fontSize: 12.0,
                                                                                              fontSize: 12.0,
                                                  fontSize: 22.0,
                                                                          fontSize: 22.0,
                                                                      fontSize: 22.0,
                                                                            fontSize: 14.0,
                                                                                fontSize: 14.0,
                                                                        fontSize: 22.0,
                                                                            fontSize: 14.0,
                                                                            fontSize: 14.0,
                                                                                              fontSize: 12.0,
                                                                                              fontSize: 12.0,
                                                                                              fontSize: 12.0,
                                                                                              fontSize: 12.0,
                                                                                              fontSize: 12.0,
                                                                                              fontSize: 12.0,
                                                                      fontSize:
                                                                          25.0,
                                                                      fontSize:
                                                                          25.0,
                                                                      fontSize:
                                                                          25.0,
                                                                      fontSize:
                                                                          25.0,
                                                                              fontSize: 25.0,
                                                                                      fontSize: 25.0,
                                                                                            fontSize: 20.0,
                                                                                      fontSize: 25.0,
                                                                                            fontSize: 20.0,
                                                                                      fontSize: 25.0,
                                                                                            fontSize: 20.0,
                                                                                      fontSize: 25.0,
                                                                                                fontSize: 20.0,
                                                                                      fontSize: 25.0,
                                                                                                fontSize: 20.0,
                                                                                      fontSize: 25.0,
                                                                                                fontSize: 20.0,
                            if ((((_model.courseSectionOutputV.isNotEmpty) == true) &&
                                    (_model.courseSelected1 == true)))
                                                  fontSize: 25.0,
                                                                          fontSize:
                                                                              25.0,
                                                                      fontSize:
                                                                          25.0,
                                                              child: Visibility(
                                                                visible:
                                                                    true,
                                                                child: Padding(
                                                                  padding: EdgeInsetsDirectional
                                                                      .fromSTEB(
                                                                          0.0,
                                                                          3.0,
                                                                          0.0,
                                                                          0.0),
                                                                  child: Row(
                                                                    mainAxisSize:
                                                                        MainAxisSize
                                                                            .min,
                                                                    mainAxisAlignment:
                                                                        MainAxisAlignment
                                                                            .start,
                                                                    children: [
                                                                                  fontSize: () {
                                                                                    if (MediaQuery.sizeOf(context).width < kBreakpointSmall) {
                                                                                      return 8.0;
                                                                                    } else if (MediaQuery.sizeOf(context).width < kBreakpointMedium) {
                                                                                      return 10.0;
                                                                                    } else if (MediaQuery.sizeOf(context).width < kBreakpointLarge) {
                                                                                      return 12.0;
                                                                                    } else {
                                                                                      return 15.0;
                                                                                    }
                                                                                  }(),
                                                                          fontSize:
                                                                              23.0,
                                                                              fontSize: 15.0,
                                                                              fontSize: 15.0,
                                                                      overflow: TextOverflow.ellipsis,
                                                                                              fontSize: 13.0,
                                                                                              fontSize: 13.0,
                                                                                              fontSize: 13.0,
                                                                                              fontSize: 13.0,
                                                                                              fontSize: 13.0,
                                                                                              fontSize: 13.0,
                                                                      overflow: TextOverflow.ellipsis,
                                                                          fontSize:
                                                                              23.0,
                                                                              fontSize: 15.0,
                                                                              fontSize: 15.0,
                                                                      overflow: TextOverflow.ellipsis,
                                                                                              fontSize: 13.0,
                                                                                              fontSize: 13.0,
                                                                                              fontSize: 13.0,
                                                                                              fontSize: 13.0,
                                                                                              fontSize: 13.0,
                                                                                              fontSize: 13.0,
                                                                      overflow: TextOverflow.ellipsis,
                                                                          fontSize:
                                                                              23.0,
                                                                              fontSize: 15.0,
                                                                              fontSize: 15.0,
                                                                      overflow: TextOverflow.ellipsis,
                                                                                              fontSize: 13.0,
                                                                                              fontSize: 13.0,
                                                                                              fontSize: 13.0,
                                                                                              fontSize: 13.0,
                                                                                              fontSize: 13.0,
                                                                                              fontSize: 13.0,
                                                                      overflow: TextOverflow.ellipsis,
                            if ((((_model.courseBySelectOutputV.isNotEmpty) == true) &&
                                    (_model.courseSelected2 == true)))
                                                  fontSize: 25.0,
                                                                          fontSize:
                                                                              25.0,
                                                                      fontSize:
                                                                          25.0,
                                                                            fontSize:
                                                                                15.0,
                                                                                fontSize: 15.0,
                                                                        fontSize:
                                                                            23.0,
                                                                            fontSize:
                                                                                15.0,
                                                                            fontSize:
                                                                                15.0,
                                                                      'enrol7sp' /* 교수님 업로드현황  */,
                                                                      maxLines: 1,
                                                                      overflow: TextOverflow.ellipsis,
                                                                                              fontSize: 13.0,
                                                                                              fontSize: 13.0,
                                                                                              fontSize: 13.0,
                                                                                              fontSize: 13.0,
                                                                                              fontSize: 13.0,
                                                                                              fontSize: 13.0,
                                                                      overflow: TextOverflow.ellipsis,
                            if ((((_model.courseSectionOutputV.isNotEmpty) == true) &&
                                    (_model.courseSelected3 == true)))
                                                  fontSize: 25.0,
                                                                          fontSize:
                                                                              25.0,
                                                                      fontSize:
                                                                          25.0,
                                                                            fontSize:
                                                                                15.0,
                                                                                fontSize: 15.0,
                                                                        fontSize:
                                                                            23.0,
                                                                            fontSize:
                                                                                15.0,
                                                                            fontSize:
                                                                                15.0,
                                                                      'nxh0rhns' /* 교수님 업로드현황  */,
                                                                      maxLines: 1,
                                                                      overflow: TextOverflow.ellipsis,
                                                                                              fontSize: 13.0,
                                                                                              fontSize: 13.0,
                                                                                              fontSize: 13.0,
                                                                                              fontSize: 13.0,
                                                                                              fontSize: 13.0,
                                                                                              fontSize: 13.0,
                                                                      overflow: TextOverflow.ellipsis,
                            if ((((_model.courseSectionOutputV.isNotEmpty) == true) &&
                                    (_model.courseSelected4 == true)))
                                                  fontSize: 25.0,
                                                                          fontSize:
                                                                              25.0,
                                                                      fontSize:
                                                                          25.0,
                                                                            fontSize:
                                                                                15.0,
                                                                                fontSize: 15.0,
                                                                        fontSize:
                                                                            23.0,
                                                                            fontSize:
                                                                                15.0,
                                                                            fontSize:
                                                                                15.0,
                                                                      'jo857j05' /* 교수님 업로드현황  */,
                                                                      maxLines: 1,
                                                                      overflow: TextOverflow.ellipsis,
                                                                                              fontSize: 13.0,
                                                                                              fontSize: 13.0,
                                                                                              fontSize: 13.0,
                                                                                              fontSize: 13.0,
                                                                                              fontSize: 13.0,
                                                                                              fontSize: 13.0,
                                                                      overflow: TextOverflow.ellipsis,
                    ),
            ),
                            if ((((_model.courseSectionOutputV.isNotEmpty) ==
                                        true) &&
                                                            child: Padding(
                                                              child: Padding(
                                                                padding:
                                                                    EdgeInsetsDirectional
                                                                        .fromSTEB(
                                                                            0.0,
                                                                            3.0,
                                                                            0.0,
                                                                            0.0),
                                                                child: Row(
                                                                                  fontSize: 12.0,
                            if ((((_model.courseBySelectOutputV.isNotEmpty) ==
                                        true) &&
                            if ((((_model.courseSectionOutputV.isNotEmpty) ==
                                        true) &&
                            if ((((_model.courseSectionOutputV.isNotEmpty) ==
                                        true) &&
                    ],
            ],
                            if (((_model.courseSectionOutputV.isNotEmpty) ==
                                    true) &&
                                (_model.courseSelected1 == true))
                                                              child: Visibility(
                                                                visible: true,
                                                                child: Padding(
                                                                  padding: EdgeInsetsDirectional
                                                                      .fromSTEB(
                                                                          0.0,
                                                                          3.0,
                                                                          0.0,
                                                                          0.0),
                                                                  child: Row(
                            if (((_model.courseBySelectOutputV.isNotEmpty) ==
                                    true) &&
                                (_model.courseSelected2 == true))
                            if (((_model.courseSectionOutputV.isNotEmpty) ==
                                    true) &&
                                (_model.courseSelected3 == true))
                            if (((_model.courseSectionOutputV.isNotEmpty) ==
                                    true) &&
                                (_model.courseSelected4 == true))
                            if ((_model.buttonGrades != null) &&
                                responsiveVisibility(
                                  context: context,
                                  phone: false,
                                ))
                            if ((((_model.courseSectionOutputV.isNotEmpty) ==
                                        true) &&
                                    (_model.courseSelected1 == true)) &&
                                responsiveVisibility(
                                  context: context,
                                  phone: false,
                                ))
                                                          if (responsiveVisibility(
                                                            context: context,
                                                            phone: false,
                                                          ))
                                                            Flexible(
                                                              child: Padding(
                                                                visible:
                                                                    responsiveVisibility(
                                                                  context:
                                                                      context,
                                                                  phone: false,
                                                                ),
                                                                      maxLines: 1,
                                                                      overflow: TextOverflow.ellipsis,
                                                                      maxLines: 1,
                                                                      overflow: TextOverflow.ellipsis,
                                                                      maxLines: 1,
                                                                      overflow: TextOverflow.ellipsis,
                            if ((((_model.courseBySelectOutputV.isNotEmpty) ==
                                        true) &&
                                    (_model.courseSelected2 == true)) &&
                                responsiveVisibility(
                                  context: context,
                                  phone: false,
                                ))
                                                                    maxLines: 1,
                                                                    overflow: TextOverflow.ellipsis,
                            if ((((_model.courseSectionOutputV.isNotEmpty) ==
                                        true) &&
                                    (_model.courseSelected3 == true)) &&
                                responsiveVisibility(
                                  context: context,
                                  phone: false,
                                ))
                                                                    maxLines: 1,
                                                                    overflow: TextOverflow.ellipsis,
                            if ((((_model.courseSectionOutputV.isNotEmpty) ==
                                        true) &&
                                    (_model.courseSelected4 == true)) &&
                                responsiveVisibility(
                                  context: context,
                                  phone: false,
                                ))
                                                                    maxLines: 1,
                                                                    overflow: TextOverflow.ellipsis,
                                                                              fontSize: 22.0,
                                                                                      fontSize: 22.0,
                                                                                            fontSize: 18.0,
                                                                                      fontSize: 22.0,
                                                                                            fontSize: 18.0,
                                                                                      fontSize: 22.0,
                                                                                            fontSize: 18.0,
                                                                                      fontSize: 22.0,
                                                                              constraints: BoxConstraints(
                                                                                minWidth: 200.0,
                                                                              ),
                                                                                                fontSize: 18.0,
                                                                                      fontSize: 22.0,
                                                                              constraints: BoxConstraints(
                                                                                minWidth: 200.0,
                                                                              ),
                                                                                                fontSize: 18.0,
                                                                                      fontSize: 22.0,
                                                                              constraints: BoxConstraints(
                                                                                minWidth: 200.0,
                                                                              ),
                                                                                                fontSize: 18.0,
                            if (_model.buttonGrades != null)
                            if (((_model.courseSectionOutputV.isNotEmpty) ==
                                    true) &&
                                (_model.courseSelected1 == true))
                                                  fontSize: 22.0,
                                                          Flexible(
                                                              child: Padding(
                                                                              fontSize: 16.0,
                                                                              fontSize: 16.0,
                                                                            'yc2tezrq' /* 교수님 업로드현황  */,
                                                                              constraints: BoxConstraints(
                                                                                minWidth: 200.0,
                                                                              ),
                                                                                              fontSize: 12.0,
                                                                                              fontSize: 12.0,
                                                                                              fontSize: 12.0,
                                                                                              fontSize: 12.0,
                                                                                              fontSize: 12.0,
                                                                                              fontSize: 12.0,
                                                                      maxLines: 1,
                                                                      overflow: TextOverflow.ellipsis,
                                                                                              fontSize: 16.0,
                                                                                              fontSize: 16.0,
                                                                              fontSize: 16.0,
                                                                              fontSize: 16.0,
                                                                              constraints: BoxConstraints(
                                                                                minWidth: 200.0,
                                                                              ),
                                                                                              fontSize: 12.0,
                                                                                              fontSize: 12.0,
                                                                                              fontSize: 12.0,
                                                                                              fontSize: 12.0,
                                                                                              fontSize: 12.0,
                                                                                              fontSize: 12.0,
                                                                      maxLines: 1,
                                                                      overflow: TextOverflow.ellipsis,
                                                                                              fontSize: 16.0,
                                                                                              fontSize: 16.0,
                                                                              fontSize: 16.0,
                                                                              fontSize: 16.0,
                                                                              constraints: BoxConstraints(
                                                                                minWidth: 200.0,
                                                                              ),
                                                                                              fontSize: 12.0,
                                                                                              fontSize: 12.0,
                                                                                              fontSize: 12.0,
                                                                                              fontSize: 12.0,
                                                                                              fontSize: 12.0,
                                                                                              fontSize: 12.0,
                                                                      maxLines: 1,
                                                                      overflow: TextOverflow.ellipsis,
                                                                                              fontSize: 16.0,
                                                                                              fontSize: 16.0,
                            if (((_model.courseBySelectOutputV.isNotEmpty) ==
                                    true) &&
                                (_model.courseSelected2 == true))
                                                  fontSize: 22.0,
                                                                                fontSize: 16.0,
                                                                                              fontSize: 12.0,
                                                                                              fontSize: 12.0,
                                                                                              fontSize: 12.0,
                                                                                              fontSize: 12.0,
                                                                                              fontSize: 12.0,
                                                                                              fontSize: 12.0,
                                                                      maxLines: 1,
                                                                      overflow: TextOverflow.ellipsis,
                                                                                              fontSize: 16.0,
                                                                                              fontSize: 16.0,
                            if (((_model.courseSectionOutputV.isNotEmpty) ==
                                    true) &&
                                (_model.courseSelected3 == true))
                                                  fontSize: 22.0,
                                                                                fontSize: 16.0,
                                                                                              fontSize: 12.0,
                                                                                              fontSize: 12.0,
                                                                                              fontSize: 12.0,
                                                                                              fontSize: 12.0,
                                                                                              fontSize: 12.0,
                                                                                              fontSize: 12.0,
                                                                      maxLines: 1,
                                                                      overflow: TextOverflow.ellipsis,
                                                                                              fontSize: 16.0,
                                                                                              fontSize: 16.0,
                            if (((_model.courseSectionOutputV.isNotEmpty) ==
                                    true) &&
                                (_model.courseSelected4 == true))
                                                  fontSize: 22.0,
                                                                                fontSize: 16.0,
                                                                                              fontSize: 12.0,
                                                                                              fontSize: 12.0,
                                                                                              fontSize: 12.0,
                                                                                              fontSize: 12.0,
                                                                                              fontSize: 12.0,
                                                                                              fontSize: 12.0,
                                                                      maxLines: 1,
                                                                      overflow: TextOverflow.ellipsis,
                                                                                              fontSize: 16.0,
                                                                                              fontSize: 16.0,
                    ),
                                                              width: 450.0,
                                                                              fontSize: 25.0,
                                                                                      fontSize: 25.0,
                                                                                            fontSize: 20.0,
                                                                                      fontSize: 25.0,
                                                                                            fontSize: 20.0,
                                                                                      fontSize: 25.0,
                                                                                            fontSize: 20.0,
                                                                  width: 450.0,
                                                                                      fontSize: 25.0,
                                                                                                fontSize: 20.0,
                                                                  width: 450.0,
                                                                                      fontSize: 25.0,
                                                                                                fontSize: 20.0,
                                                                  width: 450.0,
                                                                                      fontSize: 25.0,
                                                                                                fontSize: 20.0,
                                height: 800.0,
                                                  fontSize: 25.0,
                                                            child: Padding(
                                                                padding:
                                                                    EdgeInsetsDirectional
                                                                        .fromSTEB(
                                                                            0.0,
                                                                            3.0,
                                                                            0.0,
                                                                            0.0),
                                                                child: Row(
                                                                  mainAxisSize:
                                                                      MainAxisSize
                                                                          .min,
                                                                  mainAxisAlignment:
                                                                      MainAxisAlignment
                                                                          .start,
                                                                  children: [
                                                                    Text(
                                                                      FFLocalizations.of(
                                                                              context)
                                                                          .getText(
                                                                        'i4hpyeyi' /* 0% */,
                                                                      style: FlutterFlowTheme.of(
                                                                              context)
                                                                          .bodyMedium
                                                                          .override(
                                                                            font: GoogleFonts
                                                                                .openSans(
                                                                              fontWeight:
                                                                                  FontWeight.w500,
                                                                              fontStyle: FlutterFlowTheme.of(
                                                                                      context)
                                                                                  .bodyMedium
                                                                                  .fontStyle,
                                                                            ),
                                                                            color:
                                                                                FlutterFlowTheme.of(context)
                                                                                    .secondaryText,
                                                                            fontSize:
                                                                                12.0,
                                                                            letterSpacing:
                                                                                0.0,
                                                                            fontWeight:
                                                                                FontWeight.w500,
                                                                            fontStyle:
                                                                                FlutterFlowTheme.of(context)
                                                                                    .bodyMedium
                                                                                    .fontStyle,
                                                                          ),
                                                                    ),
                                                                    Flexible(
                                                                      child:
                                                                          Align(
                                                                        alignment:
                                                                            AlignmentDirectional(
                                                                                1.0,
                                                                                0.0),
                                                                        child: Text(
                                                                          FFLocalizations.of(
                                                                                  context)
                                                                              .getText(
                                                                            '7tz9j7qq' /* 100% */,
                                                                          ),
                                                                          textAlign:
                                                                              TextAlign.center,
                                                                          style: FlutterFlowTheme.of(
                                                                                  context)
                                                                              .bodyMedium
                                                                              .override(
                                                                                font:
                                                                                    GoogleFonts.openSans(
                                                                                  fontStyle:
                                                                                      FlutterFlowTheme.of(context)
                                                                                          .bodyMedium
                                                                                          .fontStyle,
                                                                                color:
                                                                                    FlutterFlowTheme.of(context)
                                                                                        .secondaryText,
                                                                                fontSize:
                                                                                    12.0,
                                                                                letterSpacing:
                                                                                    0.0,
                                                                                fontWeight:
                                                                                    FontWeight.w500,
                                                                                fontStyle:
                                                                                    FlutterFlowTheme.of(context)
                                                                                        .bodyMedium
                                                                                        .fontStyle,
                                                                              ),
                                                                    ),
                                                                  ],
                                                                              fontSize: 15.0,
                                                                              fontSize: 15.0,
                                                                        'yc2tezrq' /* 교수님 업로드현황  */,
                                                                      maxLines: 1,
                                                                      overflow: TextOverflow.ellipsis,
                                                                                              fontSize: 13.0,
                                                                                              fontSize: 13.0,
                                                                                              fontSize: 13.0,
                                                                                              fontSize: 13.0,
                                                                                              fontSize: 13.0,
                                                                                              fontSize: 13.0,
                                                                                              fontSize: 14.0,
                                                                                              fontSize: 14.0,
                                                                              fontSize: 15.0,
                                                                              fontSize: 15.0,
                                                                      maxLines: 1,
                                                                      overflow: TextOverflow.ellipsis,
                                                                                              fontSize: 13.0,
                                                                                              fontSize: 13.0,
                                                                                              fontSize: 13.0,
                                                                                              fontSize: 13.0,
                                                                                              fontSize: 13.0,
                                                                                              fontSize: 13.0,
                                                                                              fontSize: 14.0,
                                                                                              fontSize: 14.0,
                                                                              fontSize: 15.0,
                                                                              fontSize: 15.0,
                                                                      maxLines: 1,
                                                                      overflow: TextOverflow.ellipsis,
                                                                                              fontSize: 13.0,
                                                                                              fontSize: 13.0,
                                                                                              fontSize: 13.0,
                                                                                              fontSize: 13.0,
                                                                                              fontSize: 13.0,
                                                                                              fontSize: 13.0,
                                                                                              fontSize: 14.0,
                                                                                              fontSize: 14.0,
                                                  fontSize: 25.0,
                                                                                fontSize: 15.0,
                                                                  maxLines: 1,
                                                                  overflow: TextOverflow.ellipsis,
                                                                                              fontSize: 13.0,
                                                                                              fontSize: 13.0,
                                                                                              fontSize: 13.0,
                                                                                              fontSize: 13.0,
                                                                                              fontSize: 13.0,
                                                                                              fontSize: 13.0,
                                                                                              fontSize: 14.0,
                                                                                              fontSize: 14.0,
                                                  fontSize: 25.0,
                                                                                fontSize: 15.0,
                                                                  maxLines: 1,
                                                                  overflow: TextOverflow.ellipsis,
                                                                                              fontSize: 13.0,
                                                                                              fontSize: 13.0,
                                                                                              fontSize: 13.0,
                                                                                              fontSize: 13.0,
                                                                                              fontSize: 13.0,
                                                                                              fontSize: 13.0,
                                                                                              fontSize: 14.0,
                                                                                              fontSize: 14.0,
                                                  fontSize: 25.0,
                                                                                fontSize: 15.0,
                                                                  maxLines: 1,
                                                                  overflow: TextOverflow.ellipsis,
                                                                                              fontSize: 13.0,
                                                                                              fontSize: 13.0,
                                                                                              fontSize: 13.0,
                                                                                              fontSize: 13.0,
                                                                                              fontSize: 13.0,
                                                                                              fontSize: 13.0,
                                                                                              fontSize: 14.0,
                                                                                              fontSize: 14.0,
                    ],

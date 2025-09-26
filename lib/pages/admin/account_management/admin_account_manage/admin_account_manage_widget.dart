import '/backend/supabase/supabase.dart';
import '/components/account_manage/account_manage_row/account_manage_row_widget.dart';
import '/components/account_manage/account_manage_row_mobile/account_manage_row_mobile_widget.dart';
import '/components/default_layout/borderline/borderline_widget.dart';
import '/components/default_layout/headers/header_mobile/header_mobile_widget.dart';
import '/components/default_layout/nav_bar/admin_navi_sidebar/admin_navi_sidebar_widget.dart';
import '/flutter_flow/flutter_flow_drop_down.dart';
import '/flutter_flow/flutter_flow_icon_button.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import '/flutter_flow/form_field_controller.dart';
import 'dart:math' as math;
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:uuid/uuid.dart';
import 'admin_account_manage_model.dart';
export 'admin_account_manage_model.dart';

class AdminAccountManageWidget extends StatefulWidget {
  const AdminAccountManageWidget({
    super.key,
    required this.userType,
    required this.email,
  });

  final int? userType;
  final String? email;

  static String routeName = 'AdminAccountManage';
  static String routePath = '/AdminAccountManage';

  @override
  State<AdminAccountManageWidget> createState() =>
      _AdminAccountManageWidgetState();
}

class _AdminAccountManageWidgetState extends State<AdminAccountManageWidget> {
  late AdminAccountManageModel _model;

  final scaffoldKey = GlobalKey<ScaffoldState>();

  void _showSnackBar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(message)),
    );
  }

  void _showError(String message) {
    _showSnackBar(message);
  }

  Future<List<PostsRow>> searchPosts(String? searchType, String? searchText) async {
    final keyword = searchText?.trim() ?? '';

    final posts = await PostsTable().queryRows(
      queryFn: (q) {
        var query = q.order('name', ascending: true);
        if (keyword.isNotEmpty) {
          query = query.ilike('name', '%$keyword%');
        }
        return query;
      },
    );

    final adminRows = await AdminPostTable().queryRows(
      queryFn: (q) => q.order('adminId', ascending: true),
    );
    _model.adminPostRows = adminRows;

    final merged = _mergeWithAdminPosts(posts, adminRows: adminRows);
    if (keyword.isEmpty) {
      return merged;
    }
    final lowerKeyword = keyword.toLowerCase();
    return merged
        .where((row) => (row.name ?? '').toLowerCase().contains(lowerKeyword))
        .toList();
  }

  String _userTypeLabel(int? userType) {
    switch (userType) {
      case 0:
        return '마스터';
      case 1:
        return '전임';
      case 2:
        return '겸임';
      case 4:
        return '조교';
      case 3:
      default:
        return '일반';
    }
  }

  Future<void> _initializeData() async {
    _model.isLoading = true;
    safeSetState(() {});
    await _loadPostsAndClasses(resetSearch: true);
    _setupRealtimeSubscription();
    _model.isLoading = false;
    safeSetState(() {});
  }

  Future<void> _loadPostsAndClasses({required bool resetSearch}) async {
    await Future.wait([
      _loadPosts(resetSearch: resetSearch),
      _loadClasses(),
    ]);
    FFAppState().usertype = 0;
  }

  Future<void> _loadPosts({required bool resetSearch}) async {
    try {
      final posts = await PostsTable().queryRows(
        queryFn: (q) => q.order('name', ascending: true),
      );
      final adminRows = await AdminPostTable().queryRows(
        queryFn: (q) => q.order('adminId', ascending: true),
      );
      _model.adminPostRows = adminRows;
      _model.basePosts = posts.map((row) {
        final cloned = PostsRow(Map<String, dynamic>.from(row.data));
        cloned.userType = cloned.userType ?? 3;
        cloned.position = _userTypeLabel(cloned.userType);
        return cloned;
      }).toList();
      final merged = _mergeWithAdminPosts(_model.basePosts);
      if (resetSearch) {
        _model.isSearching = false;
        _model.currentSearchKeyword = '';
      }
      _applyPostsData(merged,
          resetPage: resetSearch, preserveSearch: !resetSearch);
    } catch (e) {
      _showError('데이터 로드 실패: $e');
      _model.basePosts = [];
      _model.adminPostRows = [];
      _model.prfoutput = [];
      _model.paginatedPosts = [];
    }
  }

  Future<void> _loadClasses() async {
    try {
      _model.classSelectedOnload = await ClassTable().queryRows(
        queryFn: (q) => q,
      );
      _applyClassFilters();
    } catch (e) {
      _showError('강의 정보 로드 실패: $e');
      _model.classSelectedOnload = [];
      _model.classOnload = [];
    }
  }

  void _applyPostsData(List<PostsRow> posts,
      {bool resetPage = false, bool preserveSearch = true}) {
    final sorted = [...posts]
      ..sort(
        (a, b) => (a.name ?? '').compareTo(b.name ?? ''),
      );
    _model.allPosts = sorted;
    final previousSelection = _model.selectedProfessorId;
    if (!preserveSearch) {
      _model.isSearching = false;
      _model.currentSearchKeyword = '';
    }
    final filtered = _filterPosts(sorted);
    _model.prfoutput = filtered;
    if (resetPage) {
      _model.currentPage = 1;
    }
    final selectedId = previousSelection != null &&
            filtered.any((row) => row.id == previousSelection)
        ? previousSelection
        : filtered.firstOrNull?.id ?? sorted.firstOrNull?.id;
    _model.selectedProfessorId = selectedId;
    final selectedRow = selectedId == null
        ? null
        : filtered
                .where((row) => row.id == selectedId)
                .firstOrNull ??
            sorted.where((row) => row.id == selectedId).firstOrNull;
    _model.profeesorName = valueOrDefault<String>(
      selectedRow?.name ?? filtered.firstOrNull?.name ?? sorted.firstOrNull?.name,
      '교수 이름',
    );
    _updatePagination(resetPage: resetPage);
    _applyClassFilters();
  }

  List<PostsRow> _filterPosts(List<PostsRow> source) {
    if (!_model.isSearching || _model.currentSearchKeyword.isEmpty) {
      return List<PostsRow>.from(source);
    }
    final keyword = _model.currentSearchKeyword;
    final lowerKeyword = keyword.toLowerCase();
    return source
        .where(
            (row) => (row.name ?? '').toLowerCase().contains(lowerKeyword))
        .toList();
  }

  List<PostsRow> _mergeWithAdminPosts(List<PostsRow> source,
      {List<AdminPostRow>? adminRows}) {
    if (source.isEmpty) {
      return [];
    }
    final effectiveAdminRows = adminRows ?? _model.adminPostRows;
    if (effectiveAdminRows.isEmpty) {
      return source.map((row) {
        final cloned = PostsRow(Map<String, dynamic>.from(row.data));
        cloned.userType = cloned.userType ?? 3;
        cloned.position = _userTypeLabel(cloned.userType);
        return cloned;
      }).toList();
    }
    final adminMap = {
      for (final admin in effectiveAdminRows)
        admin.adminId.toLowerCase(): admin,
    };
    return source.map((row) {
      final cloned = PostsRow(Map<String, dynamic>.from(row.data));
      final emailKey = (cloned.email ?? '').toLowerCase();
      final admin = adminMap[emailKey];
      if (admin != null) {
        final adminName = admin.name;
        if (adminName != null && adminName.isNotEmpty) {
          cloned.name = adminName;
        }
        final adminRole = admin.role;
        if (adminRole.isNotEmpty) {
          cloned.permissionLevel = _permissionLevelFromRole(adminRole);
        }
        final adminUserType = admin.userType;
        if (adminUserType != null) {
          cloned.userType = adminUserType;
        }
      }
      cloned.userType = cloned.userType ?? 3;
      cloned.position = _userTypeLabel(cloned.userType);
      return cloned;
    }).toList();
  }

  int _permissionLevelFromRole(String role) {
    final normalized = role.toLowerCase().trim();
    if (normalized.contains('master') ||
        normalized.contains('admin') ||
        normalized.contains('관리')) {
      return 2;
    }
    return 1;
  }

  String _roleFromPermissionLevel(int level) => level >= 2 ? 'MASTER' : 'MEMBER';

  void _updateBasePostRow(int postId, Map<String, dynamic> updatedData) {
    if (_model.basePosts.isEmpty) {
      return;
    }
    final index = _model.basePosts.indexWhere((row) => row.id == postId);
    if (index == -1) {
      return;
    }
    final baseRow = _model.basePosts[index];
    updatedData.forEach((key, value) {
      baseRow.setField(key, value);
    });
  }

  void _refreshMergedPosts() {
    if (_model.basePosts.isEmpty) {
      return;
    }
    final merged = _mergeWithAdminPosts(_model.basePosts);
    _applyPostsData(merged, preserveSearch: true);
    safeSetState(() {});
  }

  Future<void> _ensureAdminPostRecord(
    PostsRow post,
    Map<String, dynamic> updatedData,
  ) async {
    final email = post.email;
    if (email == null || email.isEmpty) {
      return;
    }
    final effectiveName =
        (updatedData['name'] as String?) ?? post.name ?? '';
    final effectivePermission =
        (updatedData['permission_level'] as int?) ??
            post.permissionLevel ??
            1;
    final effectiveUserType =
        (updatedData['user_type'] as int?) ?? post.userType ?? 0;
    final roleValue = _roleFromPermissionLevel(effectivePermission);

    final existing = await AdminPostTable().queryRows(
      queryFn: (q) => q.eq('adminId', email).limit(1),
    );

    if (existing.isEmpty) {
      final inserted = await AdminPostTable().insert({
        'adminId': email,
        'AdminInfo': const Uuid().v4(),
        'name': effectiveName,
        'user_type': effectiveUserType,
        'role': roleValue,
      });
      _model.adminPostRows = [
        ..._model.adminPostRows
            .where((row) => row.adminId.toLowerCase() != email.toLowerCase()),
        inserted,
      ];
    } else {
      final adminRow = existing.first;
      final updatePayload = {
        'name': effectiveName,
        'user_type': effectiveUserType,
        'role': roleValue,
      };
      await AdminPostTable().update(
        data: updatePayload,
        matchingRows: (rows) => rows.eq('id', adminRow.id),
      );
      adminRow.name = effectiveName;
      adminRow.userType = effectiveUserType;
      adminRow.role = roleValue;
    }
  }

  Future<void> _handlePostEdit(
    PostsRow post,
    Map<String, dynamic> updatedData,
  ) async {
    try {
      await _ensureAdminPostRecord(post, updatedData);
      if (updatedData.isNotEmpty) {
        _updateBasePostRow(post.id, updatedData);
      }
      _refreshMergedPosts();
    } catch (e) {
      _showError('관리자 정보 동기화 실패: $e');
    }
  }

  void _updatePagination({bool resetPage = false}) {
    final data = List<PostsRow>.from(_model.prfoutput ?? []);
    if (resetPage) {
      _model.currentPage = 1;
    }
    final totalCount = data.length;
    final totalPages = totalCount == 0
        ? 1
        : ((totalCount - 1) ~/ _model.itemsPerPage) + 1;
    if (_model.currentPage > totalPages) {
      _model.currentPage = totalPages;
    }
    if (_model.currentPage < 1) {
      _model.currentPage = 1;
    }
    final startIndex = (_model.currentPage - 1) * _model.itemsPerPage;
    final endIndex = math.min(startIndex + _model.itemsPerPage, totalCount);
    if (startIndex < 0 || startIndex >= totalCount) {
      _model.paginatedPosts = [];
      return;
    }
    _model.paginatedPosts = data.sublist(startIndex, endIndex);
  }

  int get _totalPages {
    final total = _model.prfoutput?.length ?? 0;
    if (total == 0) {
      return 1;
    }
    return ((total - 1) ~/ _model.itemsPerPage) + 1;
  }

  String? _validateSearchInput(String? value) {
    if (value == null || value.trim().isEmpty) {
      return '검색어를 입력해주세요';
    }
    return null;
  }

  Future<void> _refreshData() async {
    _model.isLoading = true;
    safeSetState(() {});
    await _loadPostsAndClasses(resetSearch: false);
    _model.isLoading = false;
    safeSetState(() {});
  }

  void _applyClassFilters() {
    if (_model.classSelectedOnload == null) {
      return;
    }
    _model.classOnload = _model.classSelectedOnload!
        .where((e) =>
            e.year == _model.years &&
            e.semester == _model.semester &&
            (_model.selectedProfessorId == null ||
                e.professorId == _model.selectedProfessorId))
        .toList()
        .cast<ClassRow>();
  }

  void _setupRealtimeSubscription() {
    _model.postsSubscription?.cancel();
    _model.postsSubscription = Supabase.instance.client
        .from('posts')
        .stream(primaryKey: ['id'])
        .listen((data) {
      final rows = data.map((row) => PostsRow(row)).toList();
      _model.basePosts = rows
          .map((row) => PostsRow(Map<String, dynamic>.from(row.data)))
          .toList();
      final merged = _mergeWithAdminPosts(_model.basePosts);
      _applyPostsData(merged, preserveSearch: true);
      safeSetState(() {});
    }, onError: (error) {
      _showError('실시간 데이터 수신 실패: $error');
    });
    _model.adminPostSubscription?.cancel();
    _model.adminPostSubscription = Supabase.instance.client
        .from('admin_post')
        .stream(primaryKey: ['id'])
        .listen((data) {
      _model.adminPostRows = data.map((row) => AdminPostRow(row)).toList();
      if (_model.basePosts.isEmpty) {
        return;
      }
      final merged = _mergeWithAdminPosts(_model.basePosts);
      _applyPostsData(merged, preserveSearch: true);
      safeSetState(() {});
    }, onError: (error) {
      _showError('관리자 계정 실시간 수신 실패: $error');
    });
  }

  void _handlePageChange(bool isNext) {
    if (isNext) {
      if (_model.currentPage < _totalPages) {
        _model.currentPage += 1;
        _updatePagination();
        safeSetState(() {});
      }
    } else {
      if (_model.currentPage > 1) {
        _model.currentPage -= 1;
        _updatePagination();
        safeSetState(() {});
      }
    }
  }

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => AdminAccountManageModel());

    SchedulerBinding.instance.addPostFrameCallback((_) async {
      try {
        _model.prfoutput = await PostsTable().queryRows(
          queryFn: (q) => q.order('name', ascending: true),
        );

        _model.profeesorName =
            _model.prfoutput?.firstOrNull?.name ?? '교수 이름';

        _model.classSelectedOnload = await ClassTable().queryRows(
          queryFn: (q) => q,
        );

        _model.classOnload = _model.classSelectedOnload!
            .where((e) => (e.year == _model.years) && (e.semester == _model.semester))
            .toList()
            .cast<ClassRow>();
      } catch (e) {
        print('초기화 에러: $e');
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('데이터 로드 실패: $e')),
        );
        _model.prfoutput = [];
        _model.classOnload = [];
      }

      FFAppState().usertype = 0;
      safeSetState(() {});
    });

    _model.textController1 ??= TextEditingController();
    _model.textFieldFocusNode1 ??= FocusNode();

    _model.textController2 ??= TextEditingController();
    _model.textFieldFocusNode2 ??= FocusNode();

    _model.dropDownValue ??= '이 름';
    _model.currentSearchType ??= _model.dropDownValue;
    _model.textController1Validator =
        (context, value) => _validateSearchInput(value);
    _model.textController2Validator =
        (context, value) => _validateSearchInput(value);

    WidgetsBinding.instance.addPostFrameCallback((_) => safeSetState(() {}));
  }

  @override
  void dispose() {
    _model.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    context.watch<FFAppState>();

    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
        FocusManager.instance.primaryFocus?.unfocus();
      },
      child: Scaffold(
        key: scaffoldKey,
        backgroundColor: FlutterFlowTheme.of(context).secondaryBackground,
        body: Stack(
          children: [
            Container(
              decoration: BoxDecoration(),
              child: Row(
                mainAxisSize: MainAxisSize.max,
                children: [
                  if (responsiveVisibility(
                    context: context,
                    phone: false,
                    tablet: false,
                  ))
                    wrapWithModel(
                      model: _model.adminNaviSidebarModel,
                      updateCallback: () => safeSetState(() {}),
                      child: AdminNaviSidebarWidget(
                        activePageName: 'AdminStudentId',
                        pageIsInSubMenu: false,
                      ),
                    ),
                  if (responsiveVisibility(
                    context: context,
                    phone: false,
                    tablet: false,
                  ))
                    Expanded(
                      flex: 1,
                      child: SingleChildScrollView(
                        child: Column(
                          mainAxisSize: MainAxisSize.max,
                          children: [
                            Container(
                              width: double.infinity,
                              height: 50.0,
                              decoration: BoxDecoration(
                                color: Color(0xFFEEF1F6),
                                shape: BoxShape.rectangle,
                              ),
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  if (responsiveVisibility(
                                    context: context,
                                    phone: false,
                                  ))
                                    Flexible(
                                      flex: 4,
                                      child: Padding(
                                        padding: EdgeInsetsDirectional.fromSTEB(
                                            10.0, 0.0, 0.0, 0.0),
                                        child: Container(
                                          width: double.infinity,
                                          height: double.infinity,
                                          decoration: BoxDecoration(),
                                          child: Row(
                                            mainAxisSize: MainAxisSize.min,
                                            children: [
                                              Flexible(
                                                flex: 2,
                                                child: Row(
                                                  mainAxisSize:
                                                      MainAxisSize.min,
                                                  children: [
                                                    Flexible(
                                                      flex: 1,
                                                      child: Padding(
                                                        padding:
                                                            EdgeInsetsDirectional
                                                                .fromSTEB(
                                                                    2.0,
                                                                    5.0,
                                                                    2.0,
                                                                    5.0),
                                                        child: FutureBuilder<
                                                            List<YearsRow>>(
                                                          future: YearsTable()
                                                              .queryRows(
                                                            queryFn: (q) => q,
                                                          ),
                                                          builder: (context,
                                                              snapshot) {
                                                            // Customize what your widget looks like when it's loading.
                                                            if (!snapshot
                                                                .hasData) {
                                                              return Center(
                                                                child: SizedBox(
                                                                  width: 50.0,
                                                                  height: 50.0,
                                                                  child:
                                                                      CircularProgressIndicator(
                                                                    valueColor:
                                                                        AlwaysStoppedAnimation<
                                                                            Color>(
                                                                      Color(
                                                                          0xFF284E75),
                                                                    ),
                                                                  ),
                                                                ),
                                                              );
                                                            }
                                                            List<YearsRow>
                                                                dropDown1YearsRowList =
                                                                snapshot.data!;

                                                            return FlutterFlowDropDown<
                                                                String>(
                                                              controller: _model
                                                                      .dropDown1ValueController ??=
                                                                  FormFieldController<
                                                                      String>(
                                                                _model.dropDown1Value ??=
                                                                    valueOrDefault<
                                                                        String>(
                                                                  dropDown1YearsRowList
                                                                      .lastOrNull
                                                                      ?.year,
                                                                  '2025',
                                                                ),
                                                              ),
                                                              options: dropDown1YearsRowList
                                                                  .map((e) =>
                                                                      e.year)
                                                                  .withoutNulls
                                                                  .toList(),
                                                              onChanged:
                                                                  (val) async {
                                                                safeSetState(() =>
                                                                    _model.dropDown1Value =
                                                                        val);
                                                                _model.years =
                                                                    valueOrDefault<
                                                                        String>(
                                                                  _model
                                                                      .dropDown1Value,
                                                                  '2025',
                                                                );
                                                                safeSetState(
                                                                    () {});
                                                                _model.semester =
                                                                    '1학기';
                                                                _model.buttonGrades =
                                                                    -1;
                                                                _model.semesterGradeOutput =
                                                                    [];
                                                                _model.yearsSemesterMapOutput =
                                                                    [];
                                                                _model.courseBySelectOutputVar =
                                                                    [];
                                                                _model.courseSectionOutputVar =
                                                                    [];
                                                                _model.classOnload = _model
                                                                    .classSelectedOnload!
                                                                    .where((e) =>
                                                                        (e.year ==
                                                                            _model
                                                                                .years) &&
                                                                        (e.semester ==
                                                                            _model
                                                                                .semester))
                                                                    .toList()
                                                                    .cast<
                                                                        ClassRow>();
                                                                _model.classAfterGrade =
                                                                    [];
                                                                _model.buttonColor1 =
                                                                    Color(
                                                                        4294967295);
                                                                _model.buttonColor2 =
                                                                    Color(
                                                                        4294967295);
                                                                _model.buttonColor3 =
                                                                    Color(
                                                                        4294967295);
                                                                _model.buttonColor4 =
                                                                    Color(
                                                                        4294967295);
                                                                _model.buttonColor5 =
                                                                    Color(
                                                                        4294967295);
                                                                _model.textColor1 =
                                                                    Color(
                                                                        4280831605);
                                                                _model.textColor2 =
                                                                    Color(
                                                                        4280831605);
                                                                _model.textColor3 =
                                                                    Color(
                                                                        4280831605);
                                                                _model.textColor4 =
                                                                    Color(
                                                                        4280831605);
                                                                _model.textColor5 =
                                                                    Color(
                                                                        4280831605);
                                                                safeSetState(
                                                                    () {});
                                                              },
                                                              width: 160.0,
                                                              height: 40.0,
                                                              textStyle:
                                                                  FlutterFlowTheme.of(
                                                                          context)
                                                                      .labelMedium
                                                                      .override(
                                                                        font: GoogleFonts
                                                                            .openSans(
                                                                          fontWeight: FlutterFlowTheme.of(context)
                                                                              .labelMedium
                                                                              .fontWeight,
                                                                          fontStyle: FlutterFlowTheme.of(context)
                                                                              .labelMedium
                                                                              .fontStyle,
                                                                        ),
                                                                        color: FlutterFlowTheme.of(context)
                                                                            .neutral500,
                                                                        fontSize:
                                                                            () {
                                                                          if (MediaQuery.sizeOf(context).width <
                                                                              kBreakpointSmall) {
                                                                            return 6.0;
                                                                          } else if (MediaQuery.sizeOf(context).width <
                                                                              kBreakpointMedium) {
                                                                            return 8.0;
                                                                          } else if (MediaQuery.sizeOf(context).width <
                                                                              kBreakpointLarge) {
                                                                            return 10.0;
                                                                          } else {
                                                                            return 12.0;
                                                                          }
                                                                        }(),
                                                                        letterSpacing:
                                                                            0.0,
                                                                        fontWeight: FlutterFlowTheme.of(context)
                                                                            .labelMedium
                                                                            .fontWeight,
                                                                        fontStyle: FlutterFlowTheme.of(context)
                                                                            .labelMedium
                                                                            .fontStyle,
                                                                      ),
                                                              hintText:
                                                                  FFLocalizations.of(
                                                                          context)
                                                                      .getText(
                                                                'ht5pe10u' /* 년도 선택 */,
                                                              ),
                                                              icon: Icon(
                                                                Icons
                                                                    .keyboard_arrow_down_sharp,
                                                                color: FlutterFlowTheme.of(
                                                                        context)
                                                                    .primaryText,
                                                                size: 16.0,
                                                              ),
                                                              fillColor: FlutterFlowTheme
                                                                      .of(context)
                                                                  .primaryBackground,
                                                              elevation: 0.0,
                                                              borderColor:
                                                                  FlutterFlowTheme.of(
                                                                          context)
                                                                      .neutral200,
                                                              borderWidth: 1.0,
                                                              borderRadius: 8.0,
                                                              margin:
                                                                  EdgeInsetsDirectional
                                                                      .fromSTEB(
                                                                          14.0,
                                                                          4.0,
                                                                          10.0,
                                                                          4.0),
                                                              hidesUnderline:
                                                                  true,
                                                              isSearchable:
                                                                  false,
                                                              isMultiSelect:
                                                                  false,
                                                            );
                                                          },
                                                        ),
                                                      ),
                                                    ),
                                                    Flexible(
                                                      flex: 1,
                                                      child: Padding(
                                                        padding:
                                                            EdgeInsetsDirectional
                                                                .fromSTEB(
                                                                    2.0,
                                                                    5.0,
                                                                    2.0,
                                                                    5.0),
                                                        child: FutureBuilder<
                                                            List<SemestersRow>>(
                                                          future:
                                                              SemestersTable()
                                                                  .queryRows(
                                                            queryFn: (q) => q,
                                                          ),
                                                          builder: (context,
                                                              snapshot) {
                                                            // Customize what your widget looks like when it's loading.
                                                            if (!snapshot
                                                                .hasData) {
                                                              return Center(
                                                                child: SizedBox(
                                                                  width: 50.0,
                                                                  height: 50.0,
                                                                  child:
                                                                      CircularProgressIndicator(
                                                                    valueColor:
                                                                        AlwaysStoppedAnimation<
                                                                            Color>(
                                                                      Color(
                                                                          0xFF284E75),
                                                                    ),
                                                                  ),
                                                                ),
                                                              );
                                                            }
                                                            List<SemestersRow>
                                                                dropDown2SemestersRowList =
                                                                snapshot.data!;

                                                            return FlutterFlowDropDown<
                                                                String>(
                                                              controller: _model
                                                                      .dropDown2ValueController ??=
                                                                  FormFieldController<
                                                                      String>(
                                                                _model.dropDown2Value ??=
                                                                    valueOrDefault<
                                                                        String>(
                                                                  dropDown2SemestersRowList
                                                                      .firstOrNull
                                                                      ?.semesterType,
                                                                  '1학기',
                                                                ),
                                                              ),
                                                              options: dropDown2SemestersRowList
                                                                  .map((e) => e
                                                                      .semesterType)
                                                                  .withoutNulls
                                                                  .toList(),
                                                              onChanged:
                                                                  (val) async {
                                                                safeSetState(() =>
                                                                    _model.dropDown2Value =
                                                                        val);
                                                                _model.semester =
                                                                    valueOrDefault<
                                                                        String>(
                                                                  _model
                                                                      .dropDown2Value,
                                                                  '1학기',
                                                                );
                                                                _model.buttonGrades =
                                                                    -1;
                                                                _model.semesterGradeOutput =
                                                                    [];
                                                                _model.yearsSemesterMapOutput =
                                                                    [];
                                                                _model.courseBySelectOutputVar =
                                                                    [];
                                                                _model.courseSectionOutputVar =
                                                                    [];
                                                                _model.classOnload = _model
                                                                    .classSelectedOnload!
                                                                    .where((e) =>
                                                                        (e.year ==
                                                                            _model
                                                                                .years) &&
                                                                        (e.semester ==
                                                                            _model
                                                                                .semester))
                                                                    .toList()
                                                                    .cast<
                                                                        ClassRow>();
                                                                _model.classAfterGrade =
                                                                    [];
                                                                _model.buttonColor1 =
                                                                    Color(
                                                                        4294967295);
                                                                _model.buttonColor2 =
                                                                    Color(
                                                                        4294967295);
                                                                _model.buttonColor3 =
                                                                    Color(
                                                                        4294967295);
                                                                _model.buttonColor4 =
                                                                    Color(
                                                                        4294967295);
                                                                _model.buttonColor5 =
                                                                    Color(
                                                                        4294967295);
                                                                _model.textColor1 =
                                                                    Color(
                                                                        4280831605);
                                                                _model.textColor2 =
                                                                    Color(
                                                                        4280831605);
                                                                _model.textColor3 =
                                                                    Color(
                                                                        4280831605);
                                                                _model.textColor4 =
                                                                    Color(
                                                                        4280831605);
                                                                _model.textColor5 =
                                                                    Color(
                                                                        4280831605);
                                                                safeSetState(
                                                                    () {});
                                                              },
                                                              width: 160.0,
                                                              height: 40.0,
                                                              textStyle:
                                                                  FlutterFlowTheme.of(
                                                                          context)
                                                                      .labelMedium
                                                                      .override(
                                                                        font: GoogleFonts
                                                                            .openSans(
                                                                          fontWeight: FlutterFlowTheme.of(context)
                                                                              .labelMedium
                                                                              .fontWeight,
                                                                          fontStyle: FlutterFlowTheme.of(context)
                                                                              .labelMedium
                                                                              .fontStyle,
                                                                        ),
                                                                        color: FlutterFlowTheme.of(context)
                                                                            .neutral500,
                                                                        fontSize:
                                                                            () {
                                                                          if (MediaQuery.sizeOf(context).width <
                                                                              kBreakpointSmall) {
                                                                            return 6.0;
                                                                          } else if (MediaQuery.sizeOf(context).width <
                                                                              kBreakpointMedium) {
                                                                            return 8.0;
                                                                          } else if (MediaQuery.sizeOf(context).width <
                                                                              kBreakpointLarge) {
                                                                            return 10.0;
                                                                          } else {
                                                                            return 12.0;
                                                                          }
                                                                        }(),
                                                                        letterSpacing:
                                                                            0.0,
                                                                        fontWeight: FlutterFlowTheme.of(context)
                                                                            .labelMedium
                                                                            .fontWeight,
                                                                        fontStyle: FlutterFlowTheme.of(context)
                                                                            .labelMedium
                                                                            .fontStyle,
                                                                      ),
                                                              hintText:
                                                                  FFLocalizations.of(
                                                                          context)
                                                                      .getText(
                                                                '8iueve7k' /* 학기 선택 */,
                                                              ),
                                                              icon: Icon(
                                                                Icons
                                                                    .keyboard_arrow_down_sharp,
                                                                color: FlutterFlowTheme.of(
                                                                        context)
                                                                    .primaryText,
                                                                size: 16.0,
                                                              ),
                                                              fillColor: FlutterFlowTheme
                                                                      .of(context)
                                                                  .primaryBackground,
                                                              elevation: 0.0,
                                                              borderColor:
                                                                  FlutterFlowTheme.of(
                                                                          context)
                                                                      .neutral200,
                                                              borderWidth: 1.0,
                                                              borderRadius: 8.0,
                                                              margin:
                                                                  EdgeInsetsDirectional
                                                                      .fromSTEB(
                                                                          14.0,
                                                                          4.0,
                                                                          10.0,
                                                                          4.0),
                                                              hidesUnderline:
                                                                  true,
                                                              isSearchable:
                                                                  false,
                                                              isMultiSelect:
                                                                  false,
                                                            );
                                                          },
                                                        ),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                              Padding(
                                                padding: EdgeInsetsDirectional
                                                    .fromSTEB(
                                                        5.0, 0.0, 0.0, 0.0),
                                                child: Material(
                                                  color: Colors.transparent,
                                                  elevation: 1.0,
                                                  shape: RoundedRectangleBorder(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            10.0),
                                                  ),
                                                  child: Container(
                                                    width: 120.0,
                                                    height: 40.0,
                                                    decoration: BoxDecoration(
                                                      color: FlutterFlowTheme
                                                              .of(context)
                                                          .primaryBackground,
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              10.0),
                                                    ),
                                                    child: Row(
                                                      mainAxisSize:
                                                          MainAxisSize.max,
                                                      children: [
                                                        Flexible(
                                                          child: Align(
                                                            alignment:
                                                                AlignmentDirectional(
                                                                    0.0, 0.0),
                                                            child: RichText(
                                                              textScaler:
                                                                  MediaQuery.of(
                                                                          context)
                                                                      .textScaler,
                                                              text: TextSpan(
                                                                children: [
                                                                  TextSpan(
                                                                    text: valueOrDefault<
                                                                        String>(
                                                                      _model
                                                                          .years,
                                                                      '0000',
                                                                    ),
                                                                    style: FlutterFlowTheme.of(
                                                                            context)
                                                                        .bodyMedium
                                                                        .override(
                                                                          font:
                                                                              GoogleFonts.openSans(
                                                                            fontWeight:
                                                                                FlutterFlowTheme.of(context).bodyMedium.fontWeight,
                                                                            fontStyle:
                                                                                FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                                                                          ),
                                                                          color:
                                                                              Color(0xFF284E75),
                                                                          fontSize:
                                                                              () {
                                                                            if (MediaQuery.sizeOf(context).width <
                                                                                kBreakpointSmall) {
                                                                              return 10.0;
                                                                            } else if (MediaQuery.sizeOf(context).width <
                                                                                kBreakpointMedium) {
                                                                              return 10.0;
                                                                            } else if (MediaQuery.sizeOf(context).width <
                                                                                kBreakpointLarge) {
                                                                              return 10.0;
                                                                            } else {
                                                                              return 12.0;
                                                                            }
                                                                          }(),
                                                                          letterSpacing:
                                                                              0.0,
                                                                          fontWeight: FlutterFlowTheme.of(context)
                                                                              .bodyMedium
                                                                              .fontWeight,
                                                                          fontStyle: FlutterFlowTheme.of(context)
                                                                              .bodyMedium
                                                                              .fontStyle,
                                                                        ),
                                                                  ),
                                                                  TextSpan(
                                                                    text: FFLocalizations.of(
                                                                            context)
                                                                        .getText(
                                                                      'jhixexuo' /* 년 */,
                                                                    ),
                                                                    style: FlutterFlowTheme.of(
                                                                            context)
                                                                        .bodyMedium
                                                                        .override(
                                                                          font:
                                                                              GoogleFonts.openSans(
                                                                            fontWeight:
                                                                                FlutterFlowTheme.of(context).bodyMedium.fontWeight,
                                                                            fontStyle:
                                                                                FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                                                                          ),
                                                                          color:
                                                                              Color(0xFF284E75),
                                                                          fontSize:
                                                                              () {
                                                                            if (MediaQuery.sizeOf(context).width <
                                                                                kBreakpointSmall) {
                                                                              return 10.0;
                                                                            } else if (MediaQuery.sizeOf(context).width <
                                                                                kBreakpointMedium) {
                                                                              return 10.0;
                                                                            } else if (MediaQuery.sizeOf(context).width <
                                                                                kBreakpointLarge) {
                                                                              return 10.0;
                                                                            } else {
                                                                              return 12.0;
                                                                            }
                                                                          }(),
                                                                          letterSpacing:
                                                                              0.0,
                                                                          fontWeight: FlutterFlowTheme.of(context)
                                                                              .bodyMedium
                                                                              .fontWeight,
                                                                          fontStyle: FlutterFlowTheme.of(context)
                                                                              .bodyMedium
                                                                              .fontStyle,
                                                                        ),
                                                                  ),
                                                                  TextSpan(
                                                                    text: FFLocalizations.of(
                                                                            context)
                                                                        .getText(
                                                                      'x124n44w' /*    */,
                                                                    ),
                                                                    style: FlutterFlowTheme.of(
                                                                            context)
                                                                        .bodyMedium
                                                                        .override(
                                                                          font:
                                                                              GoogleFonts.openSans(
                                                                            fontWeight:
                                                                                FlutterFlowTheme.of(context).bodyMedium.fontWeight,
                                                                            fontStyle:
                                                                                FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                                                                          ),
                                                                          color:
                                                                              Color(0xFF284E75),
                                                                          fontSize:
                                                                              () {
                                                                            if (MediaQuery.sizeOf(context).width <
                                                                                kBreakpointSmall) {
                                                                              return 10.0;
                                                                            } else if (MediaQuery.sizeOf(context).width <
                                                                                kBreakpointMedium) {
                                                                              return 10.0;
                                                                            } else if (MediaQuery.sizeOf(context).width <
                                                                                kBreakpointLarge) {
                                                                              return 10.0;
                                                                            } else {
                                                                              return 12.0;
                                                                            }
                                                                          }(),
                                                                          letterSpacing:
                                                                              0.0,
                                                                          fontWeight: FlutterFlowTheme.of(context)
                                                                              .bodyMedium
                                                                              .fontWeight,
                                                                          fontStyle: FlutterFlowTheme.of(context)
                                                                              .bodyMedium
                                                                              .fontStyle,
                                                                        ),
                                                                  ),
                                                                  TextSpan(
                                                                    text: valueOrDefault<
                                                                        String>(
                                                                      _model
                                                                          .semester,
                                                                      '-학기',
                                                                    ),
                                                                    style:
                                                                        TextStyle(
                                                                      color: Color(
                                                                          0xFF284E75),
                                                                      fontSize:
                                                                          () {
                                                                        if (MediaQuery.sizeOf(context).width <
                                                                            kBreakpointSmall) {
                                                                          return 10.0;
                                                                        } else if (MediaQuery.sizeOf(context).width <
                                                                            kBreakpointMedium) {
                                                                          return 10.0;
                                                                        } else if (MediaQuery.sizeOf(context).width <
                                                                            kBreakpointLarge) {
                                                                          return 10.0;
                                                                        } else {
                                                                          return 12.0;
                                                                        }
                                                                      }(),
                                                                    ),
                                                                  )
                                                                ],
                                                                style: FlutterFlowTheme.of(
                                                                        context)
                                                                    .bodyMedium
                                                                    .override(
                                                                      font: GoogleFonts
                                                                          .openSans(
                                                                        fontWeight: FlutterFlowTheme.of(context)
                                                                            .bodyMedium
                                                                            .fontWeight,
                                                                        fontStyle: FlutterFlowTheme.of(context)
                                                                            .bodyMedium
                                                                            .fontStyle,
                                                                      ),
                                                                      color: Color(
                                                                          0xFF284E75),
                                                                      fontSize:
                                                                          () {
                                                                        if (MediaQuery.sizeOf(context).width <
                                                                            kBreakpointSmall) {
                                                                          return 10.0;
                                                                        } else if (MediaQuery.sizeOf(context).width <
                                                                            kBreakpointMedium) {
                                                                          return 10.0;
                                                                        } else if (MediaQuery.sizeOf(context).width <
                                                                            kBreakpointLarge) {
                                                                          return 10.0;
                                                                        } else {
                                                                          return 12.0;
                                                                        }
                                                                      }(),
                                                                      letterSpacing:
                                                                          0.0,
                                                                      fontWeight: FlutterFlowTheme.of(
                                                                              context)
                                                                          .bodyMedium
                                                                          .fontWeight,
                                                                      fontStyle: FlutterFlowTheme.of(
                                                                              context)
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
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ),
                                  Flexible(
                                    flex: 4,
                                    child: Align(
                                      alignment: AlignmentDirectional(0.0, 0.0),
                                      child: ClipRRect(
                                        borderRadius:
                                            BorderRadius.circular(8.0),
                                        child: Image.asset(
                                          'assets/images/_2.png',
                                          height: double.infinity,
                                          fit: BoxFit.contain,
                                        ),
                                      ),
                                    ),
                                  ),
                                  Expanded(
                                    flex: 3,
                                    child: Align(
                                      alignment: AlignmentDirectional(1.0, 0.0),
                                      child: Container(
                                        width: 40.0,
                                        height: 40.0,
                                        decoration: BoxDecoration(),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Container(
                              width: double.infinity,
                              constraints: BoxConstraints(
                                maxHeight:
                                    MediaQuery.sizeOf(context).height * 0.95,
                              ),
                              decoration: BoxDecoration(
                                color: FlutterFlowTheme.of(context)
                                    .secondaryBackground,
                              ),
                              child: Padding(
                                padding: EdgeInsetsDirectional.fromSTEB(
                                    20.0, 10.0, 20.0, 0.0),
                                child: Column(
                                  mainAxisSize: MainAxisSize.max,
                                  children: [
                                    Padding(
                                      padding: EdgeInsetsDirectional.fromSTEB(
                                          0.0, 0.0, 0.0, 10.0),
                                      child: Row(
                                        mainAxisSize: MainAxisSize.max,
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(
                                            FFLocalizations.of(context).getText(
                                              '1mzdgllw' /* 관리자(Professor/조교) 계정 및 권한 관리 */,
                                            ),
                                            style: FlutterFlowTheme.of(context)
                                                .bodyMedium
                                                .override(
                                                  font: GoogleFonts.inter(
                                                    fontWeight: FontWeight.bold,
                                                    fontStyle:
                                                        FlutterFlowTheme.of(
                                                                context)
                                                            .bodyMedium
                                                            .fontStyle,
                                                  ),
                                                  color: Color(0xFF666666),
                                                  fontSize: 25.0,
                                                  letterSpacing: 0.0,
                                                  fontWeight: FontWeight.bold,
                                                  fontStyle:
                                                      FlutterFlowTheme.of(
                                                              context)
                                                          .bodyMedium
                                                          .fontStyle,
                                                ),
                                          ),
                                          Container(
                                            width: 512.0,
                                            height: 30.0,
                                            decoration: BoxDecoration(),
                                            child: Row(
                                              mainAxisSize: MainAxisSize.max,
                                              children: [
                                                Expanded(
                                                  flex: 1,
                                                  child: Container(
                                                    decoration: BoxDecoration(
                                                      border: Border.all(
                                                        color:
                                                            Color(0xFFE3E3E3),
                                                        width: 1.0,
                                                      ),
                                                    ),
                                                    child: FlutterFlowDropDown<
                                                        String>(
                                                      controller: _model
                                                              .dropDownValueController ??=
                                                          FormFieldController<
                                                              String>(_model
                                                                  .dropDownValue ??
                                                              '이 름'),
                                                      options: [
                                                        FFLocalizations.of(
                                                                context)
                                                            .getText(
                                                          'n15kxnyz' /* 이 름 */,
                                                        )
                                                      ],
                                                      onChanged: (val) {
                                                        safeSetState(() {
                                                          _model.dropDownValue =
                                                              val;
                                                          _model.currentSearchType =
                                                              val;
                                                        });
                                                      },
                                                      width: 200.0,
                                                      height: 40.0,
                                                      textStyle:
                                                          FlutterFlowTheme.of(
                                                                  context)
                                                              .bodyMedium
                                                              .override(
                                                                font: GoogleFonts
                                                                    .notoSansKr(
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w500,
                                                                  fontStyle: FlutterFlowTheme.of(
                                                                          context)
                                                                      .bodyMedium
                                                                      .fontStyle,
                                                                ),
                                                                color: Color(
                                                                    0xFF666666),
                                                                fontSize: 20.0,
                                                                letterSpacing:
                                                                    0.0,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w500,
                                                                fontStyle: FlutterFlowTheme.of(
                                                                        context)
                                                                    .bodyMedium
                                                                    .fontStyle,
                                                              ),
                                                      hintText:
                                                          FFLocalizations.of(
                                                                  context)
                                                              .getText(
                                                        'puoc0cj9' /* 이 름 */,
                                                      ),
                                                      icon: Icon(
                                                        Icons
                                                            .keyboard_arrow_down_rounded,
                                                        color:
                                                            FlutterFlowTheme.of(
                                                                    context)
                                                                .secondaryText,
                                                        size: 24.0,
                                                      ),
                                                      fillColor: Colors.white,
                                                      elevation: 2.0,
                                                      borderColor:
                                                          Colors.transparent,
                                                      borderWidth: 0.0,
                                                      borderRadius: 8.0,
                                                      margin:
                                                          EdgeInsetsDirectional
                                                              .fromSTEB(
                                                                  12.0,
                                                                  0.0,
                                                                  12.0,
                                                                  0.0),
                                                      hidesUnderline: true,
                                                      isOverButton: false,
                                                      isSearchable: false,
                                                      isMultiSelect: false,
                                                    ),
                                                  ),
                                                ),
                                                Expanded(
                                                  flex: 3,
                                                  child: Container(
                                                    width: 200.0,
                                                    child: TextFormField(
                                                      controller: _model
                                                          .textController1,
                                                      focusNode: _model
                                                          .textFieldFocusNode1,
                                                      autofocus: false,
                                                      obscureText: false,
                                                      decoration:
                                                          InputDecoration(
                                                        isDense: true,
                                                        contentPadding:
                                                            const EdgeInsets
                                                                .symmetric(
                                                          horizontal: 12.0,
                                                          vertical: 10.0,
                                                        ),
                                                        labelStyle:
                                                            FlutterFlowTheme.of(
                                                                    context)
                                                                .labelMedium
                                                                .override(
                                                                  font: GoogleFonts
                                                                      .openSans(
                                                                    fontWeight: FlutterFlowTheme.of(
                                                                            context)
                                                                        .labelMedium
                                                                        .fontWeight,
                                                                    fontStyle: FlutterFlowTheme.of(
                                                                            context)
                                                                        .labelMedium
                                                                        .fontStyle,
                                                                  ),
                                                                  letterSpacing:
                                                                      0.0,
                                                                  fontWeight: FlutterFlowTheme.of(
                                                                          context)
                                                                      .labelMedium
                                                                      .fontWeight,
                                                                  fontStyle: FlutterFlowTheme.of(
                                                                          context)
                                                                      .labelMedium
                                                                      .fontStyle,
                                                                ),
                                                        hintStyle:
                                                            FlutterFlowTheme.of(
                                                                    context)
                                                                .labelMedium
                                                                .override(
                                                                  font: GoogleFonts
                                                                      .openSans(
                                                                    fontWeight: FlutterFlowTheme.of(
                                                                            context)
                                                                        .labelMedium
                                                                        .fontWeight,
                                                                    fontStyle: FlutterFlowTheme.of(
                                                                            context)
                                                                        .labelMedium
                                                                        .fontStyle,
                                                                  ),
                                                                  letterSpacing:
                                                                      0.0,
                                                                  fontWeight: FlutterFlowTheme.of(
                                                                          context)
                                                                      .labelMedium
                                                                      .fontWeight,
                                                                  fontStyle: FlutterFlowTheme.of(
                                                                          context)
                                                                      .labelMedium
                                                                      .fontStyle,
                                                                ),
                                                        enabledBorder:
                                                            OutlineInputBorder(
                                                          borderSide:
                                                              BorderSide(
                                                            color: Color(
                                                                0xFFE3E3E3),
                                                            width: 1.0,
                                                          ),
                                                          borderRadius:
                                                              const BorderRadius
                                                                  .only(
                                                            topLeft:
                                                                Radius.circular(
                                                                    4.0),
                                                            topRight:
                                                                Radius.circular(
                                                                    4.0),
                                                          ),
                                                        ),
                                                        focusedBorder:
                                                            OutlineInputBorder(
                                                          borderSide:
                                                              BorderSide(
                                                            color: Color(
                                                                0x00000000),
                                                            width: 1.0,
                                                          ),
                                                          borderRadius:
                                                              const BorderRadius
                                                                  .only(
                                                            topLeft:
                                                                Radius.circular(
                                                                    4.0),
                                                            topRight:
                                                                Radius.circular(
                                                                    4.0),
                                                          ),
                                                        ),
                                                        errorBorder:
                                                            OutlineInputBorder(
                                                          borderSide:
                                                              BorderSide(
                                                            color: FlutterFlowTheme
                                                                    .of(context)
                                                                .error,
                                                            width: 1.0,
                                                          ),
                                                          borderRadius:
                                                              const BorderRadius
                                                                  .only(
                                                            topLeft:
                                                                Radius.circular(
                                                                    4.0),
                                                            topRight:
                                                                Radius.circular(
                                                                    4.0),
                                                          ),
                                                        ),
                                                        focusedErrorBorder:
                                                            OutlineInputBorder(
                                                          borderSide:
                                                              BorderSide(
                                                            color: FlutterFlowTheme
                                                                    .of(context)
                                                                .error,
                                                            width: 1.0,
                                                          ),
                                                          borderRadius:
                                                              const BorderRadius
                                                                  .only(
                                                            topLeft:
                                                                Radius.circular(
                                                                    4.0),
                                                            topRight:
                                                                Radius.circular(
                                                                    4.0),
                                                          ),
                                                        ),
                                                        filled: true,
                                                        fillColor: Colors.white,
                                                      ),
                                                      style:
                                                          FlutterFlowTheme.of(
                                                                  context)
                                                              .bodyMedium
                                                              .override(
                                                                font: GoogleFonts
                                                                    .notoSansKr(
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .normal,
                                                                  fontStyle: FlutterFlowTheme.of(
                                                                          context)
                                                                      .bodyMedium
                                                                      .fontStyle,
                                                                ),
                                                                color: Color(
                                                                    0xFF666666),
                                                                fontSize: 20.0,
                                                                letterSpacing:
                                                                    0.0,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .normal,
                                                                fontStyle: FlutterFlowTheme.of(
                                                                        context)
                                                                    .bodyMedium
                                                                    .fontStyle,
                                                              ),
                                                      textAlign:
                                                          TextAlign.start,
                                                      cursorColor:
                                                          FlutterFlowTheme.of(
                                                                  context)
                                                              .primaryText,
                                                      validator: _model
                                                          .textController1Validator
                                                          .asValidator(context),
                                                    ),
                                                  ),
                                                ),
                                                Expanded(
                                                  flex: 1,
                                                  child: FFButtonWidget(
                                                    onPressed: () async {
                                                      try {
                                                        final searchText =
                                                            _model.textController1
                                                                .text
                                                                .trim();

                                                        final results =
                                                            await searchPosts(
                                                          _model.dropDownValue ??
                                                              '이 름',
                                                          searchText,
                                                        );

                                                        _model.isSearching =
                                                            searchText
                                                                .isNotEmpty;
                                                        _model
                                                            .currentSearchKeyword =
                                                            searchText;
                                                        _model.currentSearchType =
                                                            _model.dropDownValue ??
                                                                '이 름';
                                                        _model.prfoutput =
                                                            results;
                                                        _model.profeesorName =
                                                            results
                                                                    .firstOrNull
                                                                    ?.name ??
                                                                '교수 이름';
                                                        _updatePagination(
                                                            resetPage: true);
                                                        safeSetState(() {});
                                                      } catch (e) {
                                                        ScaffoldMessenger.of(
                                                                context)
                                                            .showSnackBar(
                                                          SnackBar(
                                                              content: Text(
                                                                  '검색 실패: $e')),
                                                        );
                                                      }
                                                    },
                                                    text: '관리자 계정 검색',
                                                    options: FFButtonOptions(
                                                      height: 40.0,
                                                      padding:
                                                          EdgeInsetsDirectional
                                                              .fromSTEB(
                                                                  16.0,
                                                                  0.0,
                                                                  16.0,
                                                                  0.0),
                                                      iconPadding:
                                                          EdgeInsetsDirectional
                                                              .fromSTEB(
                                                                  0.0,
                                                                  0.0,
                                                                  0.0,
                                                                  0.0),
                                                      color: Colors.white,
                                                      textStyle:
                                                          FlutterFlowTheme.of(
                                                                  context)
                                                              .titleSmall
                                                              .override(
                                                                font: GoogleFonts
                                                                    .notoSansKr(
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w500,
                                                                  fontStyle: FlutterFlowTheme.of(
                                                                          context)
                                                                      .titleSmall
                                                                      .fontStyle,
                                                                ),
                                                                color: Color(
                                                                    0xFF666666),
                                                                fontSize: 20.0,
                                                                letterSpacing:
                                                                    0.0,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w500,
                                                                fontStyle: FlutterFlowTheme.of(
                                                                        context)
                                                                    .titleSmall
                                                                    .fontStyle,
                                                              ),
                                                      elevation: 0.0,
                                                      borderSide: BorderSide(
                                                        color:
                                                            Color(0xFFE3E3E3),
                                                      ),
                                                      borderRadius:
                                                          BorderRadius.only(
                                                        bottomLeft:
                                                            Radius.circular(
                                                                0.0),
                                                        bottomRight:
                                                            Radius.circular(
                                                                5.0),
                                                        topLeft:
                                                            Radius.circular(
                                                                0.0),
                                                        topRight:
                                                            Radius.circular(
                                                                5.0),
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
                                    wrapWithModel(
                                      model: _model.borderlineModel1,
                                      updateCallback: () => safeSetState(() {}),
                                      child: BorderlineWidget(),
                                    ),
                                    Flexible(
                                      child: Padding(
                                        padding: EdgeInsetsDirectional.fromSTEB(
                                            2.0, 0.0, 0.0, 0.0),
                                        child: Container(
                                          height: 30.0,
                                          decoration: BoxDecoration(
                                            color: Color(0xFFD9D9D9),
                                          ),
                                          child: Padding(
                                            padding:
                                                EdgeInsetsDirectional.fromSTEB(
                                                    20.0, 0.0, 20.0, 0.0),
                                            child: Row(
                                              mainAxisSize: MainAxisSize.max,
                                              mainAxisAlignment:
                                                  MainAxisAlignment.spaceAround,
                                              children: [
                                                Expanded(
                                                  flex: 1,
                                                  child: Container(
                                                    decoration: BoxDecoration(),
                                                    alignment:
                                                        AlignmentDirectional(
                                                            0.0, 0.0),
                                                    child: Text(
                                                      FFLocalizations.of(
                                                              context)
                                                          .getText(
                                                        'oig5fahf' /* 이름 */,
                                                      ),
                                                      style: FlutterFlowTheme
                                                              .of(context)
                                                          .bodyMedium
                                                          .override(
                                                            font: GoogleFonts
                                                                .inter(
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w500,
                                                              fontStyle:
                                                                  FlutterFlowTheme.of(
                                                                          context)
                                                                      .bodyMedium
                                                                      .fontStyle,
                                                            ),
                                                            color: Color(
                                                                0xFF4E4E4E),
                                                            fontSize: 20.0,
                                                            letterSpacing: 0.0,
                                                            fontWeight:
                                                                FontWeight.w500,
                                                            fontStyle:
                                                                FlutterFlowTheme.of(
                                                                        context)
                                                                    .bodyMedium
                                                                    .fontStyle,
                                                          ),
                                                    ),
                                                  ),
                                                ),
                                                Expanded(
                                                  flex: 1,
                                                  child: Container(
                                                    decoration: BoxDecoration(),
                                                    alignment:
                                                        AlignmentDirectional(
                                                            0.0, 0.0),
                                                    child: Text(
                                                      FFLocalizations.of(
                                                              context)
                                                          .getText(
                                                        'eyyrloj9' /* 교수/직급 */,
                                                      ),
                                                      style: FlutterFlowTheme
                                                              .of(context)
                                                          .bodyMedium
                                                          .override(
                                                            font: GoogleFonts
                                                                .inter(
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w500,
                                                              fontStyle:
                                                                  FlutterFlowTheme.of(
                                                                          context)
                                                                      .bodyMedium
                                                                      .fontStyle,
                                                            ),
                                                            color: Color(
                                                                0xFF4E4E4E),
                                                            fontSize: 20.0,
                                                            letterSpacing: 0.0,
                                                            fontWeight:
                                                                FontWeight.w500,
                                                            fontStyle:
                                                                FlutterFlowTheme.of(
                                                                        context)
                                                                    .bodyMedium
                                                                    .fontStyle,
                                                          ),
                                                    ),
                                                  ),
                                                ),
                                                Expanded(
                                                  flex: 3,
                                                  child: Container(
                                                    decoration: BoxDecoration(),
                                                    alignment:
                                                        AlignmentDirectional(
                                                            0.0, 0.0),
                                                    child: Text(
                                                      FFLocalizations.of(
                                                              context)
                                                          .getText(
                                                        't12i7su7' /* 이메일 */,
                                                      ),
                                                      style: FlutterFlowTheme
                                                              .of(context)
                                                          .bodyMedium
                                                          .override(
                                                            font: GoogleFonts
                                                                .inter(
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w500,
                                                              fontStyle:
                                                                  FlutterFlowTheme.of(
                                                                          context)
                                                                      .bodyMedium
                                                                      .fontStyle,
                                                            ),
                                                            color: Color(
                                                                0xFF4E4E4E),
                                                            fontSize: 20.0,
                                                            letterSpacing: 0.0,
                                                            fontWeight:
                                                                FontWeight.w500,
                                                            fontStyle:
                                                                FlutterFlowTheme.of(
                                                                        context)
                                                                    .bodyMedium
                                                                    .fontStyle,
                                                          ),
                                                    ),
                                                  ),
                                                ),
                                                Expanded(
                                                  flex: 2,
                                                  child: Container(
                                                    decoration: BoxDecoration(),
                                                    alignment:
                                                        AlignmentDirectional(
                                                            0.0, 0.0),
                                                    child: Text(
                                                      FFLocalizations.of(
                                                              context)
                                                          .getText(
                                                        'xxu3zqom' /* 연락처 */,
                                                      ),
                                                      style: FlutterFlowTheme
                                                              .of(context)
                                                          .bodyMedium
                                                          .override(
                                                            font: GoogleFonts
                                                                .inter(
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w500,
                                                              fontStyle:
                                                                  FlutterFlowTheme.of(
                                                                          context)
                                                                      .bodyMedium
                                                                      .fontStyle,
                                                            ),
                                                            color: Color(
                                                                0xFF4E4E4E),
                                                            fontSize: 20.0,
                                                            letterSpacing: 0.0,
                                                            fontWeight:
                                                                FontWeight.w500,
                                                            fontStyle:
                                                                FlutterFlowTheme.of(
                                                                        context)
                                                                    .bodyMedium
                                                                    .fontStyle,
                                                          ),
                                                    ),
                                                  ),
                                                ),
                                                Expanded(
                                                  flex: 1,
                                                  child: Container(
                                                    decoration: BoxDecoration(),
                                                    alignment:
                                                        AlignmentDirectional(
                                                            0.0, 0.0),
                                                    child: Text(
                                                      FFLocalizations.of(
                                                              context)
                                                          .getText(
                                                        'or2ecoli' /* 권한 설정 */,
                                                      ),
                                                      style: FlutterFlowTheme
                                                              .of(context)
                                                          .bodyMedium
                                                          .override(
                                                            font: GoogleFonts
                                                                .inter(
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w500,
                                                              fontStyle:
                                                                  FlutterFlowTheme.of(
                                                                          context)
                                                                      .bodyMedium
                                                                      .fontStyle,
                                                            ),
                                                            color: Color(
                                                                0xFF4E4E4E),
                                                            fontSize: 20.0,
                                                            letterSpacing: 0.0,
                                                            fontWeight:
                                                                FontWeight.w500,
                                                            fontStyle:
                                                                FlutterFlowTheme.of(
                                                                        context)
                                                                    .bodyMedium
                                                                    .fontStyle,
                                                          ),
                                                    ),
                                                  ),
                                                ),
                                                Expanded(
                                                  flex: 1,
                                                  child: Container(
                                                    decoration: BoxDecoration(),
                                                    alignment:
                                                        AlignmentDirectional(
                                                            0.0, 0.0),
                                                    child: Text(
                                                      FFLocalizations.of(
                                                              context)
                                                          .getText(
                                                        'ndcle0l5' /* 수정 */,
                                                      ),
                                                      style: FlutterFlowTheme
                                                              .of(context)
                                                          .bodyMedium
                                                          .override(
                                                            font: GoogleFonts
                                                                .inter(
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w500,
                                                              fontStyle:
                                                                  FlutterFlowTheme.of(
                                                                          context)
                                                                      .bodyMedium
                                                                      .fontStyle,
                                                            ),
                                                            color: Color(
                                                                0xFF4E4E4E),
                                                            fontSize: 20.0,
                                                            letterSpacing: 0.0,
                                                            fontWeight:
                                                                FontWeight.w500,
                                                            fontStyle:
                                                                FlutterFlowTheme.of(
                                                                        context)
                                                                    .bodyMedium
                                                                    .fontStyle,
                                                          ),
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                    Padding(
                                      padding: EdgeInsetsDirectional.fromSTEB(
                                          0.0, 0.0, 0.0, 10.0),
                                      child: wrapWithModel(
                                        model: _model.borderlineModel2,
                                        updateCallback: () =>
                                            safeSetState(() {}),
                                        child: BorderlineWidget(),
                                      ),
                                    ),
                                    Container(
                                      constraints: BoxConstraints(
                                        minHeight:
                                            MediaQuery.sizeOf(context).height *
                                                0.6,
                                        maxHeight:
                                            MediaQuery.sizeOf(context).height *
                                                0.7,
                                      ),
                                      decoration: BoxDecoration(),
                                      child: SingleChildScrollView(
                                        child: Column(
                                          mainAxisSize: MainAxisSize.max,
                                          children: [
                                            if ((_model.paginatedPosts).isEmpty)
                                              Padding(
                                                padding: EdgeInsetsDirectional
                                                    .fromSTEB(
                                                        20.0, 20.0, 20.0, 20.0),
                                                child: Text(
                                                  '표시할 데이터가 없습니다.',
                                                  style: FlutterFlowTheme.of(
                                                          context)
                                                      .bodyMedium,
                                                ),
                                              ),
                                            ..._model.paginatedPosts
                                                .map(
                                                  (post) => Padding(
                                                    padding:
                                                        EdgeInsetsDirectional
                                                            .fromSTEB(
                                                                0.0,
                                                                0.0,
                                                                0.0,
                                                                10.0),
                                                    child:
                                                        AccountManageRowWidget(
                                                      key: ValueKey(
                                                          'account_row_${post.id}'),
                                                      post: post,
                                                      confirmEdit:
                                                          (confirm, data) async {
                                                        if (confirm) {
                                                          await _handlePostEdit(
                                                            post,
                                                            data,
                                                          );
                                                        }
                                                      },
                                                      onSelected: () {
                                                        _model.selectedProfessorId =
                                                            post.id;
                                                        _applyClassFilters();
                                                        safeSetState(() {});
                                                      },
                                                    ),
                                                  ),
                                                )
                                                .toList(),
                                          ],
                                        ),
                                      ),
                                    ),
                                    wrapWithModel(
                                      model: _model.borderlineModel3,
                                      updateCallback: () => safeSetState(() {}),
                                      child: BorderlineWidget(),
                                    ),
                                    Flexible(
                                      child: Container(
                                        height: 30.0,
                                        decoration: BoxDecoration(
                                          color: Color(0xFFD9D9D9),
                                        ),
                                        child: Padding(
                                          padding:
                                              EdgeInsetsDirectional.fromSTEB(
                                                  0.0, 0.0, 20.0, 0.0),
                                          child: Row(
                                            mainAxisSize: MainAxisSize.max,
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Row(
                                                mainAxisSize: MainAxisSize.min,
                                                children: [
                                                  IconButton(
                                                    icon: Icon(
                                                      Icons.chevron_left,
                                                      color: _model.currentPage >
                                                              1
                                                          ? Color(0xFF666666)
                                                          : Color(0xFFCCCCCC),
                                                    ),
                                                    onPressed: _model
                                                                .currentPage >
                                                            1
                                                        ? () =>
                                                            _handlePageChange(
                                                                false)
                                                        : null,
                                                  ),
                                                  Text(
                                                    '${_model.currentPage} / ${_totalPages}',
                                                    style: FlutterFlowTheme.of(
                                                            context)
                                                        .bodyMedium
                                                        .override(
                                                          font: GoogleFonts
                                                              .openSans(
                                                            fontWeight:
                                                                FlutterFlowTheme.of(
                                                                        context)
                                                                    .bodyMedium
                                                                    .fontWeight,
                                                            fontStyle:
                                                                FlutterFlowTheme.of(
                                                                        context)
                                                                    .bodyMedium
                                                                    .fontStyle,
                                                          ),
                                                          color:
                                                              Color(0xFF666666),
                                                          letterSpacing: 0.0,
                                                          fontWeight:
                                                              FlutterFlowTheme.of(
                                                                      context)
                                                                  .bodyMedium
                                                                  .fontWeight,
                                                          fontStyle:
                                                              FlutterFlowTheme.of(
                                                                      context)
                                                                  .bodyMedium
                                                                  .fontStyle,
                                                        ),
                                                  ),
                                                  IconButton(
                                                    icon: Icon(
                                                      Icons.chevron_right,
                                                      color: _model.currentPage <
                                                              _totalPages
                                                          ? Color(0xFF666666)
                                                          : Color(0xFFCCCCCC),
                                                    ),
                                                    onPressed: _model
                                                                .currentPage <
                                                            _totalPages
                                                        ? () =>
                                                            _handlePageChange(
                                                                true)
                                                        : null,
                                                  ),
                                                ],
                                              ),
                                              RichText(
                                                textScaler:
                                                    MediaQuery.of(context)
                                                        .textScaler,
                                                text: TextSpan(
                                                  children: [
                                                    TextSpan(
                                                      text: FFLocalizations.of(
                                                              context)
                                                          .getText(
                                                        'b96kkdm8' /* 총: */,
                                                      ),
                                                      style:
                                                          FlutterFlowTheme.of(
                                                                  context)
                                                              .bodyMedium
                                                              .override(
                                                                font: GoogleFonts
                                                                    .openSans(
                                                                  fontWeight: FlutterFlowTheme.of(
                                                                          context)
                                                                      .bodyMedium
                                                                      .fontWeight,
                                                                  fontStyle: FlutterFlowTheme.of(
                                                                          context)
                                                                      .bodyMedium
                                                                      .fontStyle,
                                                                ),
                                                                letterSpacing:
                                                                    0.0,
                                                                fontWeight: FlutterFlowTheme.of(
                                                                        context)
                                                                    .bodyMedium
                                                                    .fontWeight,
                                                                fontStyle: FlutterFlowTheme.of(
                                                                        context)
                                                                    .bodyMedium
                                                                    .fontStyle,
                                                              ),
                                                    ),
                                                    TextSpan(
                                                      text:
                                                          ' ${_model.prfoutput?.length ?? 0} ',
                                                      style:
                                                          FlutterFlowTheme.of(
                                                                  context)
                                                              .bodyMedium
                                                              .override(
                                                                fontFamily:
                                                                    'Open Sans',
                                                                letterSpacing:
                                                                    0.0,
                                                                decoration:
                                                                    TextDecoration
                                                                        .underline,
                                                              ),
                                                    ),
                                                    TextSpan(
                                                      text: FFLocalizations.of(
                                                              context)
                                                          .getText(
                                                        '6u9eyyuo' /* 명 */,
                                                      ),
                                                      style:
                                                          FlutterFlowTheme.of(
                                                                  context)
                                                              .bodyMedium
                                                              .override(
                                                                font: GoogleFonts
                                                                    .openSans(
                                                                  fontWeight: FlutterFlowTheme.of(
                                                                          context)
                                                                      .bodyMedium
                                                                      .fontWeight,
                                                                  fontStyle: FlutterFlowTheme.of(
                                                                          context)
                                                                      .bodyMedium
                                                                      .fontStyle,
                                                                ),
                                                                letterSpacing:
                                                                    0.0,
                                                                fontWeight: FlutterFlowTheme.of(
                                                                        context)
                                                                    .bodyMedium
                                                                    .fontWeight,
                                                                fontStyle: FlutterFlowTheme.of(
                                                                        context)
                                                                    .bodyMedium
                                                                    .fontStyle,
                                                              ),
                                                    )
                                                  ],
                                                  style: FlutterFlowTheme.of(
                                                          context)
                                                      .bodyMedium
                                                      .override(
                                                        font: GoogleFonts
                                                            .openSans(
                                                          fontWeight:
                                                              FlutterFlowTheme.of(
                                                                      context)
                                                                  .bodyMedium
                                                                  .fontWeight,
                                                          fontStyle:
                                                              FlutterFlowTheme.of(
                                                                      context)
                                                                  .bodyMedium
                                                                  .fontStyle,
                                                        ),
                                                        color:
                                                            Color(0xFF666666),
                                                        letterSpacing: 0.0,
                                                        fontWeight:
                                                            FlutterFlowTheme.of(
                                                                    context)
                                                                .bodyMedium
                                                                .fontWeight,
                                                        fontStyle:
                                                            FlutterFlowTheme.of(
                                                                    context)
                                                                .bodyMedium
                                                                .fontStyle,
                                                      ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ),
                                    wrapWithModel(
                                      model: _model.borderlineModel4,
                                      updateCallback: () => safeSetState(() {}),
                                      child: BorderlineWidget(),
                                    ),
                                  ],
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
            if (_model.isLoading)
              Positioned.fill(
                child: Container(
                  color: Colors.black26,
                  child: Center(
                    child: CircularProgressIndicator(
                      valueColor: AlwaysStoppedAnimation<Color>(
                        Color(0xFF284E75),
                      ),
                    ),
                  ),
                ),
              ),
            if (responsiveVisibility(
              context: context,
              tabletLandscape: false,
              desktop: false,
            ))
              Container(
                width: MediaQuery.sizeOf(context).width * 1.0,
                height: MediaQuery.sizeOf(context).height * 1.0,
                decoration: BoxDecoration(
                  color: FlutterFlowTheme.of(context).secondaryBackground,
                ),
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      wrapWithModel(
                        model: _model.headerMobileModel,
                        updateCallback: () => safeSetState(() {}),
                        child: HeaderMobileWidget(),
                      ),
                      Container(
                        width: double.infinity,
                        height: 50.0,
                        decoration: BoxDecoration(
                          color: Color(0xFFEEF1F6),
                        ),
                        child: Padding(
                          padding: EdgeInsetsDirectional.fromSTEB(
                              20.0, 0.0, 20.0, 0.0),
                          child: Row(
                            mainAxisSize: MainAxisSize.max,
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Flexible(
                                flex: 1,
                                child: Padding(
                                  padding: EdgeInsetsDirectional.fromSTEB(
                                      2.0, 5.0, 2.0, 5.0),
                                  child: FutureBuilder<List<YearsRow>>(
                                    future: YearsTable().queryRows(
                                      queryFn: (q) => q,
                                    ),
                                    builder: (context, snapshot) {
                                      // Customize what your widget looks like when it's loading.
                                      if (!snapshot.hasData) {
                                        return Center(
                                          child: SizedBox(
                                            width: 50.0,
                                            height: 50.0,
                                            child: CircularProgressIndicator(
                                              valueColor:
                                                  AlwaysStoppedAnimation<Color>(
                                                Color(0xFF284E75),
                                              ),
                                            ),
                                          ),
                                        );
                                      }
                                      List<YearsRow> dropDownYearYearsRowList =
                                          snapshot.data!;

                                      return FlutterFlowDropDown<String>(
                                        controller: _model
                                                .dropDownYearValueController ??=
                                            FormFieldController<String>(
                                          _model.dropDownYearValue ??=
                                              valueOrDefault<String>(
                                            dropDownYearYearsRowList
                                                .lastOrNull?.year,
                                            '2025',
                                          ),
                                        ),
                                        options: dropDownYearYearsRowList
                                            .map((e) => e.year)
                                            .withoutNulls
                                            .toList(),
                                        onChanged: (val) async {
                                          safeSetState(() =>
                                              _model.dropDownYearValue = val);
                                          _model.years = valueOrDefault<String>(
                                            _model.dropDownYearValue,
                                            '2025',
                                          );
                                          safeSetState(() {});
                                          _model.semester = '1학기';
                                          _model.buttonGrades = -1;
                                          _model.semesterGradeOutput = [];
                                          _model.yearsSemesterMapOutput = [];
                                          _model.courseBySelectOutputVar = [];
                                          _model.courseSectionOutputVar = [];
                                          _model.classAfterGrade = [];
                                          _model.buttonColor1 =
                                              Color(4294967295);
                                          _model.buttonColor2 =
                                              Color(4294967295);
                                          _model.buttonColor3 =
                                              Color(4294967295);
                                          _model.buttonColor4 =
                                              Color(4294967295);
                                          _model.buttonColor5 =
                                              Color(4294967295);
                                          _model.textColor1 = Color(4280831605);
                                          _model.textColor2 = Color(4280831605);
                                          _model.textColor3 = Color(4280831605);
                                          _model.textColor4 = Color(4280831605);
                                          _model.textColor5 = Color(4280831605);
                                          safeSetState(() {});
                                        },
                                        width: double.infinity,
                                        height: 30.0,
                                        textStyle: FlutterFlowTheme.of(context)
                                            .labelMedium
                                            .override(
                                              font: GoogleFonts.openSans(
                                                fontWeight:
                                                    FlutterFlowTheme.of(context)
                                                        .labelMedium
                                                        .fontWeight,
                                                fontStyle:
                                                    FlutterFlowTheme.of(context)
                                                        .labelMedium
                                                        .fontStyle,
                                              ),
                                              color:
                                                  FlutterFlowTheme.of(context)
                                                      .neutral500,
                                              fontSize: () {
                                                if (MediaQuery.sizeOf(context)
                                                        .width <
                                                    kBreakpointSmall) {
                                                  return 9.0;
                                                } else if (MediaQuery.sizeOf(
                                                            context)
                                                        .width <
                                                    kBreakpointMedium) {
                                                  return 11.0;
                                                } else if (MediaQuery.sizeOf(
                                                            context)
                                                        .width <
                                                    kBreakpointLarge) {
                                                  return 13.0;
                                                } else {
                                                  return 15.0;
                                                }
                                              }(),
                                              letterSpacing: 0.0,
                                              fontWeight:
                                                  FlutterFlowTheme.of(context)
                                                      .labelMedium
                                                      .fontWeight,
                                              fontStyle:
                                                  FlutterFlowTheme.of(context)
                                                      .labelMedium
                                                      .fontStyle,
                                            ),
                                        hintText:
                                            FFLocalizations.of(context).getText(
                                          'c81w60fa' /* 년도 선택 */,
                                        ),
                                        icon: Icon(
                                          Icons.keyboard_arrow_down_sharp,
                                          color: FlutterFlowTheme.of(context)
                                              .primaryText,
                                          size: 16.0,
                                        ),
                                        fillColor: FlutterFlowTheme.of(context)
                                            .primaryBackground,
                                        elevation: 0.0,
                                        borderColor:
                                            FlutterFlowTheme.of(context)
                                                .neutral200,
                                        borderWidth: 1.0,
                                        borderRadius: 8.0,
                                        margin: EdgeInsetsDirectional.fromSTEB(
                                            14.0, 4.0, 10.0, 4.0),
                                        hidesUnderline: true,
                                        isSearchable: false,
                                        isMultiSelect: false,
                                      );
                                    },
                                  ),
                                ),
                              ),
                              Flexible(
                                flex: 1,
                                child: Padding(
                                  padding: EdgeInsetsDirectional.fromSTEB(
                                      2.0, 5.0, 2.0, 5.0),
                                  child: FutureBuilder<List<SemestersRow>>(
                                    future: SemestersTable().queryRows(
                                      queryFn: (q) => q,
                                    ),
                                    builder: (context, snapshot) {
                                      // Customize what your widget looks like when it's loading.
                                      if (!snapshot.hasData) {
                                        return Center(
                                          child: SizedBox(
                                            width: 50.0,
                                            height: 50.0,
                                            child: CircularProgressIndicator(
                                              valueColor:
                                                  AlwaysStoppedAnimation<Color>(
                                                Color(0xFF284E75),
                                              ),
                                            ),
                                          ),
                                        );
                                      }
                                      List<SemestersRow>
                                          dropDownSemesterSemestersRowList =
                                          snapshot.data!;

                                      return FlutterFlowDropDown<String>(
                                        controller: _model
                                                .dropDownSemesterValueController ??=
                                            FormFieldController<String>(
                                          _model.dropDownSemesterValue ??=
                                              valueOrDefault<String>(
                                            dropDownSemesterSemestersRowList
                                                .firstOrNull?.semesterType,
                                            '1학기',
                                          ),
                                        ),
                                        options:
                                            dropDownSemesterSemestersRowList
                                                .map((e) => e.semesterType)
                                                .withoutNulls
                                                .toList(),
                                        onChanged: (val) async {
                                          safeSetState(() => _model
                                              .dropDownSemesterValue = val);
                                          _model.semester =
                                              valueOrDefault<String>(
                                            _model.dropDownSemesterValue,
                                            '1학기',
                                          );
                                          _model.buttonGrades = -1;
                                          _model.semesterGradeOutput = [];
                                          _model.yearsSemesterMapOutput = [];
                                          _model.courseBySelectOutputVar = [];
                                          _model.courseSectionOutputVar = [];
                                          _model.classAfterGrade = [];
                                          _model.buttonColor1 =
                                              Color(4294967295);
                                          _model.buttonColor2 =
                                              Color(4294967295);
                                          _model.buttonColor3 =
                                              Color(4294967295);
                                          _model.buttonColor4 =
                                              Color(4294967295);
                                          _model.buttonColor5 =
                                              Color(4294967295);
                                          _model.textColor1 = Color(4280831605);
                                          _model.textColor2 = Color(4280831605);
                                          _model.textColor3 = Color(4280831605);
                                          _model.textColor4 = Color(4280831605);
                                          _model.textColor5 = Color(4280831605);
                                          safeSetState(() {});
                                        },
                                        width: double.infinity,
                                        height: 30.0,
                                        textStyle: FlutterFlowTheme.of(context)
                                            .labelMedium
                                            .override(
                                              font: GoogleFonts.openSans(
                                                fontWeight:
                                                    FlutterFlowTheme.of(context)
                                                        .labelMedium
                                                        .fontWeight,
                                                fontStyle:
                                                    FlutterFlowTheme.of(context)
                                                        .labelMedium
                                                        .fontStyle,
                                              ),
                                              color:
                                                  FlutterFlowTheme.of(context)
                                                      .neutral500,
                                              fontSize: () {
                                                if (MediaQuery.sizeOf(context)
                                                        .width <
                                                    kBreakpointSmall) {
                                                  return 9.0;
                                                } else if (MediaQuery.sizeOf(
                                                            context)
                                                        .width <
                                                    kBreakpointMedium) {
                                                  return 11.0;
                                                } else if (MediaQuery.sizeOf(
                                                            context)
                                                        .width <
                                                    kBreakpointLarge) {
                                                  return 13.0;
                                                } else {
                                                  return 15.0;
                                                }
                                              }(),
                                              letterSpacing: 0.0,
                                              fontWeight:
                                                  FlutterFlowTheme.of(context)
                                                      .labelMedium
                                                      .fontWeight,
                                              fontStyle:
                                                  FlutterFlowTheme.of(context)
                                                      .labelMedium
                                                      .fontStyle,
                                            ),
                                        hintText:
                                            FFLocalizations.of(context).getText(
                                          '356jdk8e' /* 학기 선택 */,
                                        ),
                                        icon: Icon(
                                          Icons.keyboard_arrow_down_sharp,
                                          color: FlutterFlowTheme.of(context)
                                              .primaryText,
                                          size: 16.0,
                                        ),
                                        fillColor: FlutterFlowTheme.of(context)
                                            .primaryBackground,
                                        elevation: 0.0,
                                        borderColor:
                                            FlutterFlowTheme.of(context)
                                                .neutral200,
                                        borderWidth: 1.0,
                                        borderRadius: 8.0,
                                        margin: EdgeInsetsDirectional.fromSTEB(
                                            14.0, 4.0, 10.0, 4.0),
                                        hidesUnderline: true,
                                        isSearchable: false,
                                        isMultiSelect: false,
                                      );
                                    },
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsetsDirectional.fromSTEB(
                            20.0, 5.0, 20.0, 5.0),
                        child: Row(
                          mainAxisSize: MainAxisSize.max,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              FFLocalizations.of(context).getText(
                                'mfqe38e8' /* 관리자 계정 및 권한 관리 */,
                              ),
                              style: FlutterFlowTheme.of(context)
                                  .bodyMedium
                                  .override(
                                    font: GoogleFonts.inter(
                                      fontWeight: FontWeight.bold,
                                      fontStyle: FlutterFlowTheme.of(context)
                                          .bodyMedium
                                          .fontStyle,
                                    ),
                                    color: Color(0xFF666666),
                                    fontSize: 20.0,
                                    letterSpacing: 0.0,
                                    fontWeight: FontWeight.bold,
                                    fontStyle: FlutterFlowTheme.of(context)
                                        .bodyMedium
                                        .fontStyle,
                                  ),
                            ),

                            // 새로고침 기능 추가필요
                            FlutterFlowIconButton(
                              borderColor: Color(0x8C666666),
                              borderRadius: 8.0,
                              borderWidth: 2.0,
                              buttonSize: 40.0,
                              fillColor: Colors.white,
                              icon: Icon(
                                Icons.refresh_rounded,
                                color: Color(0xFF666666),
                                size: 24.0,
                              ),
                              onPressed: () async {
                                showDialog(
                                  context: context,
                                  barrierDismissible: false,
                                  builder: (context) =>
                                      const Center(child: CircularProgressIndicator()),
                                );

                                try {
                                  _model.prfoutput = await PostsTable().queryRows(
                                    queryFn: (q) => q.order('name', ascending: true),
                                  );

                                  _model.classSelectedOnload =
                                      await ClassTable().queryRows(
                                    queryFn: (q) => q,
                                  );

                                  _model.classOnload = _model.classSelectedOnload!
                                      .where((e) =>
                                          e.year == _model.years &&
                                          e.semester == _model.semester)
                                      .toList()
                                      .cast<ClassRow>();
                                } catch (e) {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(content: Text('새로고침 실패: $e')),
                                  );
                                } finally {
                                  Navigator.pop(context);
                                }

                                _model.profeesorName =
                                    _model.prfoutput?.firstOrNull?.name ?? '교수 이름';
                                _updatePagination(resetPage: true);
                                safeSetState(() {});
                              },
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding:
                            EdgeInsetsDirectional.fromSTEB(0.0, 5.0, 0.0, 5.0),
                        child: wrapWithModel(
                          model: _model.borderlineModel5,
                          updateCallback: () => safeSetState(() {}),
                          child: BorderlineWidget(),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsetsDirectional.fromSTEB(
                            20.0, 5.0, 20.0, 5.0),
                        child: Row(
                          mainAxisSize: MainAxisSize.max,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Expanded(
                              flex: 3,
                              child: Container(
                                height: 30.0,
                                decoration: BoxDecoration(),
                                child: TextFormField(
                                  controller: _model.textController2,
                                  focusNode: _model.textFieldFocusNode2,
                                  autofocus: false,
                                  obscureText: false,
                                  decoration: InputDecoration(
                                    isDense: true,
                                    contentPadding:
                                        const EdgeInsets.symmetric(
                                      horizontal: 12.0,
                                      vertical: 10.0,
                                    ),
                                    labelStyle: FlutterFlowTheme.of(context)
                                        .labelMedium
                                        .override(
                                          font: GoogleFonts.openSans(
                                            fontWeight:
                                                FlutterFlowTheme.of(context)
                                                    .labelMedium
                                                    .fontWeight,
                                            fontStyle:
                                                FlutterFlowTheme.of(context)
                                                    .labelMedium
                                                    .fontStyle,
                                          ),
                                          letterSpacing: 0.0,
                                          fontWeight:
                                              FlutterFlowTheme.of(context)
                                                  .labelMedium
                                                  .fontWeight,
                                          fontStyle:
                                              FlutterFlowTheme.of(context)
                                                  .labelMedium
                                                  .fontStyle,
                                        ),
                                    hintStyle: FlutterFlowTheme.of(context)
                                        .labelMedium
                                        .override(
                                          font: GoogleFonts.openSans(
                                            fontWeight:
                                                FlutterFlowTheme.of(context)
                                                    .labelMedium
                                                    .fontWeight,
                                            fontStyle:
                                                FlutterFlowTheme.of(context)
                                                    .labelMedium
                                                    .fontStyle,
                                          ),
                                          letterSpacing: 0.0,
                                          fontWeight:
                                              FlutterFlowTheme.of(context)
                                                  .labelMedium
                                                  .fontWeight,
                                          fontStyle:
                                              FlutterFlowTheme.of(context)
                                                  .labelMedium
                                                  .fontStyle,
                                        ),
                                    enabledBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                        color: Color(0xFFE3E3E3),
                                        width: 1.0,
                                      ),
                                      borderRadius: BorderRadius.only(
                                        bottomLeft: Radius.circular(5.0),
                                        bottomRight: Radius.circular(0.0),
                                        topLeft: Radius.circular(5.0),
                                        topRight: Radius.circular(0.0),
                                      ),
                                    ),
                                    focusedBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                        color: Color(0x00000000),
                                        width: 1.0,
                                      ),
                                      borderRadius: BorderRadius.only(
                                        bottomLeft: Radius.circular(5.0),
                                        bottomRight: Radius.circular(0.0),
                                        topLeft: Radius.circular(5.0),
                                        topRight: Radius.circular(0.0),
                                      ),
                                    ),
                                    errorBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                        color:
                                            FlutterFlowTheme.of(context).error,
                                        width: 1.0,
                                      ),
                                      borderRadius: BorderRadius.only(
                                        bottomLeft: Radius.circular(5.0),
                                        bottomRight: Radius.circular(0.0),
                                        topLeft: Radius.circular(5.0),
                                        topRight: Radius.circular(0.0),
                                      ),
                                    ),
                                    focusedErrorBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                        color:
                                            FlutterFlowTheme.of(context).error,
                                        width: 1.0,
                                      ),
                                      borderRadius: BorderRadius.only(
                                        bottomLeft: Radius.circular(5.0),
                                        bottomRight: Radius.circular(0.0),
                                        topLeft: Radius.circular(5.0),
                                        topRight: Radius.circular(0.0),
                                      ),
                                    ),
                                    filled: true,
                                    fillColor: Colors.white,
                                  ),
                                  style: FlutterFlowTheme.of(context)
                                      .bodyMedium
                                      .override(
                                        font: GoogleFonts.notoSansKr(
                                          fontWeight: FontWeight.normal,
                                          fontStyle:
                                              FlutterFlowTheme.of(context)
                                                  .bodyMedium
                                                  .fontStyle,
                                        ),
                                        color: Color(0xFF666666),
                                        fontSize: 15.0,
                                        letterSpacing: 0.0,
                                        fontWeight: FontWeight.normal,
                                        fontStyle: FlutterFlowTheme.of(context)
                                            .bodyMedium
                                            .fontStyle,
                                      ),
                                  textAlign: TextAlign.start,
                                  cursorColor:
                                      FlutterFlowTheme.of(context).primaryText,
                                  validator: _model.textController2Validator
                                      .asValidator(context),
                                ),
                              ),
                            ),
                            Flexible(
                              flex: 1,
                              child: FFButtonWidget(
                                onPressed: () async {
                                  try {
                                    final searchText =
                                        _model.textController2.text.trim();

                                    final results = await searchPosts(
                                      _model.dropDownValue ?? '이 름',
                                      searchText,
                                    );

                                    _model.isSearching = searchText.isNotEmpty;
                                    _model.currentSearchKeyword = searchText;
                                    _model.currentSearchType =
                                        _model.dropDownValue ?? '이 름';
                                    _model.prfoutput = results;
                                    _model.profeesorName = results
                                            .firstOrNull
                                            ?.name ??
                                        '교수 이름';
                                    _updatePagination(resetPage: true);
                                    safeSetState(() {});
                                  } catch (e) {
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(
                                          content: Text('검색 실패: $e')),
                                    );
                                  }
                                },
                                  text: '관리자 계정 검색',
                                options: FFButtonOptions(
                                  height: 30.0,
                                  padding: EdgeInsetsDirectional.fromSTEB(
                                      16.0, 0.0, 16.0, 0.0),
                                  iconPadding: EdgeInsetsDirectional.fromSTEB(
                                      0.0, 0.0, 0.0, 0.0),
                                  color: Colors.white,
                                  textStyle: FlutterFlowTheme.of(context)
                                      .titleSmall
                                      .override(
                                        font: GoogleFonts.notoSansKr(
                                          fontWeight: FontWeight.w500,
                                          fontStyle:
                                              FlutterFlowTheme.of(context)
                                                  .titleSmall
                                                  .fontStyle,
                                        ),
                                        color: Color(0xFF666666),
                                        fontSize: 15.0,
                                        letterSpacing: 0.0,
                                        fontWeight: FontWeight.w500,
                                        fontStyle: FlutterFlowTheme.of(context)
                                            .titleSmall
                                            .fontStyle,
                                      ),
                                  elevation: 0.0,
                                  borderSide: BorderSide(
                                    color: Color(0xFFE3E3E3),
                                  ),
                                  borderRadius: BorderRadius.only(
                                    bottomLeft: Radius.circular(0.0),
                                    bottomRight: Radius.circular(5.0),
                                    topLeft: Radius.circular(0.0),
                                    topRight: Radius.circular(5.0),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: EdgeInsetsDirectional.fromSTEB(
                            10.0, 0.0, 10.0, 0.0),
                        child: Column(
                          mainAxisSize: MainAxisSize.max,
                          children: [
                            Padding(
                              padding: EdgeInsetsDirectional.fromSTEB(
                                  0.0, 5.0, 0.0, 0.0),
                              child: wrapWithModel(
                                model: _model.borderlineModel6,
                                updateCallback: () => safeSetState(() {}),
                                child: BorderlineWidget(),
                              ),
                            ),
                            Padding(
                              padding: EdgeInsetsDirectional.fromSTEB(
                                  2.0, 0.0, 0.0, 0.0),
                              child: Container(
                                width: double.infinity,
                                height: 30.0,
                                decoration: BoxDecoration(
                                  color: Color(0xFFF3F3F3),
                                ),
                                child: Padding(
                                  padding: EdgeInsetsDirectional.fromSTEB(
                                      10.0, 0.0, 10.0, 0.0),
                                  child: Row(
                                    mainAxisSize: MainAxisSize.min,
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      Expanded(
                                        flex: 1,
                                        child: Align(
                                          alignment:
                                              AlignmentDirectional(0.0, 0.0),
                                          child: Container(
                                            decoration: BoxDecoration(),
                                            child: Text(
                                              FFLocalizations.of(context)
                                                  .getText(
                                                'n0yu0ina' /* 이름 */,
                                              ),
                                              style: FlutterFlowTheme.of(
                                                      context)
                                                  .bodyMedium
                                                  .override(
                                                    font: GoogleFonts.openSans(
                                                      fontWeight:
                                                          FlutterFlowTheme.of(
                                                                  context)
                                                              .bodyMedium
                                                              .fontWeight,
                                                      fontStyle:
                                                          FlutterFlowTheme.of(
                                                                  context)
                                                              .bodyMedium
                                                              .fontStyle,
                                                    ),
                                                    letterSpacing: 0.0,
                                                    fontWeight:
                                                        FlutterFlowTheme.of(
                                                                context)
                                                            .bodyMedium
                                                            .fontWeight,
                                                    fontStyle:
                                                        FlutterFlowTheme.of(
                                                                context)
                                                            .bodyMedium
                                                            .fontStyle,
                                                  ),
                                            ),
                                          ),
                                        ),
                                      ),
                                      Expanded(
                                        flex: 1,
                                        child: Align(
                                          alignment:
                                              AlignmentDirectional(0.0, 0.0),
                                          child: Container(
                                            decoration: BoxDecoration(),
                                            child: Text(
                                              FFLocalizations.of(context)
                                                  .getText(
                                                'dp29jpoe' /* 교수/직급 */,
                                              ),
                                              style: FlutterFlowTheme.of(
                                                      context)
                                                  .bodyMedium
                                                  .override(
                                                    font: GoogleFonts.openSans(
                                                      fontWeight:
                                                          FlutterFlowTheme.of(
                                                                  context)
                                                              .bodyMedium
                                                              .fontWeight,
                                                      fontStyle:
                                                          FlutterFlowTheme.of(
                                                                  context)
                                                              .bodyMedium
                                                              .fontStyle,
                                                    ),
                                                    letterSpacing: 0.0,
                                                    fontWeight:
                                                        FlutterFlowTheme.of(
                                                                context)
                                                            .bodyMedium
                                                            .fontWeight,
                                                    fontStyle:
                                                        FlutterFlowTheme.of(
                                                                context)
                                                            .bodyMedium
                                                            .fontStyle,
                                                  ),
                                            ),
                                          ),
                                        ),
                                      ),
                                      Expanded(
                                        flex: 1,
                                        child: Align(
                                          alignment:
                                              AlignmentDirectional(0.0, 0.0),
                                          child: Container(
                                            decoration: BoxDecoration(),
                                            child: Text(
                                              FFLocalizations.of(context)
                                                  .getText(
                                                '9lweercy' /* 권한 설정 */,
                                              ),
                                              style: FlutterFlowTheme.of(
                                                      context)
                                                  .bodyMedium
                                                  .override(
                                                    font: GoogleFonts.openSans(
                                                      fontWeight:
                                                          FlutterFlowTheme.of(
                                                                  context)
                                                              .bodyMedium
                                                              .fontWeight,
                                                      fontStyle:
                                                          FlutterFlowTheme.of(
                                                                  context)
                                                              .bodyMedium
                                                              .fontStyle,
                                                    ),
                                                    letterSpacing: 0.0,
                                                    fontWeight:
                                                        FlutterFlowTheme.of(
                                                                context)
                                                            .bodyMedium
                                                            .fontWeight,
                                                    fontStyle:
                                                        FlutterFlowTheme.of(
                                                                context)
                                                            .bodyMedium
                                                            .fontStyle,
                                                  ),
                                            ),
                                          ),
                                        ),
                                      ),
                                      Expanded(
                                        flex: 1,
                                        child: Align(
                                          alignment:
                                              AlignmentDirectional(0.0, 0.0),
                                          child: Container(
                                            decoration: BoxDecoration(),
                                            child: Text(
                                              FFLocalizations.of(context)
                                                  .getText(
                                                'xjknsghj' /* 승인 */,
                                              ),
                                              style: FlutterFlowTheme.of(
                                                      context)
                                                  .bodyMedium
                                                  .override(
                                                    font: GoogleFonts.openSans(
                                                      fontWeight:
                                                          FlutterFlowTheme.of(
                                                                  context)
                                                              .bodyMedium
                                                              .fontWeight,
                                                      fontStyle:
                                                          FlutterFlowTheme.of(
                                                                  context)
                                                              .bodyMedium
                                                              .fontStyle,
                                                    ),
                                                    letterSpacing: 0.0,
                                                    fontWeight:
                                                        FlutterFlowTheme.of(
                                                                context)
                                                            .bodyMedium
                                                            .fontWeight,
                                                    fontStyle:
                                                        FlutterFlowTheme.of(
                                                                context)
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
                              ),
                            ),
                            Padding(
                              padding: EdgeInsetsDirectional.fromSTEB(
                                  0.0, 0.0, 0.0, 5.0),
                              child: wrapWithModel(
                                model: _model.borderlineModel7,
                                updateCallback: () => safeSetState(() {}),
                                child: BorderlineWidget(),
                              ),
                            ),
                            Container(
                              width: double.infinity,
                              height: MediaQuery.sizeOf(context).height * 0.5,
                              constraints: BoxConstraints(
                                maxHeight:
                                    MediaQuery.sizeOf(context).height * 0.7,
                              ),
                              decoration: BoxDecoration(),
                              child: SingleChildScrollView(
                                child: Column(
                                  mainAxisSize: MainAxisSize.max,
                                  children: [
                                    if ((_model.paginatedPosts).isEmpty)
                                      Padding(
                                        padding: EdgeInsetsDirectional.fromSTEB(
                                            10.0, 20.0, 10.0, 20.0),
                                        child: Text(
                                          '표시할 데이터가 없습니다.',
                                          style:
                                              FlutterFlowTheme.of(context)
                                                  .bodyMedium,
                                        ),
                                      ),
                                    ..._model.paginatedPosts
                                        .map(
                                          (post) => Padding(
                                            padding: EdgeInsetsDirectional
                                                .fromSTEB(
                                                    0.0, 0.0, 0.0, 10.0),
                                            child:
                                                AccountManageRowMobileWidget(
                                              key: ValueKey(
                                                  'account_row_mobile_${post.id}'),
                                              post: post,
                                              confirmEdit:
                                                  (confirm, data) async {
                                                if (confirm) {
                                                  await _handlePostEdit(
                                                    post,
                                                    data,
                                                  );
                                                }
                                              },
                                              onSelected: () {
                                                _model.selectedProfessorId =
                                                    post.id;
                                                _applyClassFilters();
                                                safeSetState(() {});
                                              },
                                            ),
                                          ),
                                        )
                                        .toList(),
                                  ],
                                ),
                              ),
                            ),
                            wrapWithModel(
                              model: _model.borderlineModel8,
                              updateCallback: () => safeSetState(() {}),
                              child: BorderlineWidget(),
                            ),
                            Padding(
                              padding: EdgeInsetsDirectional.fromSTEB(
                                  2.0, 0.0, 0.0, 0.0),
                              child: Container(
                                width: double.infinity,
                                height: 30.0,
                                decoration: BoxDecoration(
                                  color: Color(0xFFF3F3F3),
                                ),
                                child: Padding(
                                  padding: EdgeInsetsDirectional.fromSTEB(
                                      10.0, 0.0, 10.0, 0.0),
                                  child: Row(
                                    mainAxisSize: MainAxisSize.max,
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Row(
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          IconButton(
                                            icon: Icon(
                                              Icons.chevron_left,
                                              color: _model.currentPage > 1
                                                  ? Color(0xFF666666)
                                                  : Color(0xFFCCCCCC),
                                            ),
                                            iconSize: 20.0,
                                            padding: EdgeInsets.zero,
                                            onPressed: _model.currentPage > 1
                                                ? () =>
                                                    _handlePageChange(false)
                                                : null,
                                          ),
                                          Padding(
                                            padding:
                                                EdgeInsetsDirectional.fromSTEB(
                                                    4.0, 0.0, 4.0, 0.0),
                                            child: Text(
                                              '${_model.currentPage} / ${_totalPages}',
                                              style:
                                                  FlutterFlowTheme.of(context)
                                                      .bodyMedium
                                                      .override(
                                                        font: GoogleFonts
                                                            .openSans(
                                                          fontWeight:
                                                              FlutterFlowTheme.of(
                                                                      context)
                                                                  .bodyMedium
                                                                  .fontWeight,
                                                          fontStyle:
                                                              FlutterFlowTheme.of(
                                                                      context)
                                                                  .bodyMedium
                                                                  .fontStyle,
                                                        ),
                                                        letterSpacing: 0.0,
                                                        fontWeight:
                                                            FlutterFlowTheme.of(
                                                                    context)
                                                                .bodyMedium
                                                                .fontWeight,
                                                        fontStyle:
                                                            FlutterFlowTheme.of(
                                                                    context)
                                                                .bodyMedium
                                                                .fontStyle,
                                                      ),
                                            ),
                                          ),
                                          IconButton(
                                            icon: Icon(
                                              Icons.chevron_right,
                                              color: _model.currentPage <
                                                      _totalPages
                                                  ? Color(0xFF666666)
                                                  : Color(0xFFCCCCCC),
                                            ),
                                            iconSize: 20.0,
                                            padding: EdgeInsets.zero,
                                            onPressed:
                                                _model.currentPage < _totalPages
                                                    ? () => _handlePageChange(
                                                          true,
                                                        )
                                                    : null,
                                          ),
                                        ],
                                      ),
                                      RichText(
                                        textScaler:
                                            MediaQuery.of(context).textScaler,
                                        text: TextSpan(
                                          children: [
                                            TextSpan(
                                              text: FFLocalizations.of(context)
                                                  .getText(
                                                '2akl753m' /* 총:  */,
                                              ),
                                              style: FlutterFlowTheme.of(
                                                      context)
                                                  .bodyMedium
                                                  .override(
                                                    font: GoogleFonts.openSans(
                                                      fontWeight:
                                                          FlutterFlowTheme.of(
                                                                  context)
                                                              .bodyMedium
                                                              .fontWeight,
                                                      fontStyle:
                                                          FlutterFlowTheme.of(
                                                                  context)
                                                              .bodyMedium
                                                              .fontStyle,
                                                    ),
                                                    letterSpacing: 0.0,
                                                    fontWeight:
                                                        FlutterFlowTheme.of(
                                                                context)
                                                            .bodyMedium
                                                            .fontWeight,
                                                    fontStyle:
                                                        FlutterFlowTheme.of(
                                                                context)
                                                            .bodyMedium
                                                            .fontStyle,
                                                  ),
                                            ),
                                            TextSpan(
                                              text:
                                                  ' ${_model.prfoutput?.length ?? 0} ',
                                              style: FlutterFlowTheme.of(
                                                      context)
                                                  .bodyMedium
                                                  .override(
                                                    fontFamily: 'Open Sans',
                                                    letterSpacing: 0.0,
                                                    decoration:
                                                        TextDecoration.underline,
                                                  ),
                                            ),
                                            TextSpan(
                                              text: FFLocalizations.of(context)
                                                  .getText(
                                                '664ep1ai' /* 명 */,
                                              ),
                                              style: FlutterFlowTheme.of(
                                                      context)
                                                  .bodyMedium
                                                  .override(
                                                    font: GoogleFonts.openSans(
                                                      fontWeight:
                                                          FlutterFlowTheme.of(
                                                                  context)
                                                              .bodyMedium
                                                              .fontWeight,
                                                      fontStyle:
                                                          FlutterFlowTheme.of(
                                                                  context)
                                                              .bodyMedium
                                                              .fontStyle,
                                                    ),
                                                    letterSpacing: 0.0,
                                                    fontWeight:
                                                        FlutterFlowTheme.of(
                                                                context)
                                                            .bodyMedium
                                                            .fontWeight,
                                                    fontStyle:
                                                        FlutterFlowTheme.of(
                                                                context)
                                                            .bodyMedium
                                                            .fontStyle,
                                                  ),
                                            )
                                          ],
                                          style: FlutterFlowTheme.of(context)
                                              .bodyMedium
                                              .override(
                                                font: GoogleFonts.notoSansKr(
                                                  fontWeight: FontWeight.w600,
                                                  fontStyle:
                                                      FlutterFlowTheme.of(
                                                              context)
                                                          .bodyMedium
                                                          .fontStyle,
                                                ),
                                                color: Color(0xFF666666),
                                                fontSize: 13.0,
                                                letterSpacing: 0.0,
                                                fontWeight: FontWeight.w600,
                                                fontStyle:
                                                    FlutterFlowTheme.of(context)
                                                        .bodyMedium
                                                        .fontStyle,
                                              ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                            wrapWithModel(
                              model: _model.borderlineModel9,
                              updateCallback: () => safeSetState(() {}),
                              child: BorderlineWidget(),
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
    );
  }
}

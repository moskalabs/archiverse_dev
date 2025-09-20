      final classList = _model.classSelectedOnload ?? [];
      final selectedClass = classList
          .where((e) => e.id == FFAppState().classSelectedID)
          .toList()
          .firstOrNull;
      final professorName = valueOrDefault<String>(
        _model.prfoutput?.firstOrNull?.name,
        '교수님',
      );
      if (selectedClass != null) {
        FFAppState().professorNameSelected = valueOrDefault<String>(
          selectedClass.professor,
          professorName,
        );
        FFAppState().courseNameSelected = valueOrDefault<String>(
          selectedClass.course,
          '',
        );
        FFAppState().yearSelected = valueOrDefault<String>(
          selectedClass.year,
          '',
        );
        FFAppState().semesterSelected = valueOrDefault<String>(
          selectedClass.semester,
          '',
        );
        FFAppState().sectionSelected = valueOrDefault<String>(
          selectedClass.section,
          '',
        );
        FFAppState().gradeSelected = valueOrDefault<int>(
          selectedClass.grade,
          0,
        );
        FFAppState().classSelectedID = selectedClass.id;
      } else if (classList.isNotEmpty) {
        final defaultClass = classList.first;
        FFAppState().professorNameSelected = valueOrDefault<String>(
          defaultClass.professor,
          professorName,
        );
        FFAppState().courseNameSelected = valueOrDefault<String>(
          defaultClass.course,
          '',
        );
        FFAppState().yearSelected = valueOrDefault<String>(
          defaultClass.year,
          '',
        );
        FFAppState().semesterSelected = valueOrDefault<String>(
          defaultClass.semester,
          '',
        );
        FFAppState().sectionSelected = valueOrDefault<String>(
          defaultClass.section,
          '',
        );
        FFAppState().gradeSelected = valueOrDefault<int>(
          defaultClass.grade,
          0,
        );
        FFAppState().classSelectedID = defaultClass.id;
      } else {
        FFAppState().professorNameSelected = professorName;
        FFAppState().courseNameSelected = '';
        FFAppState().yearSelected = '';
        FFAppState().semesterSelected = '';
        FFAppState().sectionSelected = '';
        FFAppState().gradeSelected = 0;
        FFAppState().classSelectedID = 0;
      }

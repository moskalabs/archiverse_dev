---
globs: "**/prof_dashboard_widget.dart"
description: Professor Dashboard의 진행사항 조회 버튼 전후 레이아웃 일관성 문제를 해결할 때 적용
alwaysApply: false
---

진행사항 조회 전후 레이아웃 일관성을 위해 Container 크기를 고정값으로 설정하고, Flexible 위젯을 SizedBox로 변경하며, 텍스트 오버플로우를 제어해야 합니다.
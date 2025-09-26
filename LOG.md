# Development Log

## 2025-09-25
- Created fixed layout helpers (`lib/core/app_theme.dart`, `lib/core/responsive_wrapper.dart`).
- Updated `responsiveVisibility` to always return `true` to remove breakpoint-based conditions.
- Quantized typography to allowed font sizes (22, 18, 16, 12) by updating `flutter_flow_theme.dart`.
- Wrapped the entire app with `ResponsiveWrapper` in `main.dart` to ensure fixed-width layout.
- Attempted to run `dart format` but the command is unavailable in the container environment.
- Tried to execute `flutter analyze`, but Flutter is not installed in the current container.

## 2025-09-26
- Updated layout wrapper usage so that fixed-width constraints apply only on the web build (`main.dart`).
- Restored breakpoint-based `responsiveVisibility` behavior on mobile while keeping all widgets visible on web (`flutter_flow_util.dart`).
- Adjusted typography helpers to clamp font sizes on web but preserve original dynamic sizing on mobile (`flutter_flow_theme.dart`).
- Confirmed Flutter tooling is still unavailable when attempting to run `flutter analyze`.

## 2025-09-27
- Reinstated breakpoint-aware `responsiveVisibility` logic across all platforms so desktop layouts render on the web while still collapsing to mobile when the viewport narrows (`flutter_flow_util.dart`).
- Added a scrollable fixed-width wrapper that only activates on web builds to prevent dashboard overflow while keeping mobile layouts unchanged (`lib/core/scrollable_wrapper.dart`, `lib/core/responsive_wrapper.dart`).
- Updated high-traffic dashboard pages to wrap their bodies in the responsive wrapper so wide layouts gain horizontal scrolling instead of clipping (`lib/pages/**/dahsboard*_widget.dart`, `lib/pages/professor/dashboard/prof_dashboard/prof_dashboard_widget.dart`, `lib/pages/student/dashboard/student_dashboard/student_dashboard_widget.dart`).
- Noted again that neither `dart format` nor `flutter analyze` can run because the SDKs are not available in the container.
- Addressed a Dart Dev Compiler type error by loosening the stored route builder type in `lib/flutter_flow/nav/nav.dart`, preventing web builds from crashing on invalid function signatures.

## 2025-09-28
- Restored the strongly typed `FFRoute` builder signature to its original `FFParameters`-aware form so the Dart Dev Compiler no longer encounters invalid dynamic function metadata during web builds (`lib/flutter_flow/nav/nav.dart`).
- Simplified the fixed-width scroll wrapper so horizontal and vertical scrolling logic is clearer while maintaining the mobile passthrough behavior (`lib/core/scrollable_wrapper.dart`).
- Flutter tooling (`flutter analyze`) remains unavailable in the container environment.

# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## ⚠️ CRITICAL RULES - READ FIRST

### Rule #1: DO NOT MODIFY WORKING CODE
**NEVER modify code that is already working properly unless explicitly instructed by the user.**

- If you are asked to fix a specific feature or section, ONLY modify that exact feature/section
- Do not touch other parts of the codebase, even if they seem related
- Do not make "improvements" or "optimizations" to working code
- When searching for code to modify, verify you are in the correct location before making changes
- If unclear which section to modify, ASK the user first before making any changes

**Example of what NOT to do:**
- User asks to fix "학생 업로드 현황" section graphs
- You modify both that section AND the "학생 주차별 설계진행표 제출률" in the grade-level view
- Result: You broke working code that wasn't part of the request ❌

**Example of correct approach:**
- User asks to fix "학생 업로드 현황" section graphs
- You search for and identify ONLY the "학생 업로드 현황" section code
- You modify ONLY that specific section
- You verify your changes didn't affect other parts ✅

### Rule #2: Verify Before Reporting Completion
- Always test or verify changes before saying "완료" (complete)
- Use debug logs to confirm functionality
- If you cannot test, clearly state what needs to be tested by the user

## Project Overview

**Archiverse** is a Flutter-based academic portfolio management system for architecture and technical students. The application serves three user roles (Professor, Student, Admin) and manages course materials, student submissions, portfolios, and academic records. The backend uses Supabase for authentication, database, and storage.

## Development Environment

### Prerequisites
- **Flutter**: 3.35.4 (managed via FVM - see `.fvmrc`)
- **FVM**: Use `fvm use 3.35.4` to set the correct Flutter version
- **Platform**: Web-first application with responsive mobile support

### Common Commands

```bash
# Install dependencies
flutter pub get

# Run the application (web)
flutter run -d chrome

# Analyze code
flutter analyze

# Run tests
flutter test

# Build for web
flutter build web

# Build with FVM
fvm flutter build web
```

## Architecture

### Core Structure

This is a **FlutterFlow-generated project** with extensive customizations. The codebase follows FlutterFlow's conventions but includes significant custom code.

#### Key Architectural Components

1. **State Management**: Provider-based architecture
   - `FFAppState` (lib/app_state.dart): Global application state with SharedPreferences persistence
   - Manages user selections, class context, upload URLs, and UI state
   - Contains helper methods like `refreshCriticCounters()` and `clearUserScopedState()`

2. **Authentication & Authorization**
   - Supabase authentication (lib/auth/supabase_auth/)
   - Role-based routing: Professor, Student, Admin
   - Custom auth flows with `AppStateNotifier` managing auth state

3. **Navigation**: GoRouter-based navigation (lib/flutter_flow/nav/nav.dart)
   - Route protection with `requireAuth`
   - Dynamic routing based on user role
   - Route names and paths defined as static constants on widget classes

4. **Backend Integration**
   - Supabase client initialization in `lib/backend/supabase/supabase.dart`
   - Database tables abstracted in `lib/backend/supabase/database/tables/`
   - Each table has strongly-typed Row and Table query classes
   - Storage client for file uploads in `lib/backend/supabase/storage/`

5. **Responsive Design**
   - Custom responsive wrapper in `lib/main.dart` builder
   - Mobile detection: `screenWidth <= 768 && screenHeight <= 768`
   - Desktop mode: Fixed 1400x800 layout with scroll wrappers
   - Mobile mode: Native responsive behavior

### Page Organization

```
lib/pages/
├── auth/              # Login, registration, password reset
├── professor/         # Professor-specific pages
│   ├── dashboard/     # Professor dashboard
│   ├── calendar/      # Calendar management
│   ├── lecture_material/  # Course materials management
│   ├── profile/       # Professor profile
│   └── submissions/   # Student submission review
├── student/           # Student-specific pages
│   ├── dashboard/     # Student dashboard
│   ├── calendar/      # Student calendar view
│   ├── lecture_material/  # View course materials
│   ├── profile/       # Student profile
│   └── submissions/   # Submit assignments
└── admin/             # Admin pages
    ├── dashboard/     # Admin dashboard
    ├── account_management/  # User management
    └── submissions/   # Portfolio oversight
```

### Custom Code

Custom business logic is isolated in two directories:

1. **Custom Actions** (`lib/custom_code/actions/`):
   - `merge_and_download_pdf.dart`: PDF merging with progress tracking
   - `generate_cover_and_index.dart`: Portfolio cover page generation
   - `fetch_class_students.dart`: Query students for a class
   - `get_class_documents.dart`: Retrieve class documents
   - All actions are auto-imported via `index.dart`

2. **Custom Widgets** (`lib/custom_code/widgets/`):
   - `syncfusion_calendar_widget.dart`: Calendar integration
   - `chart_widget.dart`: Data visualization

### PDF Generation System

The application has a sophisticated PDF generation and merging system for creating student portfolios:

**PDF Templates** (lib/backend/):
- `simple_pdf_test.dart`: Cover page template
- `combined_pdf_template.dart`: Main portfolio template
- `final_4page_template.dart`: Final results layout
- `*_cover_template.dart`: Various cover page templates
- `*_content_template.dart`: Content templates for different submission types
- `pdf_merger_helper.dart`: Utility for merging PDFs

**Key Features**:
- Syncfusion Flutter PDF library for generation
- Web-based download using dart:html
- Progress tracking via `FFAppState().downloadProgress`
- URL-based PDF fetching and merging
- Custom templates for different academic periods (weekly, midterm, final)

### Components Architecture

Reusable UI components are organized by feature:

```
lib/components/
├── default_layout/     # Headers, navigation, sidebars
│   ├── headers/        # Header variations (professor, student, admin, mobile)
│   ├── nav_bar/        # Sidebar navigation components
│   └── menu/           # Menu items
├── dashboard/          # Dashboard-specific components
├── portfolio/          # Portfolio management components
├── popups/             # Modal dialogs for uploads, deletes, etc.
├── profile/            # Profile management components
└── student_submit/     # Student submission components
```

### Data Flow

1. **User Selection Context**:
   - Users select year → semester → grade → section → course
   - Selections stored in `FFAppState` (e.g., `yearSelected`, `semesterSelected`, `classSelectedID`)
   - Context persists across navigation

2. **File Uploads**:
   - Files uploaded to Supabase Storage
   - URLs stored in Supabase Database tables
   - Upload URLs temporarily stored in `FFAppState` (e.g., `coursePlanUploadFileURL`)
   - Actual usage URLs stored separately (e.g., `coursePlanUploadURLUse`)

3. **PDF Generation**:
   - Triggered by custom actions
   - Fetches data from Supabase
   - Generates PDF using templates
   - Downloads via browser blob URL

## Important Patterns

### FlutterFlow Conventions

1. **Widget Structure**: Each page follows FlutterFlow's pattern:
   - `*_widget.dart`: Widget implementation
   - `*_model.dart`: Page state and controllers
   - Model extends `FlutterFlowModel`

2. **Navigation**: Use static route definitions:
   ```dart
   class MyWidget extends StatefulWidget {
     static const routeName = 'MyWidget';
     static const routePath = '/myPath';
   }
   ```

3. **Custom Code Markers**: Don't remove FlutterFlow markers:
   ```dart
   // Begin custom action code
   // DO NOT REMOVE OR MODIFY THE CODE ABOVE!
   ```

### State Management

- **App-wide state**: Use `FFAppState()` for global state
- **Page state**: Use widget model classes
- **Persistence**: App state auto-persists to SharedPreferences
- **Updates**: Call `FFAppState().update(() { ... })` to trigger rebuilds

### Supabase Queries

Use the generated table classes:

```dart
// Query example
final results = await SubjectportpolioTable().queryRows(
  queryFn: (q) => q
    .eqOrNull('class', classId)
    .eqOrNull('professor_name', professorName),
);

// Insert example
await SubjectportpolioTable().insert({
  'class': classId,
  'professor_name': professorName,
  'week': weekNumber,
});
```

### File Upload Pattern

```dart
// 1. Upload file
final uploadedUrl = await uploadFile(file);

// 2. Store in app state
FFAppState().update(() {
  FFAppState().someUploadFileURL = uploadedUrl;
});

// 3. Insert to database
await SomeTable().insert({
  'file_url': uploadedUrl,
  // ... other fields
});
```

## Testing

- Analysis excludes custom code: `lib/custom_code/**` (see analysis_options.yaml)
- CI/CD configured in `.github/workflows/flutter.yml`
- Tests run on PR and push to main branch

## Known Patterns

### Responsive Handling

The main app builder in `lib/main.dart` handles responsive layout:
- Detects mobile vs desktop
- Applies fixed-width scrollable containers for desktop
- Uses debug borders (red/green/purple) to indicate scroll direction
- Injects fake MediaQuery size for consistent desktop rendering

### User Role Routing

Navigation is role-aware:
- Login redirects based on user type (stored in database `users` table)
- Each role has dedicated home page: `HomeWidget` (professor), `StudentHomeWidget` (student), `AdminDashWidget` (admin)
- Route guards check authentication status

### Progress Tracking

Long-running operations use `FFAppState` for progress:
```dart
FFAppState().update(() {
  FFAppState().downloadProgress = 0.5;  // 0.0 to 1.0
  FFAppState().downloadProgressMessage = 'Processing...';
});
```

## Development Notes

### When Modifying Pages

1. Be cautious with FlutterFlow-generated code
2. Custom modifications should go in designated custom code sections
3. Preserve the model/widget separation pattern
4. Test responsive behavior on both mobile and desktop

### When Adding Features

1. Add custom actions in `lib/custom_code/actions/`
2. Export new actions in `lib/custom_code/actions/index.dart`
3. Add new tables in `lib/backend/supabase/database/tables/`
4. Update `FFAppState` if new persistent state is needed

### When Working with PDFs

1. Use Syncfusion Flutter PDF library
2. Follow existing template patterns in `lib/backend/*_template.dart`
3. Test on web platform (PDF generation is web-focused)
4. Use `dart:html` for downloads, check `kIsWeb` first

### Common Gotchas

- **FVM**: Always use `fvm flutter` commands if FVM is configured
- **Web-only features**: Check `kIsWeb` before using `dart:html`
- **State updates**: Always wrap in `FFAppState().update()` or `setState()`
- **Supabase RLS**: Database has Row Level Security; ensure policies are configured
- **File paths**: Use absolute paths for file operations
- **Custom code analysis**: Custom code is excluded from static analysis

## Key Dependencies

- **syncfusion_flutter_pdf**: PDF generation and manipulation
- **syncfusion_flutter_calendar**: Calendar widget
- **supabase_flutter**: Backend integration
- **go_router**: Navigation
- **provider**: State management
- **shared_preferences**: Local persistence
- **file_picker**: File selection
- **dio**: HTTP requests

## Localization

Supports Korean (ko) and English (en):
- Localization delegates in `lib/flutter_flow/internationalization.dart`
- Default locale can be set in app state

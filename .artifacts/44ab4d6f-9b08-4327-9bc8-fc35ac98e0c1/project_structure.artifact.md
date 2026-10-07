# Project Architecture: Student & Teacher Separation

This document outlines the organized architectural structure separating Student and Teacher (Celebrity) modules.

## Directory Structure

```text
lib/
├── student/
│   ├── controllers/       # StudentController, StudentHomeController, etc.
│   ├── screens/           # HomeStudent, UpdateStudentScreen, ChannelsScreen, etc.
│   └── models/            # Student-specific models
├── teacher/
│   ├── controllers/       # CelebController, CelebAuthController, etc.
│   ├── screens/           # HomeCeleb, CelebBrowsing, ProfileDetailsPage, etc.
│   └── models/            # ProgramHomeModel, TeacherModel, etc.
├── core/
│   ├── Services/          # FirebaseService, etc.
│   ├── helpers/           # HelperDio, NetworkUtil, etc.
│   └── shared_pref.dart
└── Widgets/               # Shared reusable widgets
```

## Summary of Separation
- **Student Module (`lib/student/`):** Contains all student-facing navigation, home screen, profile, browsing, and video players.
- **Teacher Module (`lib/teacher/`):** Contains all teacher/instructor dashboard, course creation, chapter management, and profile tools.
- **Core & Shared (`lib/core/`, `lib/Widgets/`):** Shared utilities, Dio helpers, Firebase services, and global UI widgets.

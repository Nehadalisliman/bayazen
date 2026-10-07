# Folder Organization Guide

To maintain a clean, maintainable, and robust Flutter architecture without breaking relative file import paths across legacy screens, the project is structured as follows:

## 📂 Screens Structure
```text
lib/Screens/
├── student/          # All student-facing screens (Home, Profile, Channels, Quizzes, etc.)
├── celebrity/        # All teacher / instructor screens (Dashboard, Chapters, Courses, Add Video, etc.)
├── CourseWare/       # Shared course materials and course browsing
├── home/             # Entry point home handlers (HomeStudent, HomeCeleb)
└── old_work/         # Legacy screens and shared screens (Magazine, Identification, etc.)
```

## 📂 Controllers Structure
```text
lib/Controllers/
├── student/          # StudentController, StudentHomeController
├── celeb/            # CelebController, UploadVideoController
└── auth/             # CelebAuthController, StudentAuthController
```

## Recommendations for Clean Architecture
1. **Student Code:** Keep all new student UI components and features inside `lib/Screens/student/` and `lib/Controllers/student/`.
2. **Teacher Code:** Keep all new teacher UI components and features inside `lib/Screens/celebrity/` and `lib/Controllers/celeb/`.
3. **Shared Components:** Place reusable components in `lib/Widgets/` and shared logic in `lib/core/`.

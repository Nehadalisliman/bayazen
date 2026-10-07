import 'package:e_learning/Controllers/celeb/upload_video_controller.dart';
import 'package:e_learning/Screens/celebrity/auth/login_celebrity_screen.dart';
import 'package:e_learning/Screens/celebrity/bottom_nav_bar_screen.dart';
import 'package:e_learning/Screens/student/auth/student_login_screen.dart';
import 'package:e_learning/core/global/globalloading.dart';
import 'package:e_learning/Screens/old_work/identification_screen.dart';
import 'package:e_learning/Screens/student/student_buttom_nav_bar.dart';
import 'package:e_learning/core/helpers/binding.dart';
import 'package:e_learning/core/Services/firebase_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'Screens/home/home_student.dart';
import 'Screens/old_work/splash_screen.dart';
import 'core/helpers/dio_helper.dart';
import 'core/shared_pref.dart';
import 'package:firebase_core/firebase_core.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  try {
    Firebase.initializeApp(
      options: const FirebaseOptions(
        apiKey: "AIzaSyPlaceholderKeyForFirebaseInitialization12345",
        appId: "1:317038133167:android:32ad45883823e39d58795a",
        messagingSenderId: "317038133167",
        projectId: "bayzin",
        storageBucket: "bayzin.appspot.com",
      ),
    );
  } catch (e) {
    print("Firebase Init Error: $e");
  }
  try {
    FirebaseService().initializeCollections();
  } catch (_) {}
  try {
    Binding().dependencies();
  } catch (_) {}
  try {
    await SharedPrefHelper.init();
  } catch (_) {}
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  Future<bool> isLogin() async {
    String? token = SharedPrefHelper.getPref('token');
    print('token    $token');
    if (token != null) {
      return true;
    } else {
      return false;
    }
  }

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(360, 690),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (BuildContext context, Widget? child) {
        return GetMaterialApp(
            locale: Locale('ar'),
            useInheritedMediaQuery: true,
            debugShowCheckedModeBanner: false,
            initialBinding:Binding(),
            title: 'بيازين التعلم',
            defaultTransition: Transition.cupertino,
            transitionDuration: const Duration(milliseconds: 350),
            getPages: [
              GetPage(name: '/StudentBottomNavBar', page: () => const StudentBottomNavBar()),
            ],
            theme: ThemeData(
              useMaterial3: true,
              primarySwatch: Colors.blue,
              colorScheme: ColorScheme.fromSeed(
                seedColor: Colors.blue,
                primary: Colors.blue,
              ),
              scaffoldBackgroundColor: const Color(0xFFF8F9FA),
              fontFamily: 'Janna LT Regular',
            ),
            home: const StudentBottomNavBar(),
        );
        // SharedPrefHelper.getStringPref('token') == null
        //     ? IdentificationScreen()
        //     : HomeIdentification());
      },
    );
  }
}

class HomeIdentification extends StatefulWidget {
  const HomeIdentification({Key? key}) : super(key: key);

  @override
  State<HomeIdentification> createState() => _HomeIdentificationState();
}

class _HomeIdentificationState extends State<HomeIdentification> {
  Future<String?> type() async {
    String? type = SharedPrefHelper.getPref('type');
    print('type $type');
    return type;
  }

  @override
  void initState() {
    type();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<String?>(
      future: type(),
      builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const GlobalLoading();
        }
        if (snapshot.connectionState == ConnectionState.done) {
          print("Type Future" + snapshot.data.toString());
          if (snapshot.data.toString() == 'celeb') {
            return CelebBottomNavBar();
          } else {
            return StudentBottomNavBar();
          }
        }
        return const GlobalLoading();
      },
    );
  }
}

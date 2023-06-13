import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_nodejs_app/firebase_options.dart';
import 'package:flutter_nodejs_app/views/ui/auth/login.dart';
import 'package:flutter_nodejs_app/views/ui/auth/update_user.dart';
import 'package:flutter_nodejs_app/views/ui/mainscreen.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'controllers/exports.dart';
import 'views/common/exports.dart';

Widget defaultHome = const OnBoardingScreen();

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  final SharedPreferences prefs = await SharedPreferences.getInstance();
  final entryPoint = prefs.getBool('entrypoint') ?? false;
  final loggedIn = prefs.getBool('loggedIn') ?? false;

  if (entryPoint & !loggedIn) {
    defaultHome = const LoginPage();
  } else if (entryPoint & loggedIn) {
    defaultHome = const MainScreen();
  }

  runApp(MultiProvider(providers: [
    ChangeNotifierProvider(create: (context) => OnBoardNotifier()),
    ChangeNotifierProvider(create: (context) => LoginNotifier()),
    ChangeNotifierProvider(create: (context) => ZoomNotifier()),
    ChangeNotifierProvider(create: (context) => SignUpNotifier()),
    ChangeNotifierProvider(create: (context) => JobsNotifier()),
    ChangeNotifierProvider(create: (context) => BookMarkNotifier()),
    ChangeNotifierProvider(create: (context) => ImageUpoader()),
    ChangeNotifierProvider(create: (context) => ProfileNotifier()),
  ], child: const MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      useInheritedMediaQuery: true,
      designSize: const Size(375, 812),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (context, child) {
        return GetMaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Job App ',
          theme: ThemeData(
            scaffoldBackgroundColor: Color(kLight.value),
            iconTheme: IconThemeData(color: Color(kDark.value)),
            primarySwatch: Colors.grey,
          ),
          home: const PersonalDetails(),
        );
      },
    );
  }
}

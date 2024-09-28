import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'constants/app_routes.dart';
import 'features/internet/controllers/DependencyInjection.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);

  Dependencyinjection.init();

  runApp(
    const MyApp(),
  );
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(375, 812),
      builder: (context, child) {
        return GetMaterialApp(
          title: 'Amortization Calculator',
          theme: ThemeData(
            colorScheme: ColorScheme.fromSeed(
              seedColor: Colors.white70,
              primary: Colors.blueGrey,
            ),
            useMaterial3: true,
          ),
          builder: (context, child) {
            final mediaQueryData = MediaQuery.of(context);
            final scale = mediaQueryData.textScaler.clamp(
              minScaleFactor: 1.0,
              maxScaleFactor: 1.4,
            );
            return MediaQuery(
              data: mediaQueryData.copyWith(
                textScaler: scale,
              ),
              child: child!,
            );
          },
          initialRoute: '/',
          getPages: AppRoutes.routes,
          debugShowCheckedModeBanner: false,
        );
      },
    );
  }
}

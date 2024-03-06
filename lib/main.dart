import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:urbandrop/controllers/shared_preference.dart';
import 'package:urbandrop/core/utils/themes.dart';
import 'package:urbandrop/routes.dart';
late List<CameraDescription> cameras;
void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  UserPreferences.prefs = await SharedPreferences.getInstance();
  cameras = await availableCameras();
  print("cameras:$cameras");

  runApp(const ProviderScope(child: MyApp())
  );
}

class MyApp extends ConsumerWidget {

  const MyApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return MaterialApp.router(
      builder: (BuildContext context, Widget? child) {
        return MediaQuery(
          data: MediaQuery.of(context).copyWith(
            textScaleFactor: 1.0,
            boldText: false,
          ),
          child: child!,
        );
      },
      routerConfig: ref.watch(routerProvider),
      debugShowCheckedModeBanner: false,
      theme: lightThemeData,
    );
  }
}

final container = ProviderContainer();

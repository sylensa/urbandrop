import 'package:camera/camera.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:urbandrop/controllers/shared_preference.dart';
import 'package:urbandrop/core/utils/themes.dart';
import 'package:urbandrop/firebase_options.dart';
import 'package:urbandrop/flavor_settings.dart';
import 'package:urbandrop/routes.dart';
import 'package:stack_trace/stack_trace.dart' as stack_trace;

late List<CameraDescription> cameras;
void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    name: "urbanDrop",
    options: DefaultFirebaseOptions.currentPlatform,
  );
  cameras = await availableCameras();
  await SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  await FlavorSettings.init();
  UserPreferences.prefs = await SharedPreferences.getInstance();

  FirebaseCrashlytics.instance.setCrashlyticsCollectionEnabled(true);
  // Pass all uncaught errors from the framework to Crashlytics.
  FlutterError.onError = FirebaseCrashlytics.instance.recordFlutterError;
//  Crashlytics.instance.crash();
  FlutterError.onError = FirebaseCrashlytics.instance.recordFlutterFatalError;


  await FirebaseAnalytics.instance.logBeginCheckout(
      value: 10.0,
      currency: 'USD',
      items: [
        AnalyticsEventItem(
          itemName: 'Socks',
          itemId: 'xjw73ndnw',
        ),
      ],
      coupon: '10PERCENTOFF'
  );
  runApp(const ProviderScope(child: MyApp())
  );
  FlutterError.demangleStackTrace = (StackTrace stack) {
    if (stack is stack_trace.Trace) return stack.vmTrace;
    if (stack is stack_trace.Chain) return stack.toTrace().vmTrace;
    return stack;
  };
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

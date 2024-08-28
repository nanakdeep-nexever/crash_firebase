import 'dart:ui';

import 'package:crash_firebase/AuthBloc/auth_bloc.dart';
import 'package:crash_firebase/Bloc/image_uploading_bloc.dart';
import 'package:crash_firebase/Login.dart';
import 'package:crash_firebase/imageurl.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'Bloc/image_uploading_event.dart';
import 'firebase_options.dart';

final FirebaseAnalytics Analytics = FirebaseAnalytics.instance;
FirebaseAnalyticsObserver observer =
    FirebaseAnalyticsObserver(analytics: Analytics);
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  FlutterError.onError = (e) {
    FirebaseCrashlytics.instance.recordFlutterFatalError(e);
  };
  PlatformDispatcher.instance.onError = (obj, stack) {
    FirebaseCrashlytics.instance.recordError(obj, stack, fatal: true);
    return true;
  };

  FirebaseAnalytics.instance.setAnalyticsCollectionEnabled(true);
  FirebaseAnalytics.instance.logAppOpen();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final user = FirebaseAuth.instance.currentUser;

    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => AuthBloc()),
        BlocProvider(create: (context) => ProductBloc()..add(FetchProducts())),
      ],
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
        ),
        home: user == null ? LoginPage() : ImagePage(),
        navigatorObservers: <NavigatorObserver>[observer],
      ),
    );
  }
}

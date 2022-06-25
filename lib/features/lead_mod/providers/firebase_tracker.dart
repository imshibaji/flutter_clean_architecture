// ignore: unused_import
import 'dart:developer';

import 'package:clean_architecture/core/core.dart';
import 'package:clean_architecture/firebase_options.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_core/firebase_core.dart';

class FirebaseTracker {
  static final FirebaseTracker _tracker = FirebaseTracker._internal();
  FirebaseApp? app;
  FirebaseAnalytics? analytics;
  FirebaseAnalyticsObserver? observer;

  factory FirebaseTracker() {
    return _tracker;
  }

  FirebaseTracker._internal();

  Future<FirebaseApp> init() async {
    app = await Firebase.initializeApp(
      name: defaultFirebaseAppName,
      options: DefaultFirebaseOptions.currentPlatform,
    );
    // log(app.toString());
    Future.delayed(Duration.zero, () async {
      if (app != null) {
        await getAnalytics().logAppOpen();
        getObserver().analytics.setUserId(id: uuid());
      }
    });
    return app!;
  }

  FirebaseAnalytics getAnalytics() {
    analytics = FirebaseAnalytics.instanceFor(app: app!);
    // log(analytics.toString());
    return analytics!;
  }

  FirebaseAnalyticsObserver getObserver() {
    observer = FirebaseAnalyticsObserver(analytics: analytics!);
    // log(observer.toString());
    return observer!;
  }

  Future<void> setScreen(String screenName) async {
    await (analytics ?? FirebaseAnalytics.instance)
        .logScreenView(screenName: screenName);
  }

  Future<void> setEvent(String name, Map<String, Object>? parameters) async {
    await (analytics ?? FirebaseAnalytics.instance).logEvent(
      name: name,
      parameters: parameters,
      callOptions: AnalyticsCallOptions(global: true),
    );
  }
}

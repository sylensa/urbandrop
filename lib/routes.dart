import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:urbandrop/features/account/business_description.dart';
import 'package:urbandrop/features/account/business_information.dart';
import 'package:urbandrop/features/account/cconfirm_password.dart';
import 'package:urbandrop/features/account/confirm_email.dart';
import 'package:urbandrop/features/account/confirm_otp.dart';
import 'package:urbandrop/features/account/forgot_password.dart';
import 'package:urbandrop/features/account/login_page.dart';
import 'package:urbandrop/features/account/register.dart';
import 'package:urbandrop/features/account/verrify_mobile.dart';
import 'package:urbandrop/features/home/home_page.dart';
import 'package:urbandrop/features/home/onboarding_page.dart';
import 'package:urbandrop/features/home/splash_screen.dart';


final rootNavigatorKey = GlobalKey<NavigatorState>();

final routerProvider = Provider<GoRouter>((ref) {

  return GoRouter(
    initialLocation: "/",
    navigatorKey: rootNavigatorKey,
    routes: [
      GoRoute(
        path: "/",
        pageBuilder: (context, state) => const NoTransitionPage(
            child: Scaffold(body: Center(child: CircularProgressIndicator()))),
        redirect: (context, state) {
          print("object");
          return Routing.splashScreen;
        },
      ),

      ShellRoute(
          builder: (context, state, child) {
            return  HomePage(childPage: child);
          },
          routes:  [
            GoRoute(
              path: Routing.splashScreen,
              pageBuilder: (context, state) =>
              const NoTransitionPage(child: SplashScreen()),
              routes: [
                GoRoute(
                  path: 'onBoarding',
                  pageBuilder: (context, state) =>
                  const NoTransitionPage(child: OnBoardingPage()),

                ),
                GoRoute(
                  path: 'registrationPage',
                  pageBuilder: (context, state) =>
                  const NoTransitionPage(child: RegistrationPage()),
                  routes: [
                    GoRoute(
                      path: 'loginPage',
                      pageBuilder: (context, state) =>
                      const NoTransitionPage(child: LoginPage()),
                      routes: [
                        GoRoute(
                          path: "forgotPasswordPage",
                          pageBuilder: (context, state) =>
                          const NoTransitionPage(child: ForgotPasswordPage()),
                        ),
                      ]
                    ),
                    GoRoute(
                      path: 'verifyMobilePage',
                      pageBuilder: (context, state) =>
                      const NoTransitionPage(child: VerifyMobilePage()),

                    ),
                    GoRoute(
                      path: 'confirmOTP',
                      pageBuilder: (context, state) =>
                      const NoTransitionPage(child: ConfirmOTP()),

                    ),
                  ]
                ),

                GoRoute(
                  path: 'businessInformationPage',
                  pageBuilder: (context, state) =>
                  const NoTransitionPage(child: BusinessInformationPage()),
                  routes: [
                    GoRoute(
                        path: 'businessDescriptionPage',
                        pageBuilder: (context, state) =>
                        const NoTransitionPage(child: BusinessDescriptionPage()),
                    ),
                  ]

                ),
                GoRoute(
                  path: 'confirmEmailPage',
                  pageBuilder: (context, state) =>
                  const NoTransitionPage(child: ConfirmEmailPage()),
                  routes: [
                    GoRoute(
                        path: 'confirmPasswordPage',
                        pageBuilder: (context, state) =>
                        const NoTransitionPage(child: ConfirmPasswordPage()),
                    ),
                  ]
                ),

              ]
            ),


          ]),


      GoRoute(
          path: Routing.forceUpdatePage,
          builder: (context, state) =>  Container()),




    ],
  );
});

class Routing {
  static const String homePage = '/';
  static const String workspacePage = '/workspace';
  static const String phoneVerificationPage = '/loginPage/resetPassword';
  static const String forceUpdatePage = '/forceUpdate';
  static const String confirmPassword = '/confirmPassword';
  static const String confirmationPage = '/confirmationPage';
  static const String splashScreen = '/splashScreen';
  static const String onBoarding = '/splashScreen/onBoarding/';
  static const String registrationPage = '/splashScreen/registrationPage/';
  static const String confirmOTP = '/splashScreen/registrationPage/confirmOTP';
  static const String loginPage = '/splashScreen/registrationPage/loginPage';
  static const String forgotPasswordPage = '/splashScreen/registrationPage/loginPage/forgotPasswordPage';
  static const String confirmEmailPage = '/splashScreen/confirmEmailPage';
  static const String confirmPasswordPage = '/splashScreen/confirmEmailPage/confirmPasswordPage';
  static const String businessInformationPage = '/splashScreen/businessInformationPage';
  static const String businessDescriptionPage = '/splashScreen/businessInformationPage/businessDescriptionPage';
  static const String verifyMobilePage = '/splashScreen/registrationPage/verifyMobilePage';

}

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
import 'package:urbandrop/features/account/selfie.dart';
import 'package:urbandrop/features/account/successful_page.dart';
import 'package:urbandrop/features/account/take_selfie.dart';
import 'package:urbandrop/features/account/upload_selfie.dart';
import 'package:urbandrop/features/account/verify_identity.dart';
import 'package:urbandrop/features/account/verrify_mobile.dart';
import 'package:urbandrop/features/account/welcome_page.dart';
import 'package:urbandrop/features/home/home_page.dart';
import 'package:urbandrop/features/account/onboarding_page.dart';
import 'package:urbandrop/features/account/splash_screen.dart';
import 'package:urbandrop/features/home/workspace.dart';
import 'package:urbandrop/features/orders/order_details.dart';
import 'package:urbandrop/features/product/add_product.dart';
import 'package:urbandrop/features/settings/account_options.dart';
import 'package:urbandrop/features/settings/contact_support.dart';
import 'package:urbandrop/features/settings/deactivate_account.dart';
import 'package:urbandrop/features/settings/delete_account.dart';
import 'package:urbandrop/features/settings/faq.dart';
import 'package:urbandrop/features/settings/notification_settings.dart';
import 'package:urbandrop/features/settings/notification_types.dart';
import 'package:urbandrop/features/settings/reset_pssword.dart';
import 'package:urbandrop/features/settings/settings_page.dart';
import 'package:urbandrop/features/settings/two_factor.dart';
import 'package:urbandrop/features/store/add_promotions_page.dart';
import 'package:urbandrop/features/store/payment_information.dart';
import 'package:urbandrop/features/store/promotions.dart';
import 'package:urbandrop/features/store/schedule.dart';
import 'package:urbandrop/features/store/update_business_info.dart';
import 'package:urbandrop/main.dart';
import 'package:urbandrop/models/product_model.dart';


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
                NoTransitionPage(child: SplashScreen(fromLogIn: state.extra == null ? false :  state.extra as bool,)),
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
                       NoTransitionPage(child: ConfirmOTP(confirmEmail: state.extra as bool,)),

                    ),
                  ]
                ),
                GoRoute(
                    path: 'successfulPage',
                    pageBuilder: (context, state) =>
                    const NoTransitionPage(child: SuccessfulPage()),
                ),
                GoRoute(
                    path: 'welcomePage',
                    pageBuilder: (context, state) =>
                    const NoTransitionPage(child: WelcomePage()),
                ),
                GoRoute(
                    path: 'workspacePage',
                    pageBuilder: (context, state) =>
                     NoTransitionPage(child: WorkspacePage()),
                      routes: [
                        GoRoute(
                          path: 'addProduct',
                          pageBuilder: (context, state) =>
                               NoTransitionPage(child: AddProduct(productData: state.extra as ProductData,)),

                        ),
                        GoRoute(
                          path: 'orderDetailsPage',
                          pageBuilder: (context, state) =>
                              const NoTransitionPage(child: OrderDetailsPage()),

                        ),
                        GoRoute(
                          path: 'updateBusinessInformationPage',
                          pageBuilder: (context, state) =>
                              const NoTransitionPage(child: UpdateBusinessInformationPage()),

                        ),
                        GoRoute(
                          path: 'schedulePage',
                          pageBuilder: (context, state) =>
                              const NoTransitionPage(child: SchedulePage()),

                        ),
                        GoRoute(
                          path: 'paymentInformation',
                          pageBuilder: (context, state) =>
                              const NoTransitionPage(child: PaymentInformation()),

                        ),
                        GoRoute(
                          path: 'promotionsPage',
                          pageBuilder: (context, state) =>
                              const NoTransitionPage(child: PromotionsPage()),
                          routes: [
                            GoRoute(
                              path: 'addPromotionsPage',
                              pageBuilder: (context, state) =>
                              const NoTransitionPage(child: AddPromotionsPage()),
                            ),
                          ]
                        ),

                        GoRoute(
                          path: 'settingsPage',
                          pageBuilder: (context, state) =>
                              const NoTransitionPage(child: SettingsPage()),
                              routes: [
                                GoRoute(
                                  path: 'resetPassword',
                                  pageBuilder: (context, state) =>
                                  const NoTransitionPage(child: ResetPassword()),

                                ),
                                GoRoute(
                                  path: 'twoFactor',
                                  pageBuilder: (context, state) =>
                                  const NoTransitionPage(child: TwoFactor()),

                                ),
                                GoRoute(
                                  path: 'contactSupportPage',
                                  pageBuilder: (context, state) =>
                                  const NoTransitionPage(child: ContactSupportPage()),

                                ),
                                GoRoute(
                                  path: 'faqPages',
                                  pageBuilder: (context, state) =>
                                  const NoTransitionPage(child: FaqPages()),

                                ),
                                GoRoute(
                                  path: 'notificationSettingPage',
                                  pageBuilder: (context, state) =>
                                  const NoTransitionPage(child: NotificationSettingPage()),

                                ),
                                GoRoute(
                                  path: 'notificationSettingTypesPage',
                                  pageBuilder: (context, state) =>
                                  const NoTransitionPage(child: NotificationSettingTypesPage()),

                                ),
                                GoRoute(
                                  path: 'accountOptionsPage',
                                  pageBuilder: (context, state) =>
                                  const NoTransitionPage(child: AccountOptionsPage()),
                                    routes: [
                                      GoRoute(
                                        path: 'deleteAccount',
                                        pageBuilder: (context, state) =>
                                        const NoTransitionPage(child: DeleteAccount()),

                                      ),
                                      GoRoute(
                                        path: 'deactivateAccount',
                                        pageBuilder: (context, state) =>
                                        const NoTransitionPage(child: DeactivateAccount()),

                                      ),
                                    ]
                                ),

                              ]
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
                          routes: [
                            GoRoute(
                              path: 'verifyIdentityPage',
                              pageBuilder: (context, state) =>
                              const NoTransitionPage(child: VerifyIdentityPage()),
                              routes: [
                                GoRoute(
                                  path: 'takeSelfiePage',
                                  pageBuilder: (context, state) =>
                                  const NoTransitionPage(child: TakeSelfiePage()),
                                  routes: [
                                    GoRoute(
                                      path: 'selfieCameraScreen',
                                      pageBuilder: (context, state) =>
                                       NoTransitionPage(child: SelfieCameraScreen(cameras: cameras,)),
                                        routes: [
                                          GoRoute(
                                            path: 'uploadSelfiePage',
                                            pageBuilder: (context, state) =>
                                                const NoTransitionPage(child: UploadSelfiePage()),


                                          ),
                                        ]

                                    ),

                                  ]

                                ),
                              ]

                            ),

                          ]
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
  static const String verifyIdentityPage = '/splashScreen/businessInformationPage/businessDescriptionPage/verifyIdentityPage';
  static const String takeSelfiePage = '/splashScreen/businessInformationPage/businessDescriptionPage/verifyIdentityPage/takeSelfiePage';
  static const String selfieCameraScreen = '/splashScreen/businessInformationPage/businessDescriptionPage/verifyIdentityPage/takeSelfiePage/selfieCameraScreen';
  static const String uploadSelfiePage = '/splashScreen/businessInformationPage/businessDescriptionPage/verifyIdentityPage/takeSelfiePage/selfieCameraScreen/uploadSelfiePage';
  static const String verifyMobilePage = '/splashScreen/registrationPage/verifyMobilePage';
  static const String welcomePage = '/splashScreen/welcomePage';
  static const String workspacePage = '/splashScreen/workspacePage';
  static const String addProduct = '/splashScreen/workspacePage/addProduct';
  static const String updateBusinessInformationPage = '/splashScreen/workspacePage/updateBusinessInformationPage';
  static const String schedulePage = '/splashScreen/workspacePage/schedulePage';
  static const String settingsPage = '/splashScreen/workspacePage/settingsPage';
  static const String resetPassword = '/splashScreen/workspacePage/settingsPage/resetPassword';
  static const String twoFactor = '/splashScreen/workspacePage/settingsPage/twoFactor';
  static const String faqPages = '/splashScreen/workspacePage/settingsPage/faqPages';
  static const String promotionsPage = '/splashScreen/workspacePage/promotionsPage';
  static const String addPromotionsPage = '/splashScreen/workspacePage/promotionsPage/addPromotionsPage';
  static const String contactSupportPage = '/splashScreen/workspacePage/settingsPage/contactSupportPage';
  static const String accountOptionsPage = '/splashScreen/workspacePage/settingsPage/accountOptionsPage';
  static const String deleteAccount = '/splashScreen/workspacePage/settingsPage/accountOptionsPage/deleteAccount';
  static const String deactivateAccount = '/splashScreen/workspacePage/settingsPage/accountOptionsPage/deactivateAccount';
  static const String notificationSettingTypesPage = '/splashScreen/workspacePage/settingsPage/notificationSettingTypesPage';
  static const String notificationSettingPage = '/splashScreen/workspacePage/settingsPage/notificationSettingPage';
  static const String paymentInformation = '/splashScreen/workspacePage/paymentInformation';
  static const String orderDetailsPage = '/splashScreen/workspacePage/orderDetailsPage';
  static const String successfulPage = '/splashScreen/successfulPage';

}

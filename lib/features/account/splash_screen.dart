import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart' hide Routing;
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:urbandrop/controllers/auth/authentication_controller.dart';
import 'package:urbandrop/controllers/notifications/notification_controller.dart';
import 'package:urbandrop/controllers/shared_preference.dart';
import 'package:urbandrop/core/helper/helper.dart';
import 'package:urbandrop/core/network/request_interceptor.dart';
import 'package:urbandrop/core/utils/colors_utils.dart';
import 'package:urbandrop/main.dart';
import 'package:urbandrop/routes.dart';

class SplashScreen extends ConsumerStatefulWidget {
  const SplashScreen({super.key});

  @override
  ConsumerState<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends ConsumerState<SplashScreen> {

  bool loading = true;
  pageRedirect() async{
    try{
      Get.reset();
      userInstance = await UserPreferences().getUser();
      await AuthenticationController().getUserConfig();
      if(userInstance != null){
          userInstance =  await AuthenticationController().user();
        if(userInstance == null){
          context.go(Routing.loginPage);
        }else{
          if (!userInstance!.emailVerified!) {
            context.go(Routing.confirmOTP,extra: true);
          }
          else if (!userInstance!.mobileNumberVerified!) {
            context.go(Routing.verifyMobilePage);
          }
          else if (userInstance!.businessName!.isEmpty) {
            context.go(Routing.businessInformationPage);
          } else if (userInstance!.businessDescription!.isEmpty) {
            context.go(Routing.businessDescriptionPage);
          }
          else if (!userInstance!.documentSubmitted!) {
            context.go(Routing.verifyIdentityPage);
          }
          else if(userInstance!.active! && userInstance!.emailVerified! && userInstance!.mobileNumberVerified!){
            context.go(Routing.workspacePage);
          }
        }
      }
      else{
        context.go(Routing.loginPage);
      }
    }
    catch(e){
      print("error:${e.toString()}");
      context.pop();
    }

    setState(() {
      print("loading:$loading");
    });
  }
  @override
  void initState() {
    super.initState();

    Future.delayed(const Duration(seconds: 3),()async{
      await NotificationController(context: context).initialise();
      await NotificationController(context: context).initialize();
      NotificationController(context: context).requestPermissions();
      await pageRedirect();


    });

  }
  @override
  Widget build(BuildContext context) {
    container.listen(isAuthorizedProvider, (previous, next) {
      print("next:${next}");
      if (!next) {
        ref.read(isLoggedInProvider.notifier).state = next;
      }

    });
    ref.listen(isLoggedInProvider, (previous, next) {
      print("ref:${next}");
      if(!next){
        print("isLoggedIn:${next}");
        context.go(Routing.registrationPage);
      }
    });
    return  Container(
      color: primaryColor,
      child:  Padding(
        padding: const EdgeInsets.only(bottom: 50),
        child: Stack(
          alignment: Alignment.center,
          children: [
            Image.asset("assets/images/splash_logo.png",color: Colors.white,width: 200,),

            Padding(
              padding: const EdgeInsets.only(top: 240),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  sText("Merchant",weight: FontWeight.w900,size: 30,color: Colors.white),
                  SizedBox(height: 20,),
                  progress(size: 30),
                ],
              ),
            )

          ],
        ),
      ),
    );
  }
}

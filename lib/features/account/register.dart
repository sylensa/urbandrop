import 'package:email_validator/email_validator.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:go_router/go_router.dart';
import 'package:urbandrop/controllers/auth/authentication_controller.dart';
import 'package:urbandrop/core/helper/helper.dart';
import 'package:urbandrop/core/utils/colors_utils.dart';
import 'package:urbandrop/features/widget/custom_text_field.dart';
import 'package:urbandrop/features/widget/social_login_widgets.dart';
import 'package:urbandrop/routes.dart';

class RegistrationPage extends StatefulWidget {
  const RegistrationPage({super.key});

  @override
  State<RegistrationPage> createState() => _RegistrationPageState();
}

class _RegistrationPageState extends State<RegistrationPage> {
  AuthenticationController authenticationController = AuthenticationController();
  GlobalKey<ScaffoldState> scaffoldKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      key: scaffoldKey,
      body: Column(
        children: [
          Container(
            padding: const EdgeInsets.only(top: 50),
            width: appWidth(context),
            color: primaryColor,
            child: Column(
              children: [
                sText("Welcome to Urbandrop",size: 24,weight: FontWeight.w900,color: Colors.white),
                const SizedBox(height: 5,),
                sText("Your gateway to sharing the richness of African flavors. ",size: 12,weight: FontWeight.w400,color: Colors.white),
                Image.asset("assets/images/splash_logo.png",color: Colors.white,height: 200,),
              ],
            ),
          ),
          const SizedBox(height: 20,),
          Expanded(
            child: ListView(
              padding: EdgeInsets.zero,
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: sText("Sign Up as merchant",size: 20,weight: FontWeight.w700),
                ),
                const SizedBox(height: 20,),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: CustomTextField(
                    placeholder: "Email",
                    prefixImage: "email.png",
                    onChange: (value){
                      setState(() {
                        authenticationController.emailValid = EmailValidator.validate(value);
                        authenticationController.email = value;
                      });
                    },
                  ),
                ),
                const SizedBox(height: 20,),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: CustomTextField(
                    placeholder: "Password",
                    prefixImage: "lock.png",
                    obscureText: true,
                    onChange: (value){
                      setState(() {
                        authenticationController.password = value;
                      });
                    },
                  ),
                ),
                const SizedBox(height: 20,),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: CustomTextField(
                    placeholder: "Confirm Password",
                    prefixImage: "lock.png",
                    obscureText: true,
                    onChange: (value){
                      setState(() {
                        authenticationController.verifyPassword = value;
                      });
                    },
                  ),
                ),
                const SizedBox(height: 20,),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: sText("By signing up as a UrbanDrop merchant, you acknowledge that you agree to abide "
                      "by the terms and conditions. Welcome to the Urbandrop community!",size: 12),
                ),
                const SizedBox(height: 20,),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: mainButton(
                      content: sText("Sign Up",color: Colors.white,size: 18,weight: FontWeight.w600),
                      backgroundColor: primaryColor,
                      shadowStrength: 0,
                      height: 50,
                      radius: 30,
                      onPressed: (){
                        context.push(Routing.verifyMobilePage);
                      }),
                ),
                const SizedBox(height: 20,),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Row(
                    children: [
                      Expanded(
                        child: Container(
                          color: Colors.grey[300],
                          height: 1,
                        ),
                      ),
                      sText(" OR ",color: Colors.grey[400]!,size: 12),
                      Expanded(
                        child: Container(
                          color: Colors.grey[300],
                          height: 1,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 20,),
                SocialLoginWidget(
                  title: "Sign up with Google",
                  image: "assets/images/google.png",
                  onTap: () async{
                    // await AuthenticationController().signInWithGoogle(context,scaffoldKey,isLoggedIn: false);


                  },
                ),
                const SizedBox(
                  height: 20,
                ),
                SocialLoginWidget(
                  title: "Sign up with Apple",
                  image: "assets/images/apple.png",
                  onTap: () async{
                    // await AuthenticationController().appleLogin(context,scaffoldKey,isLoggedIn: false);
                  },
                ),
                const SizedBox(height: 10,),
                GestureDetector(
                  onTap: (){
                      context.go(Routing.loginPage);
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      sText("Already have an account? "),
                      sText("Sign In",color: primaryColor,weight: FontWeight.bold),
                    ],
                  ),
                ),
                const SizedBox(height: 40,),

              ],
            ),
          )
        ],
      ),
    );
  }
}

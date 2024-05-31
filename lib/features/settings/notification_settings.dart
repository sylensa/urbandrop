import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:urbandrop/controllers/auth/authentication_controller.dart';
import 'package:urbandrop/core/helper/helper.dart';
import 'package:urbandrop/core/utils/colors_utils.dart';
import 'package:urbandrop/features/widget/custom_text_field.dart';
import 'package:urbandrop/features/widget/flutter_switch.dart';
import 'package:urbandrop/features/widget/store_widget.dart';
import 'package:urbandrop/routes.dart';

class NotificationSettingPage extends StatefulWidget {
  const NotificationSettingPage({super.key});

  @override
  State<NotificationSettingPage> createState() => _NotificationSettingPageState();
}

class _NotificationSettingPageState extends State<NotificationSettingPage> {
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: sText("Notifications",size: 15,weight: FontWeight.w600),
        centerTitle: true,
        elevation: 1,
        backgroundColor: Colors.white,
      ),
      body: Container(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: ListView(
                  padding: const EdgeInsets.symmetric(horizontal: 0,vertical: 20),
                  children:[
                    StoreWidget(
                      image: "email_noti.png",
                      content: "Email notifications ",
                      onTap: (){
                      },
                      icon:   OnAndOffSwitch(
                        padding: 2,
                        height: 25,
                        width: 50,
                        toggleSize: 20,
                        toggleColor: Colors.white,
                        activeColor: primaryColor,
                        onToggle: (val) async{
                          userInstance?.notifications?.email =val;
                          setState(() {});
                          await AuthenticationController().update(context,{
                            "notifications":userInstance?.notifications!.toJson()
                          });
                        },
                        value: userInstance?.notifications?.email == true ? true  : false,
                      ),
                    ),
                    // const SizedBox(height: 20,),
                    // StoreWidget(
                    //   image: "inapp.png",
                    //   content: "In-App notifications ",
                    //   onTap: (){
                    //     context.push(Routing.resetPassword);
                    //   },
                    //   icon:   OnAndOffSwitch(
                    //     padding: 2,
                    //     height: 25,
                    //     width: 50,
                    //     toggleSize: 20,
                    //     toggleColor: Colors.white,
                    //     activeColor: primaryColor,
                    //     onToggle: (val) {
                    //     },
                    //     value: true,
                    //   ),
                    // ),
                    const SizedBox(height: 20,),
                    StoreWidget(
                      image: "notification.png",
                      content: "Push notifications ",
                      onTap: (){
                      },
                      icon:   OnAndOffSwitch(
                        padding: 2,
                        height: 25,
                        width: 50,
                        toggleSize: 20,
                        toggleColor: Colors.white,
                        activeColor: primaryColor,
                        onToggle: (val) async{
                          userInstance?.notifications?.push =val;
                          setState(() {});
                          await AuthenticationController().update(context,{
                            "notifications":userInstance?.notifications!.toJson()
                          });
                        },
                        value: userInstance?.notifications?.push == true ? true  : false,
                      ),
                    ),
                    const SizedBox(height: 20,),
                    StoreWidget(
                      image: "sms.png",
                      content: "SMS notifications ",
                      onTap: (){},
                      icon:   OnAndOffSwitch(
                        padding: 2,
                        height: 25,
                        width: 50,
                        toggleSize: 20,
                        toggleColor: Colors.white,
                        activeColor: primaryColor,
                        onToggle: (val) async{
                          userInstance?.notifications?.sms = val;
                          setState(() {});
                          await AuthenticationController().update(context,{
                            "notifications":userInstance?.notifications!.toJson()
                          });
                        },
                        value: userInstance?.notifications?.sms == true ? true  : false,
                      ),
                    ),
                    const SizedBox(height: 20,),
                  ]
              ),
            )
          ],
        ),
      ),
    );
  }
}

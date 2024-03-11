import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:urbandrop/core/helper/helper.dart';
import 'package:urbandrop/core/utils/colors_utils.dart';
import 'package:urbandrop/features/widget/custom_text_field.dart';
import 'package:urbandrop/features/widget/store_widget.dart';
import 'package:urbandrop/routes.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({super.key});

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: sText("Settings",size: 15,weight: FontWeight.w600),
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
                    sText("Security settings",size: 20,weight: FontWeight.w600),
                    SizedBox(height: 20,),
                    StoreWidget(
                      image: "change_password.png",
                      content: "Change password ",
                      onTap: (){
                        context.push(Routing.resetPassword);
                      },
                    ),
                    const SizedBox(height: 20,),
                    StoreWidget(
                      image: "2factorr.png",
                      content: "Two-Factor Authentication (2FA)",
                      onTap: (){
                        context.push(Routing.twoFactor);
                      },
                    ),
                    const SizedBox(height: 20,),
                    Divider(),
                    const SizedBox(height: 20,),


                    sText("Notification Preferences",size: 20,weight: FontWeight.w600),
                    SizedBox(height: 20,),
                    StoreWidget(
                      image: "channels.png",
                      content: "Communication channels",
                      onTap: (){
                        context.push(Routing.notificationSettingPage);
                      },
                    ),
                    const SizedBox(height: 20,),
                    StoreWidget(
                      image: "notifications.png",
                      content: "Notification types",
                      onTap: (){
                        context.push(Routing.notificationSettingTypesPage);

                      },
                    ),
                    const SizedBox(height: 20,),
                    Divider(),
                    const SizedBox(height: 20,),
                    sText("Help and Support",size: 20,weight: FontWeight.w600),
                    SizedBox(height: 20,),
                    StoreWidget(
                      image: "infos.png",
                      content: "FAQs",
                      onTap: (){
                        context.push(Routing.faqPages);
                      },
                    ),
                    const SizedBox(height: 20,),
                    StoreWidget(
                      image: "support.png",
                      content: "Contact support",
                      onTap: (){
                        context.push(Routing.contactSupportPage);

                      },
                    ),
                    const SizedBox(height: 20,),
                    Divider(),
                    const SizedBox(height: 20,),
                    sText("Terms and Conditions",size: 20,weight: FontWeight.w600),
                    SizedBox(height: 20,),
                    StoreWidget(
                      image: "terms.png",
                      content: "Read and accept",
                      onTap: (){
                      },
                    ),
                    const SizedBox(height: 20,),
                    Divider(),

                    const SizedBox(height: 20,),
                    sText("Account Option",size: 20,weight: FontWeight.w600),
                    SizedBox(height: 20,),
                    StoreWidget(
                      image: "options.png",
                      content: "Delete / Deactivate account",
                      onTap: (){
                        context.push(Routing.accountOptionsPage);
                      },
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

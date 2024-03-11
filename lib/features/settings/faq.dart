import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:urbandrop/core/helper/helper.dart';
import 'package:urbandrop/core/utils/colors_utils.dart';
import 'package:urbandrop/features/widget/bottomsheet_ex.dart';
import 'package:urbandrop/features/widget/custom_text_field.dart';
import 'package:urbandrop/features/widget/delete_account_sheet.dart';
import 'package:urbandrop/features/widget/radio_text_widget.dart';

class FaqPages extends StatefulWidget {
  const FaqPages({super.key});

  @override
  State<FaqPages> createState() => _FaqPagesState();
}

class _FaqPagesState extends State<FaqPages> {

  @override
  Widget build(BuildContext context) {

    return  Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: sText("FAQs",size: 15,weight: FontWeight.w600),
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
                padding: const EdgeInsets.symmetric(horizontal: 0),
                children:  [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Theme(
                        data: Theme.of(context).copyWith(dividerColor: Colors.transparent),
                        child: ExpansionTile(
                          childrenPadding: EdgeInsets.zero,
                          tilePadding: EdgeInsets.zero,
                          collapsedIconColor: Colors.black,
                          collapsedTextColor: Colors.black,
                          iconColor: Colors.black,
                          textColor: Colors.black,
                          onExpansionChanged: (value){

                          },


                          title: sText("1. How do I sign up as a merchant on Urbandrop?",size: 15,weight: FontWeight.w500),
                          children:  <Widget>[
                            const SizedBox(height: 20,),
                            sText("To sign up as a merchant on Urbandrop, simply download the Urbandrop Merchant "
                                "App from the App Store or Google Play Store. Follow the on-screen instructions to "
                                "create your account, providing necessary business information, such as your business name, "
                                "email address, and password. Once your account is set up, you can start showcasing your products "
                                "and managing your online store.",size: 12,weight: FontWeight.w400),
                          ],
                        ),
                      ),
                      const Divider()
                    ],
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Theme(
                        data: Theme.of(context).copyWith(dividerColor: Colors.transparent),
                        child: ExpansionTile(
                          childrenPadding: EdgeInsets.zero,
                          tilePadding: EdgeInsets.zero,
                          collapsedIconColor: Colors.black,
                          collapsedTextColor: Colors.black,
                          iconColor: Colors.black,
                          textColor: Colors.black,
                          onExpansionChanged: (value){

                          },


                          title: sText("2. How can I update my menu or add new dishes?",size: 15,weight: FontWeight.w500),
                          children:  <Widget>[
                            const SizedBox(height: 20,),
                            sText("To sign up as a merchant on Urbandrop, simply download the Urbandrop Merchant "
                                "App from the App Store or Google Play Store. Follow the on-screen instructions to "
                                "create your account, providing necessary business information, such as your business name, "
                                "email address, and password. Once your account is set up, you can start showcasing your products "
                                "and managing your online store.",size: 12,weight: FontWeight.w400),
                          ],
                        ),
                      ),
                      const Divider()
                    ],
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Theme(
                        data: Theme.of(context).copyWith(dividerColor: Colors.transparent),
                        child: ExpansionTile(
                          childrenPadding: EdgeInsets.zero,
                          tilePadding: EdgeInsets.zero,
                          collapsedIconColor: Colors.black,
                          collapsedTextColor: Colors.black,
                          iconColor: Colors.black,
                          textColor: Colors.black,
                          onExpansionChanged: (value){

                          },


                          title: sText("3. What are the delivery options available for my customers?",size: 15,weight: FontWeight.w500),
                          children:  <Widget>[
                            const SizedBox(height: 20,),
                            sText("To sign up as a merchant on Urbandrop, simply download the Urbandrop Merchant "
                                "App from the App Store or Google Play Store. Follow the on-screen instructions to "
                                "create your account, providing necessary business information, such as your business name, "
                                "email address, and password. Once your account is set up, you can start showcasing your products "
                                "and managing your online store.",size: 12,weight: FontWeight.w400),
                          ],
                        ),
                      ),
                    ],
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Theme(
                        data: Theme.of(context).copyWith(dividerColor: Colors.transparent),
                        child: ExpansionTile(
                          childrenPadding: EdgeInsets.zero,
                          tilePadding: EdgeInsets.zero,
                          collapsedIconColor: Colors.black,
                          collapsedTextColor: Colors.black,
                          iconColor: Colors.black,
                          textColor: Colors.black,
                          onExpansionChanged: (value){

                          },


                          title: sText("4. How do I track and manage incoming orders?",size: 15,weight: FontWeight.w500),
                          children:  <Widget>[
                            const SizedBox(height: 20,),
                            sText("To sign up as a merchant on Urbandrop, simply download the Urbandrop Merchant "
                                "App from the App Store or Google Play Store. Follow the on-screen instructions to "
                                "create your account, providing necessary business information, such as your business name, "
                                "email address, and password. Once your account is set up, you can start showcasing your products "
                                "and managing your online store.",size: 12,weight: FontWeight.w400),
                          ],
                        ),
                      ),
                      const Divider()
                    ],
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Theme(
                        data: Theme.of(context).copyWith(dividerColor: Colors.transparent),
                        child: ExpansionTile(
                          childrenPadding: EdgeInsets.zero,
                          tilePadding: EdgeInsets.zero,
                          collapsedIconColor: Colors.black,
                          collapsedTextColor: Colors.black,
                          iconColor: Colors.black,
                          textColor: Colors.black,
                          onExpansionChanged: (value){

                          },


                          title: sText("5. What payment methods are supported on Urbandrop?",size: 15,weight: FontWeight.w500),
                          children:  <Widget>[
                            const SizedBox(height: 20,),
                            sText("To sign up as a merchant on Urbandrop, simply download the Urbandrop Merchant "
                                "App from the App Store or Google Play Store. Follow the on-screen instructions to "
                                "create your account, providing necessary business information, such as your business name, "
                                "email address, and password. Once your account is set up, you can start showcasing your products "
                                "and managing your online store.",size: 12,weight: FontWeight.w400),
                          ],
                        ),
                      ),
                      const Divider()
                    ],
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Theme(
                        data: Theme.of(context).copyWith(dividerColor: Colors.transparent),
                        child: ExpansionTile(
                          childrenPadding: EdgeInsets.zero,
                          tilePadding: EdgeInsets.zero,
                          collapsedIconColor: Colors.black,
                          collapsedTextColor: Colors.black,
                          iconColor: Colors.black,
                          textColor: Colors.black,
                          onExpansionChanged: (value){

                          },


                          title: sText("6. How can I customize my storefront to reflect my brand identity?",size: 15,weight: FontWeight.w500),
                          children:  <Widget>[
                            const SizedBox(height: 20,),
                            sText("To sign up as a merchant on Urbandrop, simply download the Urbandrop Merchant "
                                "App from the App Store or Google Play Store. Follow the on-screen instructions to "
                                "create your account, providing necessary business information, such as your business name, "
                                "email address, and password. Once your account is set up, you can start showcasing your products "
                                "and managing your online store.",size: 12,weight: FontWeight.w400),
                          ],
                        ),
                      ),
                      const Divider()
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20,),


          ],
        ),
      ),
    );
  }
}

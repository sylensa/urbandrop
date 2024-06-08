import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:go_router/go_router.dart';
import 'package:urbandrop/core/helper/helper.dart';
import 'package:urbandrop/core/utils/colors_utils.dart';
import 'package:urbandrop/features/widget/custom_text_field.dart';
import 'package:urbandrop/features/widget/recent_order_widget.dart';
import 'package:urbandrop/features/widget/tab_bar_slider.dart';
import 'package:urbandrop/routes.dart';

class SchedulePage extends StatefulWidget {
  const SchedulePage({super.key});

  @override
  State<SchedulePage> createState() => _SchedulePageState();
}

class _SchedulePageState extends State<SchedulePage> {
  List<String> myTabs = <String> [
   "Monday",
   "Tuesday",
   "Wednesday",
   "Thursday",
   "Friday",
   "Saturday",
   "Sunday",
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: sText("Opening and Closing time",size: 15,weight: FontWeight.w600),
        centerTitle: true,
        elevation: 1,
        backgroundColor: Colors.white,
      ),
      body: Container(
        padding: const EdgeInsets.only(top: 20,left: 0,right: 0,bottom: 20),
        child:  Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: 30,
              child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: myTabs.length,
                  itemBuilder: (context,index){
                    return Padding(
                      padding: const EdgeInsets.only(left: 20),
                      child: Row(
                        children: [
                          mainButton(
                              width: 120,
                              height: 30,
                              radius: 30,
                              outlineColor: Colors.transparent,
                              shadowStrength: 0,
                              backgroundColor: primaryColor,
                              content:  sText(myTabs[index],color: Colors.white,weight: FontWeight.w600,size: 12),
                              onPressed:(){
                              }),

                        ],
                      ),
                    );
                  }),
            ),
            SizedBox(height: 40,),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: sText("Opening time",size: 12,weight: FontWeight.w600),
            ),
            SizedBox(height: 20,),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Row(
                children: [
                  Expanded(
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 20,vertical: 17),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(30),
                        border: Border.all(color: const Color(0XFF1F546033)),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          sText("Pick time",color: Color(0xFF879EA4)),
                          const Icon(Icons.keyboard_arrow_down,color: Color(0XFF879EA4),)
                        ],
                      ),
                    ),
                  ),
                  SizedBox(width: 10,),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 20,vertical: 17),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(30),
                      border: Border.all(color: const Color(0XFF1F546033)),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        sText("am/pm",color: Color(0xFF879EA4)),
                        const Icon(Icons.keyboard_arrow_down,color: Color(0XFF879EA4),)
                      ],
                    ),
                  ),
                ],
              ),
            ),


            SizedBox(height: 40,),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: sText("Closing time",size: 12,weight: FontWeight.w600),
            ),
            SizedBox(height: 20,),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Row(
                children: [
                  Expanded(
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 20,vertical: 17),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(30),
                        border: Border.all(color: const Color(0XFF1F546033)),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          sText("Pick time",color: Color(0xFF879EA4)),
                          const Icon(Icons.keyboard_arrow_down,color: Color(0XFF879EA4),)
                        ],
                      ),
                    ),
                  ),
                  SizedBox(width: 10,),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 20,vertical: 17),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(30),
                      border: Border.all(color: const Color(0XFF1F546033)),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        sText("am/pm",color: Color(0xFF879EA4)),
                        const Icon(Icons.keyboard_arrow_down,color: Color(0XFF879EA4),)
                      ],
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 40,),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: mainButton(
                  content: sText("Save",color: Colors.white,size: 18,weight: FontWeight.w600),
                  backgroundColor: primaryColor,
                  shadowStrength: 0,
                  height: 50,
                  radius: 30,
                  onPressed: (){
                  }),
            ),
            const SizedBox(height: 20,),
          ],
        ),
      ),
    );
  }
}




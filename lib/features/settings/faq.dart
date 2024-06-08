import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:urbandrop/controllers/auth/authentication_controller.dart';
import 'package:urbandrop/controllers/dashboard/dashboard_controller.dart';
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
  AuthenticationController authenticationController = AuthenticationController();
  bool loading = true;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    final stateDashboard = Get.put(DashboardController());
    Future.delayed(Duration(seconds: 0),()async{
      if(stateDashboard.listFaqData.value!.isEmpty){
        await authenticationController.getFaq();
      }
      setState(() {
        loading = false;
      });

    });
  }
  @override
  Widget build(BuildContext context) {
    final stateDashboard = Get.put(DashboardController());
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
            stateDashboard.listFaqData.value!.isNotEmpty ?
            Expanded(
              child: ListView.builder(
                itemCount: stateDashboard.listFaqData.value!.length,
                  itemBuilder: (context,index){
                  return   Column(
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


                          title: sText("${index + 1}. ${stateDashboard.listFaqData.value![index].question}",size: 15,weight: FontWeight.w500),
                          children:  <Widget>[
                            Row(
                              children: [
                                sText("${stateDashboard.listFaqData.value![index].answer}",size: 12,weight: FontWeight.w400,align: TextAlign.left),
                              ],
                            ),
                            const SizedBox(height: 20,),
                          ],
                        ),
                      ),
                      const Divider()
                    ],
                  );
              }),
            ) : loading ? Expanded(child: Center(child: progress(),)) : Expanded(child: Center(child: sText("No records"),)),
            const SizedBox(height: 20,),
          ],
        ),
      ),
    );
  }
}

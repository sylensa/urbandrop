import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:urbandrop/controllers/auth/authentication_controller.dart';
import 'package:urbandrop/controllers/config/faq_controller.dart';
import 'package:urbandrop/controllers/dashboard/dashboard_controller.dart';
import 'package:urbandrop/core/helper/helper.dart';
import 'package:urbandrop/core/utils/colors_utils.dart';
import 'package:urbandrop/cubit_state/faq_state.dart';


class FaqPages extends StatefulWidget {
  const FaqPages({super.key});

  @override
  State<FaqPages> createState() => _FaqPagesState();
}

class _FaqPagesState extends State<FaqPages> {
  AuthenticationController authenticationController = AuthenticationController();
  bool loading = true;
  late FaqController faqController;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    faqController = context.read<FaqController>();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp)async {
      faqController.getFaq();
      setState(() {

      });
    });
  }
  @override
  Widget build(BuildContext context) {
    return  BlocBuilder<FaqController,FaqState>(builder: (context,state){
      return Scaffold(
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
              if(state is FaqLoaded)
              Expanded(
                child: ListView.builder(
                    itemCount: state.listFaqData.length,
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


                              title: sText("${index + 1}. ${state.listFaqData[index].question}",size: 15,weight: FontWeight.w500),
                              children:  <Widget>[
                                Row(
                                  children: [
                                    sText("${state.listFaqData[index].answer}",size: 12,weight: FontWeight.w400,align: TextAlign.left),
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
              ) ,
              if(state is FaqInitial)
              Expanded(child: Center(child: progress(),)),
              if(state is FaqEmpty)
              Expanded(child: Center(child: sText("No records"),)),
              const SizedBox(height: 20,),
            ],
          ),
        ),
      );
    });
  }
}

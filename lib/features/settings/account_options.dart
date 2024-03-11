import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:urbandrop/core/helper/helper.dart';
import 'package:urbandrop/core/utils/colors_utils.dart';
import 'package:urbandrop/features/widget/custom_text_field.dart';
import 'package:urbandrop/features/widget/store_widget.dart';
import 'package:urbandrop/routes.dart';

class AccountOptionsPage extends StatefulWidget {
  const AccountOptionsPage({super.key});

  @override
  State<AccountOptionsPage> createState() => _AccountOptionsPageState();
}

class _AccountOptionsPageState extends State<AccountOptionsPage> {
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: sText("Account Options",size: 15,weight: FontWeight.w600),
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
                      image: "options.png",
                      content: "Deactivate Account",
                      onTap: (){
                        context.push(Routing.deactivateAccount);
                      },
                    ),
                    const SizedBox(height: 20,),
                    StoreWidget(
                      image: "delete.png",
                      content: "Delete Account",
                      onTap: (){
                        context.push(Routing.deleteAccount);
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

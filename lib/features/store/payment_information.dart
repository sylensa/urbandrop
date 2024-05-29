import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:urbandrop/controllers/auth/authentication_controller.dart';
import 'package:urbandrop/core/helper/helper.dart';
import 'package:urbandrop/core/utils/colors_utils.dart';
import 'package:urbandrop/features/widget/custom_text_field.dart';

class PaymentInformation extends StatefulWidget {
  const PaymentInformation({super.key});

  @override
  State<PaymentInformation> createState() => _PaymentInformationState();
}

class _PaymentInformationState extends State<PaymentInformation> {
  final AuthenticationController authenticationController = AuthenticationController();
  final TextEditingController accountName = TextEditingController();
  final TextEditingController accountNumber = TextEditingController();
  final TextEditingController sortCode = TextEditingController();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    accountName.text = userInstance?.accountName ?? "";
    authenticationController.accountName = userInstance?.accountName ?? "";
    accountNumber.text = userInstance?.accountNumber ?? "";
    authenticationController.accountNumber = userInstance?.accountNumber ?? "";
    sortCode.text = userInstance?.sortCode ?? "";
    authenticationController.sortCode = userInstance?.sortCode ?? "";

  }
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: sText("Payment information",size: 15,weight: FontWeight.w600),
        centerTitle: true,
        elevation: 1,
        backgroundColor: Colors.white,
      ),
      body: GestureDetector(
        onTap: (){
          FocusScope.of(context).unfocus();
        },
        child: Container(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: ListView(
                  padding: EdgeInsets.zero,
                  children: [
                    const SizedBox(height: 20,),
                    CustomTextField(
                      placeholder: "Account Name",
                      controller: accountName,
                      onChange: (value){
                        setState(() {
                          authenticationController.accountName = value;
                        });
                      },
                    ),
                    const SizedBox(height: 20,),
                    CustomTextField(
                      placeholder: "Account number",
                      keyboardType: TextInputType.number,
                      controller: accountNumber,
                      onChange: (value){
                        setState(() {
                          authenticationController.accountNumber = value;
                        });
                      },
                    ),
                    const SizedBox(height: 20,),
                    CustomTextField(
                      controller: sortCode,
                      keyboardType: TextInputType.number,
                      placeholder: "Sort code",
                      onChange: (value){
                        setState(() {
                          authenticationController.sortCode = value;
                        });
                      },
                    ),

                    const SizedBox(height: 40,),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 0),
                      child: mainButton(
                          content: sText("Save",color: Colors.white,size: 18,weight: FontWeight.w600),
                          backgroundColor: authenticationController.paymentEmptyFields() ? primaryColor : Colors.grey[400]!,
                          shadowStrength: 0,
                          height: 50,
                          radius: 30,
                          onPressed: ()async{
                           try{
                             if(authenticationController.paymentEmptyFields()){
                               showLoaderDialog(context);
                               final response = await authenticationController.update(context,
                                   {
                                     "account_name":authenticationController.accountName.trim(),
                                     "account_number":authenticationController.accountNumber.trim(),
                                     "sort_code":authenticationController.sortCode.trim(),
                                   });
                               if(response){
                                 context.pop();
                                 toastSuccessMessage("Information saved successfully", context);
                               }else{
                                 context.pop();
                               }

                             }else{
                               toastMessage(authenticationController.errorMessage, context);
                             }
                           }catch(e){
                             context.pop();
                             toastMessage(e.toString(), context);
                           }
                          }),
                    ),
                    const SizedBox(height: 20,),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

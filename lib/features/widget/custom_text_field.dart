import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:urbandrop/controllers/shared_preference.dart';
import 'package:urbandrop/core/utils/colors_utils.dart';

class CustomTextField extends StatefulWidget {
  final String placeholder;
   bool? obscureText;
  final bool? checkMark;
  final String? prefixImage;
  final int? maxLines;
  final TextDirection? textDirection;
  final List<TextInputFormatter> inputFormatters;
  final TextEditingController? controller;
  final ValueChanged<String>? onChange;
  final ValueChanged<String>? onSubmit;

   CustomTextField({Key? key, required this.placeholder, this.onChange, this.obscureText,this.onSubmit, this.controller,this.inputFormatters = const[], this.checkMark,this.textDirection = TextDirection.ltr , this.prefixImage, this.maxLines})
      : super(key: key);

  @override
  State<CustomTextField> createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {
  String languageCode = "";
  @override
  void initState() {
    // TODO: implement initState
    super.initState();

  }
  @override
  Widget build(BuildContext context) {
    return CupertinoTextField(
      textDirection:widget.textDirection,
      controller: widget.controller,
      onChanged: widget.onChange,
      onSubmitted: widget.onSubmit,
      prefix: widget.prefixImage != null ?
      Padding(
        padding: const EdgeInsets.only(left: 20),
        child: Image.asset("assets/images/${widget.prefixImage}",width: 20,height: 20,),
      ) : const SizedBox.shrink(),
      padding: const EdgeInsets.all(20),
      placeholder: widget.placeholder,
      inputFormatters:widget.inputFormatters ,
      obscureText: widget.obscureText ?? false,
      placeholderStyle: const TextStyle(
        color: Color(0xFF879EA4),
        fontSize: 16,
      ),
      // textAlign: TextAlign.center,
      style: const TextStyle(
        fontSize: 16,
        fontWeight: FontWeight.w400,

      ),
      decoration: BoxDecoration(
        color:  Colors.white,
        borderRadius: BorderRadius.circular(30),
        border: Border.all(color: const Color(0XFF1F546033)),
      ),
      suffix:
      widget.obscureText != null ?
        InkWell(
          splashColor: Colors.transparent,
          onTap: (){
            setState(() {
              widget.obscureText = !widget.obscureText!;
            });
          },
          child: Padding(
          padding: const EdgeInsets.all(20),
          child: Icon(widget.obscureText! ? Icons.visibility_off :Icons.visibility  ,color: const Color(0xFF879EA4),),
                ),
        ) : const SizedBox.shrink()
      ,
    );
  }
}


class CustomDescriptionField extends StatefulWidget {
  final String placeholder;
  bool? obscureText;
  final bool? checkMark;
  final String? prefixImage;
  final int? maxLines;
  final TextDirection? textDirection;
  final List<TextInputFormatter> inputFormatters;
  final TextEditingController? controller;
  final ValueChanged<String>? onChange;
  final ValueChanged<String>? onSubmit;

  CustomDescriptionField({Key? key, required this.placeholder, this.onChange, this.obscureText,this.onSubmit, this.controller,this.inputFormatters = const[], this.checkMark,this.textDirection = TextDirection.ltr , this.prefixImage, this.maxLines})
      : super(key: key);

  @override
  State<CustomDescriptionField> createState() => _CustomDescriptionFieldState();
}

class _CustomDescriptionFieldState extends State<CustomDescriptionField> {
  String languageCode = "";
  @override
  void initState() {
    // TODO: implement initState
    super.initState();

  }
  @override
  Widget build(BuildContext context) {
    return CupertinoTextField(
      textDirection:widget.textDirection,
      controller: widget.controller,
      onChanged: widget.onChange,
      maxLength: 150,
      onSubmitted: widget.onSubmit,
      textAlignVertical: TextAlignVertical.top,
      prefix: widget.prefixImage != null ?
      Padding(
        padding: const EdgeInsets.only(left: 20),
        child: Image.asset("assets/images/${widget.prefixImage}",width: 20,height: 20,),
      ) : const SizedBox.shrink(),
      padding: const EdgeInsets.all(20),
      placeholder: widget.placeholder,
      inputFormatters:widget.inputFormatters ,
      placeholderStyle: const TextStyle(
        color: Color(0xFF879EA4),
        fontSize: 16,
      ),
      // textAlign: TextAlign.center,
      style: const TextStyle(
        fontSize: 16,
        fontWeight: FontWeight.w400,

      ),
      decoration: BoxDecoration(
        color:  Colors.white,
        borderRadius: BorderRadius.circular(30),
        border: Border.all(color: const Color(0XFF1F546033)),
      ),
    );
  }
}



class CustomTextSearchField extends StatefulWidget {
  final String placeholder;
  bool? obscureText;
  final bool? checkMark;
  final String? prefixImage;
  final int? maxLines;
  final TextDirection? textDirection;
  final List<TextInputFormatter> inputFormatters;
  final TextEditingController? controller;
  final ValueChanged<String>? onChange;
  final ValueChanged<String>? onSubmit;

  CustomTextSearchField({Key? key, required this.placeholder, this.onChange, this.obscureText,this.onSubmit, this.controller,this.inputFormatters = const[], this.checkMark,this.textDirection = TextDirection.ltr , this.prefixImage, this.maxLines})
      : super(key: key);

  @override
  State<CustomTextSearchField> createState() => _CustomTextSearchFieldState();
}

class _CustomTextSearchFieldState extends State<CustomTextSearchField> {
  String languageCode = "";
  @override
  void initState() {
    // TODO: implement initState
    super.initState();

  }
  @override
  Widget build(BuildContext context) {
    return CupertinoTextField(
      textDirection:widget.textDirection,
      controller: widget.controller,
      onChanged: widget.onChange,
      onSubmitted: widget.onSubmit,
      prefix: widget.prefixImage != null ?
      Padding(
        padding: const EdgeInsets.only(left: 20),
        child: Image.asset("assets/images/${widget.prefixImage}",width: 20,height: 20,),
      ) : const SizedBox.shrink(),

      padding: const EdgeInsets.all(10),
      placeholder: widget.placeholder,
      inputFormatters:widget.inputFormatters ,
      obscureText: widget.obscureText ?? false,
      placeholderStyle: const TextStyle(
        color: Color(0xFF879EA4),
        fontSize: 16,
      ),
      // textAlign: TextAlign.center,
      style: const TextStyle(
        fontSize: 16,
        fontWeight: FontWeight.w400,

      ),
      decoration: BoxDecoration(
        color:  Colors.white,
        borderRadius: BorderRadius.circular(30),
        border: Border.all(color: const Color(0XFF1F546033)),
      ),
      suffix: Container(
        padding: EdgeInsets.symmetric(horizontal: 20),
          child: Row(
            children: [
              Container(
                height: 30,
                width: 1,
                color: Colors.grey[300],
              ),
              SizedBox(width: 10,),
              Image.asset("assets/images/filter.png",width: 22,height: 20,),
            ],
          )
      )
      ,
    );
  }
}
import 'dart:io';

import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:urbandrop/controllers/auth/authentication_controller.dart';

import 'dart:async';

import 'package:urbandrop/core/helper/helper.dart';
import 'package:urbandrop/core/utils/colors_utils.dart';
import 'package:urbandrop/routes.dart';




class SelfieCameraScreen extends StatefulWidget {
  final List<CameraDescription>? cameras;
  const SelfieCameraScreen({Key? key,this.cameras}) : super(key: key);

  @override
  _SelfieCameraScreenState createState() => _SelfieCameraScreenState();
}

class _SelfieCameraScreenState extends State<SelfieCameraScreen> {
  late CameraController _controller;
  late Future<void> _initializeControllerFuture;
  int selectCamera = 0;


  initializeCamera(int cameraIndex)async{
    _controller = CameraController(
        widget.cameras![cameraIndex],
        ResolutionPreset.medium
    );

    _initializeControllerFuture = _controller.initialize();
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    selectCamera = widget.cameras!.length > 1 ? 1 : 0;
    initializeCamera(widget.cameras!.length > 1 ? 1 : selectCamera);
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _controller.dispose();

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      body: Padding(
        padding:
        EdgeInsets.only(left: 20, right: 20, top: appHeight(context) * 0.1, bottom: 20),
        child: Stack(
          alignment: Alignment.center,
          children: [



            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                FutureBuilder<void>(
                  future: _initializeControllerFuture,
                  builder: (context,snapshot){
                    if(snapshot.connectionState == ConnectionState.done){
                      return ClipRRect(
                        borderRadius: const BorderRadius.all(Radius.elliptical(200, 300)),
                        child: SizedBox(
                          height: 450,
                          width: 300,
                          child: Transform.rotate(
                            angle: -_controller.value.aspectRatio * (3.14159 / 180),
                            child: AspectRatio(
                              aspectRatio:1,
                              child: CameraPreview(_controller,),
                            ),
                          ),
                        ),
                      );

                    }else{
                      return  Center(child: CircularProgressIndicator(),);
                    }
                  },

                ),
                SizedBox(height: 30,),
                Center(
                  child: SizedBox(
                    width: appWidth(context) * 0.9,
                    child: sText("Scan your face",align: TextAlign.center,color: Colors.black,size: 20,weight: FontWeight.w700),
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                Center(
                  child: SizedBox(
                    width: appWidth(context) * 0.9,
                    child: sText("Place your face in a frame",align: TextAlign.center,color: Colors.black,size: 12,weight: FontWeight.w400),
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 20),
                  width: appWidth(context),
                  child: mainButton(
                    backgroundColor:selectCamera == 1  ? primaryColor : Colors.white ,
                    outlineColor: selectCamera == 1  ? Colors.transparent : Colors.black,
                    onPressed: () async {
                      print(selectCamera);
                      authenticationController.selfieImageFile = null;
                      if(selectCamera == 1){
                        await _initializeControllerFuture; //To make sure camera is initialized
                        var xFile = await _controller.takePicture();
                        var  profilePicPath = xFile.path;
                        print("path:${xFile.path}");
                        authenticationController.selfieImageFile = File(xFile.path);
                        context.push(Routing.uploadSelfiePage);
                      }else{
                        toastMessage("Kindly use front camera by tapping on the camera icon",context);
                      }

                    },
                    content:  sText("Complete",color: selectCamera == 1 ? Colors.white : Colors.black,size: 16,weight: FontWeight.w600),
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                InkWell(
                    onTap: () {
                      context.pop();
                    },
                    child:  Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          decoration: const BoxDecoration(
                              border: Border(
                                  bottom: BorderSide(color: Colors.black)
                              )
                          ),
                          child:  sText(
                              'Back',
                              align: TextAlign.left,
                              color: Colors.black,
                              weight: FontWeight.w700
                          ),
                        ),
                      ],
                    )


                ),
                const SizedBox(
                  height: 20,
                ),
              ],
            )
          ],
        ),
      ),
    );
    Scaffold(
      body: Stack(
        alignment: Alignment.center,
        children: [
          SizedBox(
            height: appHeight(context),
            child: FutureBuilder<void>(
              future: _initializeControllerFuture,
              builder: (context,snapshot){
                if(snapshot.connectionState == ConnectionState.done){
                  return CameraPreview(_controller);
                }else{
                  return  const Center(child: CircularProgressIndicator(),);
                }
              },

            ),
          ),

          Positioned(
            top: 50,
            child: Align(
              child: Opacity(
                opacity: 0.3,
                child: Container(
                  height: 450,
                  width: 300,
                  decoration:  BoxDecoration(
                    color: Colors.black26,
                    border: Border.all(color: Colors.white, width: 5.0),
                    borderRadius:  const BorderRadius.all(Radius.elliptical(200, 300)),
                  ),
                ),
              ),
            ),
          ),

          Positioned(
            bottom: 0,
            child: Column(
              children: [
                Center(
                  child: SizedBox(
                    width: appWidth(context) * 0.9,
                      child: sText("Position your face directly in front of the camera in a well lit area",align: TextAlign.center,color: Colors.white,size: 20)
                  ),
                ),

                Center(
                  child: Container(
                    padding: appPadding(20),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        GestureDetector(
                          onTap: () async {
                            print(selectCamera);
                            authenticationController.selfieImageFile = null;
                            if(selectCamera == 1){
                              await _initializeControllerFuture; //To make sure camera is initialized
                              var xFile = await _controller.takePicture();
                              var  profilePicPath = xFile.path;
                              print("path:${xFile.path}");
                              authenticationController.selfieImageFile = File(xFile.path);
                              context.push(Routing.uploadSelfiePage);
                            }else{
                              toastMessage("Kindly use front camera by tapping on the camera icon",context);
                            }

                          },
                          child: Container(
                            height: 60,
                            width: 60,
                            decoration: const BoxDecoration(
                              shape: BoxShape.circle,
                            ),
                            child: Image.asset("assets/images/camera_button.png"),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                InkWell(
                  onTap: (){
                    context.pop();
                  },
                  child: Center(
                    child: SizedBox(
                        width: appWidth(context) * 0.9,
                        child: sText("CANCEL",align: TextAlign.center,color: Colors.white,size: 20,weight: FontWeight.bold)
                    ),
                  ),
                ),
                const SizedBox(height: 20,)
              ],
            ),
          )
        ],
      ),
    );

  }
}

class MyClipper extends CustomClipper<Rect> {
  @override
  Rect getClip(Size size) {
    return Rect.fromCircle(center: const Offset(200, 100), radius: 150);
  }

  @override
  bool shouldReclip(covariant CustomClipper<Rect> oldClipper) {
    return false;
  }
}
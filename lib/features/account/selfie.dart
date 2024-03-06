import 'dart:io';

import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'dart:async';

import 'package:urbandrop/core/helper/helper.dart';




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
  List<File> captureImages = [];



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
    return  Stack(
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
                return  Center(child: CircularProgressIndicator(),);
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
                  borderRadius:  BorderRadius.all(Radius.elliptical(200, 300)),
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
                          captureImages.clear();
                          if(selectCamera == 1){
                            await _initializeControllerFuture; //To make sure camera is initialized
                            var xFile = await _controller.takePicture();
                            var  profilePicPath = xFile.path;
                            print("path:${xFile.path}");
                            captureImages.add(File(xFile.path));

                          }else{
                            toastMessage("Kindly use front camera by tapping on the camera icon",context);
                          }

                        },
                        child: Container(
                          height: 60,
                          width: 60,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                          ),
                          child: Image.asset("assets/images/camera_button.png"),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Center(
                child: SizedBox(
                    width: appWidth(context) * 0.9,
                    child: sText("CANCEL",align: TextAlign.center,color: Colors.white,size: 20,weight: FontWeight.bold)
                ),
              ),
              SizedBox(height: 20,)
            ],
          ),
        )
      ],
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
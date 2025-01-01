import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';

class progressHud{
  progressHud._private();

  static final progressHud _shared=progressHud._private();

  factory progressHud() => _shared;

  Widget createLodingView({Color? color , double size=25}){
    return Stack(
      children: [
        _getCircularProgress(color: color,size:size)
      ],
    );
  }

  Widget _getCircularProgress({Color? color , double size=25}) {
    return Center(
      child: SpinKitRotatingCircle(color: color,size: size),
    );
  }

void StartLoding(){
    showDialog(context: Get.context!, builder: (c){
      return createLodingView(color: Colors.green,size: 25);
    });
}

void stopLoding(){
    if(Navigator.of(Get.context!).canPop()){
      Navigator.of(Get.context!,rootNavigator: true).pop();
    }
}
}
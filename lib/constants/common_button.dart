import 'package:flutter/material.dart';
import 'package:get/get.dart';
class material{
  Widget button({
  required String text,
    required VoidCallback ontap,
    Color color=Colors.teal
})
  {
    return  Padding(
      padding:  EdgeInsets.symmetric(horizontal: Get.width*0.02),
      child: MaterialButton(
        onPressed: ontap,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
        child:Text(text,style: TextStyle(color: Colors.white,fontSize: Get.width*0.042),),
        height: Get.height*0.06,
        minWidth: double.infinity,
        color: Colors.teal.shade400,
      ),
    );
  }
}
// class Common_Button {
//   final tax;
//   final height;
//   final minwith;
//   final color;
//   final VoidCallback ontap;
//
//   const Common_Button({
//     required this.tax,
//     this.height,
//     this.minwith,
//     this.color,
//     required this.ontap,
//   });
//
//   @override
//   Widget build(BuildContext context) {
//     return MaterialButton(
//       onPressed: ontap,
//       shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
//       child: tax,
//       minWidth: minwith,
//       height: height,
//       color: color,
//     );
//   }
// }

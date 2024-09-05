import 'package:flutter/material.dart';
import 'package:odc_mobile_project/utils/colors.dart';

class TextFieldContainer extends StatelessWidget {
  const TextFieldContainer({ Key? key,this.child }) : super(key: key);
  final Widget? child;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 10),
      padding: const EdgeInsets.symmetric(horizontal:20,vertical:5),
      width: size.width *0.8,
      decoration: BoxDecoration(
        color: Color(0xfffeeeee4),
        borderRadius: BorderRadius.circular(29),
      ),
      child: child,
    );
  }
}
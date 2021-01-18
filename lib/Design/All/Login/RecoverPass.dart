import 'package:flutter/material.dart';
import 'package:movitronia/Utils/Colors.dart';
import 'package:sizer/sizer.dart';

class RecoverPass extends StatefulWidget {
  @override
  _RecoverPassState createState() => _RecoverPassState();
}

class _RecoverPassState extends State<RecoverPass> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
      Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset("Assets/images/LogoCompleto.png", width: 30.0.w),
        ],
      ),
      SizedBox(
        height: 5.0.h,
      ),
      Container(
        width: 80.0.w,
        // height: .0.h,
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.all(Radius.circular(50))),
        child: TextFormField(
          textAlign: TextAlign.center,
          style: TextStyle(color: blue, fontSize: 20),
          keyboardType: TextInputType.emailAddress,
          decoration: InputDecoration(
            prefixIcon: Padding(
              padding: const EdgeInsets.only(left: 2.0),
              child: InkWell(
                onTap: () {},
                child: CircleAvatar(
                  radius: 7.0.w,
                  backgroundColor: blue,
                  child: Center(
                    child: Icon(
                      Icons.arrow_forward_ios,
                      size: 7.0.w,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ),
            border: InputBorder.none,
            counterText: "",
            labelStyle: TextStyle(color: blue),
            hintText: "CORREO",
            hintStyle: TextStyle(color: blue, fontSize: 7.0.w),
          ),
        ),
      )
    ]));
  }
}

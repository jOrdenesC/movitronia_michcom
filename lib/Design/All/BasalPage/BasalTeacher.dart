import 'package:flutter/material.dart';
import 'package:movitronia/Design/Widgets/Button.dart';
import 'package:movitronia/Routes/RoutePageControl.dart';
import 'package:movitronia/Utils/Colors.dart';
import 'package:orientation_helper/orientation_helper.dart';
import 'package:sizer/sizer.dart';

class BasalTeacher extends StatefulWidget {
  @override
  _BasalTeacherState createState() => _BasalTeacherState();
}

class _BasalTeacherState extends State<BasalTeacher> {
  String gender;
  TextEditingController rut = TextEditingController();
  TextEditingController name = TextEditingController();
  TextEditingController height = TextEditingController();
  TextEditingController weight = TextEditingController();
  String frequentlyActivity;
  TextEditingController phone = TextEditingController();
  TextEditingController mail = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final dynamic role =
        (ModalRoute.of(context).settings.arguments as RouteArguments).args;
    return Scaffold(
      bottomNavigationBar: Container(
        width: double.infinity,
        height: 10.0.h,
        color: cyan,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            buttonRounded(context, func: () {
              goToWelcome(role);
              // goToBasal(widget.role);
              //Get.to(Terms(role: widget.role));
            }, text: "   ENVIAR")
          ],
        ),
      ),
      backgroundColor: blue,
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        physics: ScrollPhysics(parent: NeverScrollableScrollPhysics()),
        child: Column(
          children: [
            SizedBox(
              height: 5.0.h,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.all(Radius.circular(18))),
                  width: 80.0.w,
                  child: Center(
                      child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      "Datos personales",
                      style: TextStyle(color: blue, fontSize: 6.0.w),
                    ),
                  )),
                ),
              ],
            ),
            SizedBox(
              height: 5.0.h,
            ),
            Container(
              height: 70.0.h,
              child: SingleChildScrollView(
                physics: ScrollPhysics(parent: BouncingScrollPhysics()),
                scrollDirection: Axis.vertical,
                child: Column(
                  children: [
                    item(
                        child: TextField(
                            style: TextStyle(color: Colors.white),
                            decoration: InputDecoration(
                                border: InputBorder.none,
                                hintStyle: TextStyle(color: Colors.white),
                                hintText: 'Ingresa tu rut')),
                        name: "Rut"),
                    item(
                        child: TextField(
                            keyboardType: TextInputType.number,
                            style: TextStyle(color: Colors.white),
                            decoration: InputDecoration(
                                border: InputBorder.none,
                                hintStyle: TextStyle(color: Colors.white),
                                hintText: 'Ingresa tu nombre')),
                        name: "Nombre"),
                    item(
                        child: TextField(
                            keyboardType: TextInputType.number,
                            decoration: InputDecoration(
                                border: InputBorder.none,
                                hintStyle: TextStyle(color: Colors.white),
                                hintText: 'Ingresa tu colegio')),
                        name: "Colegio"),
                    item(
                        child: TextField(
                            keyboardType: TextInputType.phone,
                            decoration: InputDecoration(
                                border: InputBorder.none,
                                hintStyle: TextStyle(color: Colors.white),
                                hintText: 'Ingresa tu número de teléfono')),
                        name: "Teléfono móvil"),
                    item(
                        child: TextField(
                            keyboardType: TextInputType.emailAddress,
                            decoration: InputDecoration(
                                border: InputBorder.none,
                                hintStyle: TextStyle(color: Colors.white),
                                hintText: 'Ingresa tu correo')),
                        name: "Correo electrónico"),
                    item(
                        child: TextField(
                            keyboardType: TextInputType.number,
                            decoration: InputDecoration(
                                border: InputBorder.none,
                                hintStyle: TextStyle(color: Colors.white),
                                hintText: 'Ingresa tu comuna')),
                        name: "Comuna"),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget item({Widget child, String name}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Text(
          "$name",
          textAlign: TextAlign.end,
          style: TextStyle(color: Colors.white, fontSize: 3.0.h),
        ),
        Container(
            decoration: BoxDecoration(
                border: Border.all(color: Colors.white),
                color: Colors.transparent,
                borderRadius: BorderRadius.all(Radius.circular(18))),
            width: 80.0.w,
            child: Padding(
              padding: const EdgeInsets.only(left: 8.0),
              child: child,
            )),
        SizedBox(
          height: 2.0.h,
        )
      ],
    );
  }
}

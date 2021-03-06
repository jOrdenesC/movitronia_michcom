import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:movitronia/Utils/Colors.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:sizer/sizer.dart';
import 'package:toast/toast.dart';

class EvidencesQuestionary extends StatefulWidget {
  @override
  _EvidencesQuestionaryState createState() => _EvidencesQuestionaryState();
}

class _EvidencesQuestionaryState extends State<EvidencesQuestionary> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: red,
      appBar: AppBar(
        backgroundColor: cyan,
        elevation: 0,
        leading: IconButton(
            icon: Icon(
              Icons.arrow_back,
              size: 12.0.w,
              color: Colors.white
            ),
            onPressed: () => Navigator.pop(context),
          ),
        title: Column(
          children: [
            SizedBox(
                height: 2.0.h,
              ),
            FittedBox(fit: BoxFit.fitWidth, child:Text("Evidencias Cuestionario".toUpperCase(), style: TextStyle(
              fontSize: 5.0.w
            ),),),
          ],
        ),
        centerTitle: true,
      ),
      body: body(),
    );
  }

  Widget body() {
    return Stack(
      children: [
        Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Transform.rotate(
                  origin: Offset(-3.0.w, -3.0.w),
                  angle: pi * 1,
                  child: SvgPicture.asset("Assets/images/figure2.svg",
                      color: Color.fromRGBO(167, 71, 66, 1), width: 70.0.w),
                ),
              ],
            ),
          ],
        ),
        Column(
          children: [
            SizedBox(
              height: 2.0.h,
            ),
            Row(
              children: [
                SizedBox(
                  width: 5.0.w,
                ),
                Image.asset(
                  "Assets/images/LogoCompleto.png",
                  width: 18.0.w,
                )
              ],
            ),
            SizedBox(
              height: 2.0.h,
            ),
            Expanded(
              child: SingleChildScrollView(
                physics: ScrollPhysics(parent: BouncingScrollPhysics()),
                scrollDirection: Axis.vertical,
                child: Column(
                  children: [
                    SizedBox(
                      height: 7.0.h,
                    ),
                    divider(yellow, "FASE 1"),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        circularActivity("title", 0,
                            "Assets/images/docImage.png", "1", false),
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 8.0, right: 8),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          circularActivity("title", 0,
                              "Assets/images/docImage.png", "2", true),
                          circularActivity("title", 0,
                              "Assets/images/docImage.png", "3", true),
                        ],
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        circularActivity("title", 0,
                            "Assets/images/docImage.png", "4", true),
                      ],
                    ),
                    divider(green, "FASE 2"),
                    Text(""),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        circularActivity("title", 0,
                            "Assets/images/docImage.png", "1", true),
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 8.0, right: 8),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          circularActivity("title", 0,
                              "Assets/images/docImage.png", "2", true),
                          circularActivity("title", 0,
                              "Assets/images/docImage.png", "3", true),
                        ],
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        circularActivity("title", 0,
                            "Assets/images/docImage.png", "4", true),
                      ],
                    ),
                    divider(cyan, "FASE 3"),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        circularActivity("title", 0,
                            "Assets/images/docImage.png", "1", true),
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 15.0, right: 15),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          circularActivity("title", 0,
                              "Assets/images/docImage.png", "2", true),
                          circularActivity("title", 0,
                              "Assets/images/docImage.png", "3", true),
                        ],
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        circularActivity("title", 0,
                            "Assets/images/docImage.png", "4", true),
                      ],
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      ],
    );
  }

  Widget divider(Color color, String text) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Container(
          width: 25.0.w,
          height: 10.0.h,
          decoration: BoxDecoration(
              border: Border.all(color: Colors.white, width: 3),
              color: color,
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(50),
                  bottomLeft: Radius.circular(50))),
          child: Center(
              child: Text(
            "$text",
            style: TextStyle(color: Colors.white, fontSize: 5.5.w),
          )),
        )
      ],
    );
  }

  Widget circularActivity(
      String title, double percentage, String img, String number, bool lock) {
    return Padding(
      padding: const EdgeInsets.only(left: 9.0, right: 9),
      child: InkWell(
          onTap: () {
            if (lock == false) {
              // goToPlanification();
            } else {
              Toast.show("No has subido evidencias de esta sesión.", context,
                  duration: Toast.LENGTH_LONG,
                  gravity: Toast.CENTER,
                  backgroundColor: red);
            }
          },
          child: Stack(
            children: [
              Container(
                width: 35.0.w,
                // color: red,
                child: CircularPercentIndicator(
                  percent: percentage,
                  progressColor: green,
                  lineWidth: 7,
                  radius: 29.0.w,
                  center: CircleAvatar(
                    radius: 12.8.w,
                    backgroundColor: lock ? Colors.grey : yellow,
                    child: Container(
                      margin: lock ? EdgeInsets.all(6.5) : EdgeInsets.all(0),
                      color: Colors.transparent,
                      child: Image.asset(
                        "$img",
                        color: lock ? Colors.white : blue,
                        fit: lock ? BoxFit.contain : BoxFit.contain,
                        width: lock ? 14.0.w : 16.0.w,
                        height: lock ? 20.0.h : 20.0.h,
                      ),
                    ),
                  ),
                ),
              ),
              Positioned(
                top: 20.0.w,
                left: 22.0.w,
                child: CircularPercentIndicator(
                  lineWidth: 7,
                  radius: 9.0.w,
                  center: CircleAvatar(
                    backgroundColor: Colors.white,
                    child: Center(
                        child: lock
                            ? Icon(
                                Icons.close,
                                color: red,
                                size: 8.0.w,
                              )
                            : Icon(
                                Icons.check,
                                color: green,
                                size: 8.0.w,
                              )),
                  ),
                ),
              )
            ],
          )),
    );
  }
}

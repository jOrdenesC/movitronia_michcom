import 'package:flutter/material.dart';
import 'package:movitronia/Functions/Controllers/OtherController.dart';
import 'package:movitronia/Routes/RoutePageControl.dart';
import 'package:movitronia/Utils/Colors.dart';
import 'package:percent_indicator/percent_indicator.dart';
import 'package:sizer/sizer.dart';
import 'package:toast/toast.dart';

class Sessions extends StatefulWidget {
  @override
  _SessionsState createState() => _SessionsState();
}

class _SessionsState extends State<Sessions> {
  @override
  void initState() {
    super.initState();
  }

  Widget build(BuildContext context) {
    return body();
  }

  Widget body() {
    return Stack(
      children: [
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
            Flexible(
              flex: 1,
              child: SingleChildScrollView(
                physics: ScrollPhysics(parent: BouncingScrollPhysics()),
                scrollDirection: Axis.vertical,
                child: Column(
                  children: [
                    SizedBox(
                      height: 2.0.h,
                    ),
                    InkWell(
                        onTap: () {
                          OtherController().insertData();
                        },
                        child: divider(yellow, "FASE 1")),
                    createPhase([
                      item("Assets/images/buttons/2unlock.png", false),
                      item("Assets/images/buttons/3lock.png", true),
                      item("Assets/images/buttons/1lock.png", true),
                      item("Assets/images/buttons/4lock.png", true),
                    ]),
                    InkWell(
                        onTap: () {
                          goToTest();
                        },
                        child: divider(green, "FASE 2")),
                    createPhase([
                      item("Assets/images/buttons/2lock.png", true),
                      item("Assets/images/buttons/3lock.png", true),
                      item("Assets/images/buttons/1lock.png", true),
                      item("Assets/images/buttons/4lock.png", true),
                    ]),
                    InkWell(
                        onTap: () {
                          goToTest();
                        },
                        child: divider(red, "FASE 3")),
                    createPhase([
                      item("Assets/images/buttons/2lock.png", true),
                      item("Assets/images/buttons/3lock.png", true),
                      item("Assets/images/buttons/1lock.png", true),
                      item("Assets/images/buttons/4lock.png", true),
                    ]),
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

  Widget item(String route, bool lock) {
    return InkWell(
      onTap: () {
        if (lock == false) {
          goToPlanification();
        } else {
          Toast.show("Debes completar las clases anteriores.", context,
              duration: Toast.LENGTH_LONG,
              gravity: Toast.CENTER,
              backgroundColor: red);
        }
      },
      child: Container(
        child: Image.asset(
          route,
          width: 30.0.w,
        ),
      ),
    );
  }

  Widget circularActivity(
      String title, double percentage, String img, String number, bool lock) {
    return Padding(
      padding: const EdgeInsets.only(left: 9.0, right: 9),
      child: InkWell(
          onTap: () {},
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
                    child: ColorFiltered(
                      colorFilter: lock
                          ? ColorFilter.mode(
                              Colors.grey,
                              BlendMode.saturation,
                            )
                          : ColorFilter.mode(
                              Colors.transparent,
                              BlendMode.multiply,
                            ),
                      child: Container(
                        margin: lock ? EdgeInsets.all(6.5) : EdgeInsets.all(0),
                        color: Colors.transparent,
                        child: Image.asset(
                          "$img",
                          fit: lock ? BoxFit.contain : BoxFit.cover,
                          width: lock ? 14.0.w : 20.0.w,
                          height: lock ? 20.0.h : 20.0.h,
                        ),
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
                            ? Image.asset(
                                "Assets/images/lock.png",
                                width: 4.0.w,
                              )
                            : Image.asset(
                                "Assets/images/unlock.png",
                                width: 5.0.w,
                              )),
                  ),
                ),
              )
            ],
          )),
    );
  }

  Widget createPhase(List sessions) {
    return Container(
      height: 50.0.h,
      child: Stack(
        alignment: Alignment.center,
        children: [
          Column(
            children: [
              SizedBox(
                height: 5.0.h,
              ),
              sessions[0],
              // item("Assets/images/buttons/2unlock.png"),
              SizedBox(
                height: 5.0.h,
              ),
              sessions[1],
              // item("Assets/images/buttons/2lock.png"),
            ],
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  sessions[2],
                  // item("Assets/images/buttons/1lock.png"),
                  SizedBox(
                    width: 35.0.w,
                  ),
                  sessions[3],
                  // item("Assets/images/buttons/4lock.png"),
                ],
              ),
            ],
          )
        ],
      ),
    );
  }
}

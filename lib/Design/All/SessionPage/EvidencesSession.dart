import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:movitronia/Database/Test/data2.dart';
import 'package:movitronia/Routes/RoutePageControl.dart';
import 'package:movitronia/Utils/Colors.dart';
import 'package:sizer/sizer.dart';
import 'package:toast/toast.dart';

class EvidencesSession extends StatefulWidget {
  @override
  _EvidencesSessionState createState() => _EvidencesSessionState();
}

class _EvidencesSessionState extends State<EvidencesSession> {
  bool questionary = false;
  bool video = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // bottomNavigationBar: Container(
      //   width: 100.0.w,
      //   height: 10.0.h,
      //   color: cyan,
      //   child: Row(
      //     mainAxisAlignment: MainAxisAlignment.center,
      //     children: [
      //       buttonRounded(context, func: () {
      //         // setState(() {
      //         //   isPause = !isPause;
      //         // });
      //       }, text: "   CONTINUAR")
      //     ],
      //   ),
      // ),
      backgroundColor: blue,
      appBar: AppBar(
        backgroundColor: cyan,
        centerTitle: true,
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
            FittedBox(fit: BoxFit.fitWidth, child:Text("EVIDENCIAS")),
          ],
        ),
      ),
      body: Stack(
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Transform.rotate(
                    origin: Offset(-3.0.w, -3.0.w),
                    angle: pi * 1.5,
                    child: SvgPicture.asset("Assets/images/figure2.svg",
                        color: Color.fromRGBO(25, 45, 99, 1), width: 60.0.w),
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Transform.rotate(
                    origin: Offset(-8, 0),
                    angle: pi * 0.5,
                    child: SvgPicture.asset("Assets/images/figure2.svg",
                        color: Color.fromRGBO(25, 45, 99, 1), width: 45.0.w),
                  ),
                ],
              ),
            ],
          ),
          Column(
            children: [
              SizedBox(height: 30.0.h),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  InkWell(
                    onTap: navigateVideo,
                    child: Container(
                      decoration: BoxDecoration(
                          color: video ? green : red,
                          borderRadius: BorderRadius.only(
                              topRight: Radius.circular(90),
                              bottomRight: Radius.circular(90))),
                      width: 40.0.w,
                      height: 15.0.h,
                      child: Center(
                        child: Icon(
                          Icons.camera_alt,
                          color: Colors.white,
                          size: 25.0.w,
                        ),
                      ),
                    ),
                  ),
                  InkWell(
                    onTap: navigate,
                    child: Container(
                      width: 40.0.w,
                      child: Center(
                          child: Image.asset(
                        "Assets/images/docImage.png",
                        color: questionary ? Colors.white : red,
                        width: 20.0.w,
                      )),
                      height: 15.0.h,
                      decoration: BoxDecoration(
                          color: questionary ? green : Colors.white,
                          borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(90),
                              bottomLeft: Radius.circular(90))),
                    ),
                  )
                ],
              ),
              SizedBox(
                height: 2.0.h,
              ),
              video == false && questionary == false
                  ? Padding(
                      padding: const EdgeInsets.only(left: 10, right: 10),
                      child: Text(
                        "Ahora deberás responder un cuestionario y grabar un vídeo haciendo los ejercicios.",
                        style: TextStyle(
                          fontSize: 8.0.w,
                          color: Colors.white,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    )
                  : video && questionary == false
                      ? Padding(
                          padding: const EdgeInsets.only(left: 10, right: 10),
                          child: Text(
                            "Tan sólo falta responder el cuestionario",
                            style: TextStyle(
                              fontSize: 8.0.w,
                              color: Colors.white,
                            ),
                            textAlign: TextAlign.center,
                          ),
                        )
                      : questionary && video == false
                          ? Padding(
                              padding:
                                  const EdgeInsets.only(left: 10, right: 10),
                              child: Text(
                                "Tan sólo falta grabar el vídeo",
                                style: TextStyle(
                                  fontSize: 8.0.w,
                                  color: Colors.white,
                                ),
                                textAlign: TextAlign.center,
                              ),
                            )
                          : Padding(
                              padding:
                                  const EdgeInsets.only(left: 10, right: 10),
                              child: Text(
                                "Ya puedes subir los datos de la sesión.",
                                style: TextStyle(
                                  fontSize: 8.0.w,
                                  color: Colors.white,
                                ),
                                textAlign: TextAlign.center,
                              ),
                            ),
            ],
          ),
        ],
      ),
    );
  }

  onGoBack(dynamic value) {
    setState(() {
      questionary = true;
    });

    if (questionary && video) {
      goToUploadData();
    }
  }

  onGoBackVideo(dynamic value) {
    setState(() {
      video = true;
    });

    if (questionary && video) {
      goToUploadData();
    }
  }

  void navigate() {
    goToQuestionary(dataJson["sessions"][0]["name"].toString(), onGoBack);
  }

  void navigateVideo() {
    if (questionary == false) {
      Toast.show(
          "Debes responder el cuestionario antes de grabar tu video", context,
          duration: Toast.LENGTH_LONG,
          gravity: Toast.CENTER,
          backgroundColor: red);
    } else {
      goToVideosToRecord(onGoBackVideo);
    }
  }
}

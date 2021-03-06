import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_gifimage/flutter_gifimage.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:movitronia/Design/Widgets/Button.dart';
import 'package:movitronia/Functions/Controllers/videoRecorderController.dart';
import 'package:movitronia/Routes/RoutePageControl.dart';
import 'package:movitronia/Utils/Colors.dart';
import 'package:sizer/sizer.dart';
import 'package:video_player/video_player.dart';

class VideosToRecord extends StatefulWidget {
  @override
  _VideosToRecordState createState() => _VideosToRecordState();
}

class _VideosToRecordState extends State<VideosToRecord>
    with TickerProviderStateMixin {
  VideoController videoController = VideoController();
  String gifName = "Assets/images/C1.gif";
  String gifName2 = "Assets/images/C2.gif";
  @override
  void initState() {
    videoController.initializePlayer();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var h = MediaQuery.of(context).size.height;
    var w = MediaQuery.of(context).size.width;

    //Obx(() => Text(videoController.gifName.value)),
    //This initialize the controller and allow us to build objects observing changes on the
    return GetX<VideoController>(
      init: videoController,
      builder: (_) {
        return Scaffold(
          backgroundColor: Colors.white,
          appBar: AppBar(
            centerTitle: true,
            backgroundColor: cyan,
            elevation: 0,
            leading: IconButton(
              icon: Icon(Icons.arrow_back, size: 12.0.w, color: Colors.white),
              onPressed: () => Navigator.pop(context),
            ),
            title: Column(
              children: [
                SizedBox(
                  height: 2.0.h,
                ),
                FittedBox(
                    fit: BoxFit.fitWidth,
                    child: Text('Grabación de ejercicios'.toUpperCase())),
              ],
            ),
          ),
          bottomNavigationBar: Container(
            width: w,
            height: 10.0.h,
            color: cyan,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                buttonRounded(context, func: () {
                  videoController.recordMovie();
                },
                    text: "   GRABAR",
                    icon: Icon(
                      Icons.videocam_rounded,
                      color: blue,
                      size: 10.0.w,
                    ))
              ],
            ),
          ),
          body: Stack(
            children: [
              Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Transform.rotate(
                        // origin: Offset(-3.0.w, -3.0.w),
                        angle: pi * 0.5,
                        child: SvgPicture.asset("Assets/images/figure2.svg",
                            color: cyan, width: 40.0.w),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 3.0.h,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Transform.rotate(
                        // origin: Offset(-3.0.w, -3.0.w),
                        angle: pi * 2,
                        child: SvgPicture.asset("Assets/images/figure2.svg",
                            color: cyan, width: 40.0.w),
                      ),
                    ],
                  ),
                ],
              ),
              // ignore: unrelated_type_equality_checks
              _.loading == false
                  ? Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Transform.rotate(
                          // origin: Offset(-3.0.w, -3.0.w),
                          angle: pi * 2,
                          child: SvgPicture.asset(
                            "Assets/images/yellow.svg",
                            color: yellow,
                            fit: BoxFit.fill,
                            height: 40.0.h,
                            width: 100.0.w,
                          ),
                        ),
                      ],
                    )
                  : SizedBox.shrink(),
              Container(
                // ignore: unrelated_type_equality_checks
                child: _.loading == false
                    ? Column(children: [
                        SizedBox(
                          height: 15.0.h,
                        ),
                        InkWell(
                          onTap: () {
                            goToDetailsExcercises(
                                "skipping",
                                gifName,
                                "10",
                                "10",
                                "Mantén la zona abdominal contraída. Mueve los brazos al ritmo de las piernas. Mantén la espalda erguida");
                          },
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Column(
                                children: [
                                  Container(
                                    width: 70.0.w,
                                    height: 7.0.h,
                                    decoration: BoxDecoration(
                                        color: red,
                                        borderRadius: BorderRadius.only(
                                            topRight: Radius.circular(50),
                                            bottomRight: Radius.circular(50))),
                                    child: Center(
                                      child: Text(
                                        "Skipping",
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 8.0.w),
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    height: 1.0.h,
                                  ),
                                  Container(
                                    decoration: BoxDecoration(
                                        border: Border.all(
                                            color: red, width: 1.0.w)),
                                    child:
                                        VideoPlayer(_.videoPlayerController1),
                                    width: 50.0.w,
                                    height: 15.0.h,
                                  )
                                ],
                              ),
                            ],
                          ),
                        ),
                        SizedBox(
                          height: 2.0.h,
                        ),
                        InkWell(
                          onTap: () {
                            goToDetailsExcercises(
                                "jumping jacks",
                                gifName2,
                                "12",
                                "10",
                                "Contrae el abdomen. No encojas los hombros. Amortigua los pies con suavidad al momento de la caída..");
                          },
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              Column(
                                children: [
                                  Container(
                                    width: 70.0.w,
                                    height: 7.0.h,
                                    decoration: BoxDecoration(
                                        color: red,
                                        borderRadius: BorderRadius.only(
                                            topLeft: Radius.circular(50),
                                            bottomLeft: Radius.circular(50))),
                                    child: Center(
                                      child: Text(
                                        "Jumping jacks",
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 8.0.w),
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    height: 1.0.h,
                                  ),
                                  Container(
                                    decoration: BoxDecoration(
                                        border: Border.all(
                                            color: red, width: 1.0.w)),
                                    child:
                                        VideoPlayer(_.videoPlayerController2),
                                    width: 50.0.w,
                                    height: 15.0.h,
                                  )
                                ],
                              ),
                            ],
                          ),
                        ),
                        // activityWidget(
                        //     controllerActividad1,
                        //     gifName,
                        //     'SKIPPING',
                        //     () => videoController.changeValue(1)),
                        // activityWidget(
                        //     controllerActividad2,
                        //     gifName2,
                        //     'JUMPING JACKS',
                        //     () => videoController.changeValue(2)),
                        // SizedBox(height: h * 0.05),
                        SizedBox(
                          height: 5.0.h,
                        ),
                        Text(
                          'Graba por 20 segundos estos dos ejercicios',
                          style: TextStyle(fontSize: 6.0.w, color: blue),
                          textAlign: TextAlign.center,
                        ),
                      ])
                    : Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Center(
                            child: SpinKitWave(
                              size: 100,
                              color: blue,
                            ),
                          ),
                          SizedBox(
                            height: h * 0.04,
                          ),
                          Center(
                              child: Text(
                            "Procesando Video",
                            style: TextStyle(color: blue, fontSize: 30),
                          ))
                        ],
                      ),
              ),
            ],
          ),
        );
      },
    );
  }

  @override
  void dispose() {
    videoController.videoPlayerController1.dispose();
    videoController.videoPlayerController2.dispose();

    super.dispose();
  }
}

Widget activityWidget(
    GifController controller, String gifName, String title, Function f) {
  return Card(
    child: Padding(
      padding: const EdgeInsets.all(8.0),
      child: ListTile(
        leading: GifImage(
          controller: controller,
          image: AssetImage(gifName),
        ),
        title: Center(
          child: Text(
            title,
            style: TextStyle(fontSize: 20),
          ),
        ),
        onTap: f,
      ),
    ),
  );
}

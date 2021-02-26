import 'package:flutter/material.dart';
import 'package:movitronia/Design/Widgets/Button.dart';
import 'package:movitronia/Utils/Colors.dart';
import 'package:sizer/sizer.dart';

class ApplicationUse extends StatefulWidget {
  @override
  _ApplicationUseState createState() => _ApplicationUseState();
}

class _ApplicationUseState extends State<ApplicationUse> {
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
      //         Navigator.pop(context);
      //       },
      //           text: "   VOLVER",
      //           icon: Icon(
      //             Icons.arrow_back_ios_rounded,
      //             color: blue,
      //             size: 8.0.w,
      //           ))
      //     ],
      //   ),
      // ),
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: cyan,
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
            FittedBox(fit: BoxFit.fitWidth, child:Text("Uso de aplicación")),
          ],
        ),
        centerTitle: true,
        elevation: 0,
      ),
      body: Column(
        children: [
          SizedBox(
            height: 10.0.h,
          ),
          example("FASE 1", 50.0),
          SizedBox(
            height: 1.0.h,
          ),
          example("FASE 2", 25.0),
          SizedBox(
            height: 1.0.h,
          ),
          example("FASE 3", 50.0),
          SizedBox(
            height: 1.0.h,
          ),
          example("FASE 4", 50.0),
          SizedBox(
            height: 1.0.h,
          ),
          example("FASE 5", 50.0),
          SizedBox(
            height: 1.0.h,
          ),
          example("FASE 6", 50.0),
          SizedBox(
            height: 1.0.h,
          ),
          example("FASE 7", 25.0),
          SizedBox(
            height: 1.0.h,
          ),
          example("FASE 8", 25.0),
          SizedBox(
            height: 1.0.h,
          ),
          example("FASE 9", 25.0),
          SizedBox(
            height: 1.0.h,
          ),
          example("FASE 10", 50.0)
        ],
      ),
    );
  }

  Widget example(String month, double percentage) {
    return Center(
      child: Container(
        decoration: BoxDecoration(
            color: cyan, borderRadius: BorderRadius.all(Radius.circular(10))),
        height: 4.0.h,
        width: 90.0.w,
        child: Stack(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Center(
                      child: Container(
                        child: Center(
                            child: Text(
                          month,
                          style: TextStyle(color: Colors.white),
                        )),
                        decoration: BoxDecoration(
                            color: blue,
                            borderRadius:
                                BorderRadius.all(Radius.circular(10))),
                        height: 4.0.h,
                        width: 30.0.w,
                      ),
                    ),
                    Center(
                      child: Container(
                        child: Center(
                            child: Text(
                          percentage.toInt().toString() + "%",
                          style: TextStyle(color: Colors.white),
                        )),
                        decoration: BoxDecoration(
                            color: red,
                            borderRadius: BorderRadius.only(
                                bottomRight: Radius.circular(30),
                                topRight: Radius.circular(30))),
                        height: 3.0.h,
                        width: (percentage - 10).w,
                      ),
                    )
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.only(right: 8.0),
                  child: Text(
                    "100%",
                    style: TextStyle(color: blue.withOpacity(0.7)),
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}

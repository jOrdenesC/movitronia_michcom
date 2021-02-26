import 'package:dots_indicator/dots_indicator.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:movitronia/Database/Test/data2.dart';
import 'package:movitronia/Design/Widgets/Button.dart';
import 'package:movitronia/Utils/Colors.dart';
import 'package:movitronia/Utils/Testing/Questionary.dart';
import 'package:orientation_helper/orientation_helper.dart';
import 'package:sizer/sizer.dart';

class Questionary extends StatefulWidget {
  @override
  _QuestionaryState createState() => _QuestionaryState();
}

class _QuestionaryState extends State<Questionary> {
  double countDots = 0.0;
  List groups = [];
  List responses = [];
  Color color;
  bool allResponsed = false;

  PageController pageController = PageController(
    initialPage: 0,
  );

  @override
  void initState() {
    super.initState();
    for (var i = 0; i < dataJson["sessions"][0]["questionary"].length; i++) {
      groups.add("group " + (i + 1).toString());
    }
    for (var i = 0; i < groups.length; i++) {
      responses.add("response " + i.toString());
    }
    print(groups);
    print(responses);
  }

  validate() {
    int notResponsed = 0;
    for (var i = 0; i < responses.length; i++) {
      if (responses[i].toString().contains("response")) {
        setState(() {
          notResponsed++;
        });
      }
    }
    if (notResponsed != 0) {
      setState(() {
        allResponsed = false;
      });
    } else {
      setState(() {
        allResponsed = true;
      });
    }
  }

  Widget build(BuildContext context) {
    final dynamic name =
        (ModalRoute.of(context).settings.arguments as RouteArguments).args;
    return Scaffold(
        bottomNavigationBar: Container(
          width: 100.0.w,
          height: 10.0.h,
          color: cyan,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              buttonRounded(context,
              width: 70.0.w,
              circleRadius: 6.0.w,
              height: 7.0.h,
                  func: () => Get.back(),
                  text: "Finalizar",
                  textStyle: TextStyle(
                    fontSize: 7.0.w,
                    color: Colors.white
                  ),
                  icon: Icon(
                    Icons.arrow_forward_ios_rounded,
                    color: blue,
                    size: 9.0.w,
                  ))
            ],
          ),
        ),
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: cyan,
          leading: SizedBox.shrink(),
          elevation: 0,
          centerTitle: true,
          
          title: Column(
            children: [
              SizedBox(
                height: 2.0.h,
              ),
              FittedBox(fit: BoxFit.fitWidth, child:Text("CUESTIONARIO $name".toUpperCase())),
            ],
          ),
        ),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Container(
              height: 70.0.h,
              child: PageView.builder(
                onPageChanged: (val) {
                  setState(() {
                    countDots = val.toDouble();
                  });
                },
                controller: pageController,
                itemCount: questionsExample.length,
                itemBuilder: (context, index) {
                  if (questionsExample[index]["type"] == "selection") {
                    return card(questionsExample[index]["question"], index + 1,
                        index + 1, "selection");
                  } else {
                    return card(questionsExample[index]["question"], index + 1,
                        index + 1, "vf");
                  }
                },
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                InkWell(
                  onTap: () {
                    pageController.previousPage(
                        duration: Duration(seconds: 1), curve: Curves.linear);
                  },
                  child: Center(
                      child: Icon(
                    Icons.arrow_back_ios_rounded,
                    color: blue,
                    size: 10.0.w,
                  )),
                ),
                DotsIndicator(
                  decorator: DotsDecorator(
                    color: Colors.grey,
                    activeColor: blue,
                    activeSize: Size(5.0.w, 5.0.w),
                  ),
                  dotsCount: questionsExample.length,
                  position: countDots,
                ),
                InkWell(
                  onTap: () {
                    pageController.nextPage(
                        duration: Duration(seconds: 1), curve: Curves.linear);
                  },
                  child: Center(
                      child: Icon(
                    Icons.arrow_forward_ios_rounded,
                    color: blue,
                    size: 10.0.w,
                  )),
                )
              ],
            ),
            Text("")
          ],
        ));
  }

  Future<bool> pri() async {
    print("back");
    return false;
  }

  Widget card(String question, int number, int pageNumber, String type) {
    return Stack(
      children: [
        SingleChildScrollView(
          scrollDirection: Axis.vertical,
          physics: ScrollPhysics(parent: BouncingScrollPhysics()),
          child: Column(
            children: [
              type == "vf"
                  ? Container(
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(20))),
                      child: Column(
                        children: [
                          SizedBox(
                            height: 3.0.h,
                          ),
                          Text(
                            "$number.- $question",
                            style: TextStyle(color: blue, fontSize: 6.0.w),
                            textAlign: TextAlign.center,
                          ),
                          SizedBox(
                            height: 2.0.h,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  InkWell(
                                    onTap: () {
                                      if (pageNumber == 1) {}
                                    },
                                    child: Container(
                                      decoration: BoxDecoration(
                                          color: red,
                                          borderRadius: BorderRadius.only(
                                              topRight: Radius.circular(90),
                                              bottomRight:
                                                  Radius.circular(90))),
                                      width: 45.0.w,
                                      height: 15.0.h,
                                      child: Center(
                                        child: Icon(
                                          Icons.check_circle_outline_outlined,
                                          color: Colors.white,
                                          size: 25.0.w,
                                        ),
                                      ),
                                    ),
                                  ),
                                  Text(
                                    " Verdadero",
                                    style:
                                        TextStyle(fontSize: 8.0.w, color: red),
                                  )
                                ],
                              ),
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              Column(
                                children: [
                                  InkWell(
                                    onTap: () {
                                      if (pageNumber == 1) {}
                                    },
                                    child: Container(
                                      decoration: BoxDecoration(
                                          color: red,
                                          borderRadius: BorderRadius.only(
                                              topLeft: Radius.circular(90),
                                              bottomLeft: Radius.circular(90))),
                                      width: 45.0.w,
                                      height: 15.0.h,
                                      child: Center(
                                        child: Icon(
                                          Icons.close,
                                          color: Colors.white,
                                          size: 25.0.w,
                                        ),
                                      ),
                                    ),
                                  ),
                                  Text(
                                    " Falso",
                                    style:
                                        TextStyle(fontSize: 8.0.w, color: red),
                                  )
                                ],
                              ),
                            ],
                          ),
                        ],
                      ),
                    )
                  : Container(
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(20))),
                      child: Column(
                        children: [
                          SizedBox(
                            height: 3.0.h,
                          ),
                          Text(
                            "$number.- $question",
                            style: TextStyle(color: blue, fontSize: 6.0.w),
                            textAlign: TextAlign.center,
                          ),
                          SizedBox(
                            height: 2.0.h,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  InkWell(
                                    onTap: () {
                                      if (pageNumber == 1) {}
                                    },
                                    child: Container(
                                      decoration: BoxDecoration(
                                          color: cyan,
                                          borderRadius: BorderRadius.only(
                                              topRight: Radius.circular(90),
                                              bottomRight:
                                                  Radius.circular(90))),
                                      width: 35.0.w,
                                      height: 10.0.h,
                                      child: Center(
                                          child: Text("A",
                                              style: TextStyle(
                                                  fontSize: 10.0.w,
                                                  color: Colors.white))),
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(
                                width: 1.0.w,
                              ),
                              Text("Calcio y fosforo",
                                  style:
                                      TextStyle(fontSize: 7.0.w, color: blue))
                            ],
                          ),
                          SizedBox(
                            height: 2.0.h,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  InkWell(
                                    onTap: () {},
                                    child: Container(
                                      decoration: BoxDecoration(
                                          color: cyan,
                                          borderRadius: BorderRadius.only(
                                              topRight: Radius.circular(90),
                                              bottomRight:
                                                  Radius.circular(90))),
                                      width: 35.0.w,
                                      height: 10.0.h,
                                      child: Center(
                                          child: Text("B",
                                              style: TextStyle(
                                                  fontSize: 10.0.w,
                                                  color: Colors.white))),
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(
                                width: 1.0.w,
                              ),
                              Text("Agua y minerales",
                                  style:
                                      TextStyle(fontSize: 7.0.w, color: blue))
                            ],
                          ),
                          SizedBox(
                            height: 2.0.h,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  InkWell(
                                    onTap: () {
                                      if (pageNumber == 1) {}
                                    },
                                    child: Container(
                                      decoration: BoxDecoration(
                                          color: cyan,
                                          borderRadius: BorderRadius.only(
                                              topRight: Radius.circular(90),
                                              bottomRight:
                                                  Radius.circular(90))),
                                      width: 35.0.w,
                                      height: 10.0.h,
                                      child: Center(
                                          child: Text("C",
                                              style: TextStyle(
                                                  fontSize: 10.0.w,
                                                  color: Colors.white))),
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(
                                width: 1.0.w,
                              ),
                              Text("Litio y sodio",
                                  style:
                                      TextStyle(fontSize: 7.0.w, color: blue))
                            ],
                          ),
                          SizedBox(
                            height: 2.0.h,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              InkWell(
                                onTap: () {
                                  if (pageNumber == 1) {}
                                },
                                child: Container(
                                  decoration: BoxDecoration(
                                      color: cyan,
                                      borderRadius: BorderRadius.only(
                                          topRight: Radius.circular(90),
                                          bottomRight: Radius.circular(90))),
                                  width: 35.0.w,
                                  height: 10.0.h,
                                  child: Center(
                                      child: Text("D",
                                          style: TextStyle(
                                              fontSize: 10.0.w,
                                              color: Colors.white))),
                                ),
                              ),
                              SizedBox(
                                width: 1.0.w,
                              ),
                              Text("Ninguna de las \nanteriores",
                                  style:
                                      TextStyle(fontSize: 7.0.w, color: blue))
                            ],
                          ),
                          // Divider(),
                          // RadioButtonGroup(
                          //   orientation: GroupedButtonsOrientation.VERTICAL,
                          //   activeColor: Colors.green,
                          //   labelStyle: TextStyle(fontSize: 20),
                          //   onChange: (text, index) {
                          //     print(text);
                          //     print(index);
                          //   },
                          //   onSelected: (String selected) => setState(() {
                          //     responses[number - 1] = selected;
                          //     validate();
                          //   }),
                          //   labels: dataJson["sessions"][0]["questionary"][number - 1]
                          //       ["alternatives"],
                          //   picked: responses[number - 1].toString(),
                          //   itemBuilder: (Radio rb, Text txt, int i) {
                          //     return Column(
                          //       children: [
                          //         ListTile(
                          //           title: Row(
                          //             children: <Widget>[
                          //               rb,
                          //               Flexible(child: txt),
                          //             ],
                          //           ),
                          //         ),
                          //         Divider()
                          //       ],
                          //     );
                          //   },
                          // ),
                          // Expanded(
                          //     child: ListView.builder(
                          //   itemBuilder: (context, index) {
                          //     return RadioListTile(
                          //       groupValue: (number - 1),
                          //       value: dataJson["questionary"][number - 1]["alternatives"]
                          //           [index],
                          //       onChanged: (a) {
                          //         setState(() {
                          //           responses[index] = a;
                          //           print(
                          //               "En el ${groups[index]} selected ${responses[index]}");
                          //         });
                          //       },
                          //       title: Text(
                          //         "${dataJson["questionary"][number - 1]["alternatives"][index]}",
                          //         style: TextStyle(fontSize: 20),
                          //       ),
                          //     );
                          //   },
                          //   itemCount: dataJson["questionary"][number - 1]["alternatives"]
                          //       .length,
                          // ))
                        ],
                      ),
                    ),
              Text(""),
              // Row(
              //   mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              //   children: [
              //     number - 1 == 0
              //         ? SizedBox.shrink()
              //         : ConstrainedBox(
              //             constraints: BoxConstraints(maxWidth: 50),
              //             child: RaisedButton(
              //               color: Colors.white,
              //               padding: EdgeInsets.symmetric(
              //                 vertical: 12,
              //               ),
              //               shape: StadiumBorder(),
              //               child: Icon(
              //                 Icons.arrow_back_ios,
              //                 color: blue,
              //               ),
              //               onPressed: () {
              //                 pageController.previousPage(
              //                     duration: Duration(milliseconds: 1000),
              //                     curve: Curves.elasticOut);
              //               },
              //             ),
              //           ),
              //     Text(
              //       "$number de ${dataJson["sessions"][0]["questionary"].length}",
              //       style: TextStyle(color: Colors.white, fontSize: 20),
              //     ),
              //     number == dataJson["sessions"][0]["questionary"].length
              //         ? SizedBox.shrink()
              //         : ConstrainedBox(
              //             constraints: BoxConstraints(maxWidth: 50),
              //             child: RaisedButton(
              //               color: Colors.white,
              //               padding: EdgeInsets.symmetric(
              //                 vertical: 12,
              //               ),
              //               shape: StadiumBorder(),
              //               child: Icon(
              //                 Icons.arrow_forward_ios,
              //                 color: blue,
              //               ),
              //               onPressed: () {
              //                 print(number - 1);
              //                 print(dataJson["sessions"][0]["questionary"].length);
              //                 pageController.nextPage(
              //                     duration: Duration(milliseconds: 1000),
              //                     curve: Curves.elasticOut);
              //               },
              //             ),
              //           ),
              //   ],
              // )
            ],
          ),
        ),
      ],
    );
  }
}

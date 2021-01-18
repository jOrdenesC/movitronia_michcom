import 'dart:async';
import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:movitronia/Routes/RoutePageControl.dart';
import 'package:movitronia/Utils/Colors.dart';
import 'package:sizer/sizer.dart';

class Splash extends StatefulWidget {
  @override
  _SplashState createState() => _SplashState();
}

class _SplashState extends State<Splash> {
  Timer timer;
  int _start = 10;
  int _text = 2;
  bool text = false;

  @override
  void initState() {
    startText();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(children: [
        Container(
          width: double.infinity,
          height: double.infinity,
          child: Image.asset(
            "Assets/images/wall.jpg",
            fit: BoxFit.cover,
          ),
        ),
        Container(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.30,
              ),
              Center(
                child: ElasticIn(
                  duration: Duration(seconds: 2),
                  child: Image.asset(
                    "Assets/images/logoTextBlue.png",
                    scale: 1.0,
                    width: 50.0.w,
                  ),
                ),
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.01,
              ),
              text == false
                  ? SizedBox()
                  : Center(
                      child: InkWell(
                        // onTap: () => gotoIntro(),
                        child: FadeIn(
                          duration: Duration(seconds: 1),
                          child: Image.asset(
                            "Assets/images/LogoText.png",
                            scale: 1.5,
                            color: blue,
                          ),
                        ),
                      ),
                    ),
            ],
          ),
        ),
      ]),
    );
  }

  void startTimer() {
    _start = 2;
    const oneSec = const Duration(seconds: 1);
    timer = new Timer.periodic(
      oneSec,
      (Timer timer) => setState(
        () {
          if (_start < 1) {
            timer.cancel();
            goToLogin();
          } else {
            _start = _start - 1;
          }
        },
      ),
    );
  }

  void startText() {
    _text = 1;
    const oneSec = const Duration(seconds: 1);
    timer = new Timer.periodic(
      oneSec,
      (Timer timer) => setState(
        () {
          if (_text < 1) {
            timer.cancel();
            text = true;
            startTimer();
          } else {
            _text = _text - 1;
          }
        },
      ),
    );
  }
}

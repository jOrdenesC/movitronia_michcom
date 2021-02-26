import 'dart:ui';
import 'package:animate_do/animate_do.dart';
import 'package:dart_rut_validator/dart_rut_validator.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:movitronia/Routes/AppRoutes.dart';
import 'package:movitronia/Routes/RoutePageControl.dart';
import 'package:movitronia/Utils/Colors.dart';
import 'package:sizer/sizer.dart';

class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  TextEditingController rut = TextEditingController();
  TextEditingController pass = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  bool validated = false;
  bool isValid = false;
  bool passIsValid = false;
  bool passIsHide = true;

  void onChangedApplyFormat(String text) {
    RUTValidator.formatFromTextController(rut);
    setState(() {
      validated = _formKey.currentState.validate();
    });
  }

  void onChangedPass(String text) {
    _formKey.currentState.validate();
    if (_formKey.currentState.validate()) {
      setState(() {
        passIsValid = true;
      });
    } else {
      setState(() {
        passIsValid = false;
      });
    }
  }

  @override
  void initState() {
    super.initState();
  }

  Widget build(BuildContext context) {
    var h = MediaQuery.of(context).size.height;
    var w = MediaQuery.of(context).size.width;
    Size size = MediaQuery.of(context).size;
    return WillPopScope(
      onWillPop: pop,
      child: Scaffold(
        body: Stack(
          children: [
            Container(
              width: w,
              height: h,
              color: blue,
            ),
            SingleChildScrollView(
              physics: ScrollPhysics(parent: NeverScrollableScrollPhysics()),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    width: double.infinity,
                    height: size.height,
                    child: Column(
                      children: [
                        SizedBox(
                          height: h * 0.25,
                        ),
                        FadeIn(
                          duration: Duration(milliseconds: 1500),
                          child: Container(
                            width: w * 0.5,
                            height: h * 0.2,
                            decoration: BoxDecoration(
                                image: DecorationImage(
                                    image: AssetImage(
                                        "Assets/images/LogoCompleto.png"),
                                    fit: BoxFit.contain)),
                          ),
                        ),
                        SizedBox(
                          height: h * 0.05,
                        ),
                        //
                        Column(
                          children: [
                            ZoomIn(
                              duration: Duration(seconds: 1),
                              child: Form(
                                key: _formKey,
                                child: FadeInLeft(
                                  duration: Duration(milliseconds: 500),
                                  child: Padding(
                                    padding:
                                        EdgeInsets.only(right: 10.0, left: 10),
                                    child: isValid
                                        ? FlipInY(
                                            duration: Duration(seconds: 1),
                                            child: Container(
                                              width: w * 0.8,
                                              decoration: BoxDecoration(
                                                  color: Colors.white,
                                                  borderRadius:
                                                      BorderRadius.all(
                                                          Radius.circular(50))),
                                              child: TextFormField(
                                                  obscureText: passIsHide,
                                                  // validator: (value) => pass
                                                  //             .text.length <=
                                                  //         7
                                                  //     ? "La contraseña es demasiado corta"
                                                  //     : null,
                                                  onChanged: onChangedPass,
                                                  textAlign: TextAlign.center,
                                                  style: TextStyle(
                                                      color: validated
                                                          ? blue
                                                          : red,
                                                      fontSize: 20),
                                                  decoration: InputDecoration(
                                                    prefixIcon: Padding(
                                                      padding:
                                                          const EdgeInsets.only(
                                                              left: 2.0),
                                                      child: InkWell(
                                                        onTap: () {
                                                          if (validated) {
                                                            if (isValid ==
                                                                false) {
                                                              setState(() {
                                                                isValid = true;
                                                              });
                                                            } else if (passIsValid) {
                                                              print(rut.text);

                                                              goToTerms(rut.text
                                                                      .contains(
                                                                          "1")
                                                                  ? "user"
                                                                  : "teacher");
                                                            } else {
                                                              print("error");
                                                            }
                                                          }
                                                        },
                                                        child: CircleAvatar(
                                                          radius: 7.0.w,
                                                          backgroundColor: blue,
                                                          child: Center(
                                                            child: Icon(
                                                              Icons
                                                                  .arrow_forward_ios,
                                                              size: 7.0.w,
                                                              color:
                                                                  Colors.white,
                                                            ),
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                    suffixIcon: Padding(
                                                      padding:
                                                          const EdgeInsets.only(
                                                              right: 8.0),
                                                      child: IconButton(
                                                          icon: Icon(
                                                            Icons
                                                                .remove_red_eye,
                                                            color: passIsHide
                                                                ? Colors.grey
                                                                : blue,
                                                          ),
                                                          onPressed: () {
                                                            setState(() {
                                                              passIsHide =
                                                                  !passIsHide;
                                                            });
                                                          }),
                                                    ),
                                                    border: InputBorder.none,
                                                    counterText: "",
                                                    labelStyle:
                                                        TextStyle(color: blue),
                                                    hintText: "Contraseña",
                                                    hintStyle: TextStyle(
                                                        color: blue,
                                                        fontSize: w * 0.07),
                                                  ),
                                                  controller: pass),
                                            ))
                                        : FlipInX(
                                            child: Container(
                                                width: w * 0.8,
                                                decoration: BoxDecoration(
                                                    color: Colors.white,
                                                    borderRadius:
                                                        BorderRadius.all(
                                                            Radius.circular(
                                                                50))),
                                                child: TextFormField(
                                                    textAlign: TextAlign.center,
                                                    maxLength: 12,
                                                    style: TextStyle(
                                                        color: validated
                                                            ? blue
                                                            : red,
                                                        fontSize: 20),
                                                    keyboardType:
                                                        TextInputType.text,
                                                    decoration: InputDecoration(
                                                      prefixIcon: Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                    .only(
                                                                left: 2.0),
                                                        child: InkWell(
                                                          onTap: () {
                                                            if (validated) {
                                                              if (isValid ==
                                                                  false) {
                                                                setState(() {
                                                                  isValid =
                                                                      true;
                                                                });
                                                              } else if (passIsValid) {
                                                                print(rut.text);

                                                                goToTerms(rut
                                                                        .text
                                                                        .contains(
                                                                            "1")
                                                                    ? "user"
                                                                    : "teacher");
                                                              } else {
                                                                print("error");
                                                              }
                                                            }
                                                          },
                                                          child: CircleAvatar(
                                                            radius: 7.0.w,
                                                            backgroundColor:
                                                                blue,
                                                            child: Center(
                                                              child: Icon(
                                                                Icons
                                                                    .arrow_forward_ios,
                                                                size: 7.0.w,
                                                                color: Colors
                                                                    .white,
                                                              ),
                                                            ),
                                                          ),
                                                        ),
                                                      ),
                                                      border: InputBorder.none,
                                                      counterText: "",
                                                      labelStyle: TextStyle(
                                                          color: blue),
                                                      hintText: "RUT",
                                                      hintStyle: TextStyle(
                                                          color: blue,
                                                          fontSize: w * 0.07),
                                                    ),
                                                    validator: RUTValidator(
                                                            validationErrorText:
                                                                '         Rut no válido')
                                                        .validator,
                                                    controller: rut,
                                                    onChanged:
                                                        onChangedApplyFormat)),
                                          ),
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(
                              height: 3.0.h,
                            ),
                            InkWell(
                              onTap: () {
                                goToRecoverPass();
                              },
                              child: Text(
                                isValid ? "¿Olvidaste tu contraseña?" : "",
                                style: TextStyle(
                                    color: Colors.white, fontSize: 6.0.w),
                              ),
                            )
                          ],
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ),
            // ),
          ],
        ),
      ),
    );
  }

  Future<bool> pop() async {
    if (isValid == true) {
      setState(() {
        isValid = false;
      });
    } else {
      closeApp();
    }
    return false;
  }

  closeApp() {
    Navigator.pop(context);
  }

  @override
  void dispose() {
    super.dispose();
  }
}

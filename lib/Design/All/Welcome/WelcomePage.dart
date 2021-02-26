import 'package:flutter/material.dart';
import 'package:movitronia/Design/Widgets/Button.dart';
import 'package:movitronia/Routes/RoutePageControl.dart';
import 'package:movitronia/Utils/Colors.dart';
import 'package:orientation_helper/orientation_helper.dart';
import 'package:sizer/sizer.dart';

class WelcomePage extends StatefulWidget {
  @override
  _WelcomePageState createState() => _WelcomePageState();
}

class _WelcomePageState extends State<WelcomePage> {
  @override
  Widget build(BuildContext context) {
    final dynamic role =
        (ModalRoute.of(context).settings.arguments as RouteArguments).args;
    return Scaffold(
      bottomNavigationBar: Container(
        width: 100.0.w,
        height: 10.0.h,
        color: cyan,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            buttonRounded(context, func: () {
              goToHome(role);
            }, text: "   COMENZAR")
          ],
        ),
      ),
      body: Stack(
        children: [
          Container(
            width: double.infinity,
            height: double.infinity,
            child: Image.asset(
              "Assets/images/wall2.jpg",
              fit: BoxFit.cover,
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(30),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(
                  height: 20.0.h,
                ),
                // Row(
                //   mainAxisAlignment: MainAxisAlignment.end,
                //   children: [
                //     Container(
                //         child: Image.asset(
                //       "Assets/images/LogoCompleto.png",
                //       width: 25.0.w,
                //     )),
                //   ],
                // ),
                // SizedBox(
                //   height: w * 0.1,
                // ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    "BIENVENIDOS",
                    textAlign: TextAlign.center,
                    style: TextStyle(color: blue, fontSize: 7.0.w),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    role == "user"
                        ? 'Descubre el mundo MOVITRONIA, una forma entrenida de hacer actividad física, sigue las instrucciones y vivirás una experiencia distinta de hacer ejercicio, sólo oprime "comenzar" y empieza esta aventura.'
                        : 'Descubre el mundo MOVITRONIA, una forma entrenida de PLANIFICAR TUS CLASES y construir evaluaciones estándarizadas para tus alumnos.',
                    textAlign: TextAlign.center,
                    style: TextStyle(color: blue, fontSize: 5.5.w),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

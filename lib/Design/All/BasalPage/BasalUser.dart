import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:movitronia/Design/Widgets/Button.dart';
import 'package:movitronia/Routes/RoutePageControl.dart';
import 'package:movitronia/Utils/Colors.dart';
import 'package:orientation_helper/orientation_helper.dart';
import 'package:sizer/sizer.dart';

class BasalUser extends StatefulWidget {
  @override
  _BasalUserState createState() => _BasalUserState();
}

class _BasalUserState extends State<BasalUser> {
  DateTime selectedDate;
  String gender;
  TextEditingController rut = TextEditingController();
  TextEditingController age = TextEditingController();
  TextEditingController height = TextEditingController();
  TextEditingController weight = TextEditingController();
  String frequentlyActivity;
  TextEditingController phone = TextEditingController();
  TextEditingController mail = TextEditingController();
  final f = new DateFormat('dd-MM-yyyy');
  

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
                        child: DropdownButton<String>(
                          iconEnabledColor: Colors.white,
                          underline: SizedBox.shrink(),
                          hint: gender == null
                              ? Text(
                                  "Selecciona tu sexo",
                                  style: TextStyle(color: Colors.white),
                                )
                              : Text(
                                  gender,
                                  style: TextStyle(color: Colors.white),
                                ),
                          items: <String>['Femenino', 'Masculino']
                              .map((String value) {
                            return DropdownMenuItem<String>(
                              value: value,
                              child: Text(
                                value,
                                style: TextStyle(color: Colors.white),
                              ),
                            );
                          }).toList(),
                          onChanged: (val) {
                            setState(() {
                              gender = val;
                              print(gender);
                            });
                          },
                        ),
                        name: "Sexo"),
                    item(
                        child: InkWell(
                          onTap: () {
                            datePicker();
                          },
                          child: Container(
                            child: Row(
                              children: [
                                selectedDate != null
                                    ? Text(f.format(selectedDate).toString().substring(0, 10),
                                        style: TextStyle(color: Colors.white))
                                    : Text(
                                        "Selecciona tu fecha de nacimiento",
                                        style: TextStyle(color: Colors.white),
                                      ),
                              ],
                            ),
                            width: 80.0.w,
                            height: 6.5.h,
                          ),
                        ),
                        name: "Fecha de nacimiento"),
                    item(
                        child: TextField(
                            keyboardType: TextInputType.number,
                            decoration: InputDecoration(
                                border: InputBorder.none,
                                hintStyle: TextStyle(color: Colors.white),
                                hintText: 'Ingresa tu estatura (cm)')),
                        name: "Estatura"),
                    item(
                        child: TextField(
                            keyboardType: TextInputType.number,
                            decoration: InputDecoration(
                                border: InputBorder.none,
                                hintStyle: TextStyle(color: Colors.white),
                                hintText: 'Ingresa tu peso')),
                        name: "Peso"),
                    item(
                        child: DropdownButton<String>(
                          iconEnabledColor: Colors.white,
                          underline: SizedBox.shrink(),
                          hint: frequentlyActivity == null
                              ? Text(
                                  "Frecuencia de actividad física",
                                  style: TextStyle(color: Colors.white),
                                )
                              : Text(
                                  frequentlyActivity,
                                  style: TextStyle(color: Colors.white),
                                ),
                          items: <String>[
                            'Baja (0 - 1 vez por semana)',
                            'Media (2 - 3 vez por semana)',
                            'Alta (4 - 5 vez por semana)'
                          ].map((String value) {
                            return DropdownMenuItem<String>(
                              value: value,
                              child: Text(
                                value,
                                style: TextStyle(color: Colors.white),
                              ),
                            );
                          }).toList(),
                          onChanged: (val) {
                            setState(() {
                              frequentlyActivity = val;
                            });
                          },
                        ),
                        name: "Frec. actividad física"),
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
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  datePicker() async {
    final DateTime picked = await showDatePicker(
      cancelText: "CANCELAR",
      helpText: "SELECCIONA TU FECHA DE NACIMIENTO",
      fieldHintText: "SELECCIONA TU FECHA DE NACIMIENTO",
      confirmText: "ACEPTAR",
      // locale: Locale("es"),
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1990),
      lastDate: DateTime.now(),
    );
    if (picked != null && picked != selectedDate)
      setState(() {
        selectedDate = picked;
      });
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

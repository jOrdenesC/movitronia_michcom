import 'package:chart_components/bar_chart_component.dart';
import 'package:flutter/material.dart';
import 'package:movitronia/Design/Widgets/Button.dart';
import 'package:movitronia/Utils/Colors.dart';
import 'package:movitronia/Utils/Testing/DataGraphics.dart';
import 'package:sizer/sizer.dart';

class CaloricExpenditure extends StatefulWidget {
  @override
  _CaloricExpenditureState createState() => _CaloricExpenditureState();
}

class _CaloricExpenditureState extends State<CaloricExpenditure> {
  List<double> data = [];
  List<String> labels = [];
  bool loaded = false;

  @override
  void initState() {
    super.initState();
    DataRepository.clearData();
    _loadData();
  }

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
          icon: Icon(Icons.arrow_back, size: 12.0.w, color: Colors.white),
          onPressed: () => Navigator.pop(context),
        ),
        title: Column(
          children: [
            SizedBox(
              height: 2.0.h,
            ),
            FittedBox(fit: BoxFit.fitWidth, child: Text("REPORTES")),
          ],
        ),
        centerTitle: true,
        elevation: 0,
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(
            height: 10.0.h,
          ),
          Text(
            "GASTO CALÓRICO (KCal)",
            style: TextStyle(color: blue, fontSize: 7.0.w),
          ),
          Expanded(
            flex: 30,
            child: Container(
              margin: EdgeInsets.all(16),
              padding: EdgeInsets.only(bottom: 0, left: 8, right: 8, top: 8),
              decoration: BoxDecoration(
                shape: BoxShape.rectangle,
                borderRadius: BorderRadius.all(Radius.circular(10)),
                border: Border.all(color: blue, width: 2),
              ),
              child: BarChart(
                data: data,
                labels: labels,
                labelStyle: TextStyle(fontSize: 4.0.w),
                valueStyle:
                    TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
                displayValue: true,
                reverse: true,
                getColor: DataRepository.getColor,
                getIcon: DataRepository.getIcon,
                barWidth: 15.0.w,
                barSeparation: 7.0.w,
                animationDuration: Duration(milliseconds: 1000),
                animationCurve: Curves.easeInOutSine,
                itemRadius: 5.0.w,
                iconHeight: 24,
                footerHeight: 24,
                headerValueHeight: 16,
                roundValuesOnText: false,
                lineGridColor: blue,
              ),
            ),
          )
        ],
      ),
    );
  }

  void _loadData() {
    setState(() {
      if (!loaded) {
        data = DataRepository.getData();
        loaded = true;
      }
      labels = DataRepository.getLabels();
    });
  }
}

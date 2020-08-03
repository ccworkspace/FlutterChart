/*
 * @Author: Cao Shixin
 * @Date: 2020-05-27 11:34:30
 * @LastEditors: Cao Shixin
 * @LastEditTime: 2020-08-03 12:49:26
 * @Description: 
 * @Email: cao_shixin@yahoo.com
 * @Company: BrainCo
 */
import 'package:flutter/material.dart';
import 'package:flutter_chart/flutter_chart.dart';

class DoubleChartlinePage extends StatefulWidget {
  static const String routeName = 'double_chart_line';
  static const String title = '双折线';
  @override
  _DoubleChartlineState createState() => _DoubleChartlineState();
}

class _DoubleChartlineState extends State<DoubleChartlinePage> {
  ChartBeanSystem _chartBeanSystem1, _chartBeanSystem2;
  List<ChartBean> _chartBeans1, _chartBeans2;

  @override
  void initState() {
    _chartBeans1 = [];
    _chartBeans2 = [];
    _chartBeanSystem1 = ChartBeanSystem(
      xTitleStyle: TextStyle(color: Colors.grey, fontSize: 12),
      isDrawX: true,
      lineWidth: 2,
      pointRadius: 4,
      isCurve: false,
      chartBeans: [
        ChartBean(x: '3-01', y: 30),
        ChartBean(x: '3-02', y: 88, isShowPlaceImage: true),
        ChartBean(x: '3-03', y: 20),
        ChartBean(x: '3-04', y: 67),
        ChartBean(x: '3-05', y: 10),
        ChartBean(x: '3-06', y: 40, isShowPlaceImage: true),
        ChartBean(x: '3-07', y: 10),
        ChartBean(x: '3-08', y: 100, isShowPlaceImage: false),
      ],
      shaderColors: [
        Colors.blue.withOpacity(0.3),
        Colors.blue.withOpacity(0.1)
      ],
      lineColor: Colors.cyan,
      placehoderImageBreak: true,
    );
    _chartBeanSystem2 = ChartBeanSystem(
      xTitleStyle: TextStyle(color: Colors.grey, fontSize: 12),
      isDrawX: false,
      lineWidth: 2,
      pointRadius: 4,
      isCurve: false,
      chartBeans: [
        ChartBean(x: '3-01', y: 70, isShowPlaceImage: false),
        ChartBean(x: '3-02', y: 20),
        ChartBean(x: '3-03', y: 30),
        ChartBean(x: '3-04', y: 50, isShowPlaceImage: true),
        ChartBean(x: '3-05', y: 100, isShowPlaceImage: true),
        ChartBean(x: '3-06', y: 30, isShowPlaceImage: false),
        ChartBean(x: '3-07', y: 0),
        ChartBean(x: '3-08', y: 0, isShowPlaceImage: false),
      ],
      shaderColors: [Colors.red.withOpacity(0.3), Colors.red.withOpacity(0.1)],
      lineColor: Colors.red,
      placehoderImageBreak: false,
    );
    UIImageUtil.loadImage('assets/lock.jpg').then((value) {
      _chartBeanSystem1.placehoderImage = value;
      _chartBeanSystem2.placehoderImage = value;
      setState(() {});
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(DoubleChartlinePage.title),
      ),
      body: _buildDoubleChartLine(context),
    );
  }

  Widget _buildDoubleChartLine(context) {
    var chartLine = ChartLine(
      chartBeanSystems: [_chartBeanSystem1, _chartBeanSystem2],
      size: Size(MediaQuery.of(context).size.width,
          MediaQuery.of(context).size.height / 5 * 1.6),
      xColor: Colors.white,
      yColor: Colors.white,
      rulerWidth: 3,
      yDialValues: [
        DialStyle(
          title: '0',
          titleStyle: TextStyle(fontSize: 10.0, color: Colors.black),
          positionRetioy: 0 / 100.0,
        ),
        DialStyle(
          title: '35',
          titleStyle: TextStyle(fontSize: 10.0, color: Colors.black),
          positionRetioy: 35 / 100.0,
        ),
        DialStyle(
          title: '65',
          titleStyle: TextStyle(fontSize: 10.0, color: Colors.black),
          positionRetioy: 65 / 100.0,
        ),
        DialStyle(
          title: '100',
          titleStyle: TextStyle(fontSize: 10.0, color: Colors.black),
          positionRetioy: 100 / 100.0,
        )
      ],
      yMax: 100,
      xyLineWidth: 0.5,
      isShowHintX: true,
      hintLineSolid: false,
    );
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      margin: EdgeInsets.only(left: 16, right: 16, top: 8, bottom: 8),
      semanticContainer: true,
      color: Colors.white.withOpacity(0.4),
      child: chartLine,
      clipBehavior: Clip.antiAlias,
    );
  }
}

import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_chart/chart/bean/chart_pie_bean.dart';
import 'package:flutter_chart/chart/painter/chart_pie_painter.dart';

class ChartPie extends StatefulWidget {
  final Duration duration;
  final Size size;
  final List<ChartPieBean> chartBeans;
  final Color backgroundColor; //绘制的背景色
  final bool isAnimation; //是否执行动画
  final double R, centerR; //半径,中心圆半径
  final Color centerColor; //中心圆颜色
  final double divisionWidth; //各个占比之间的分割线宽度，默认为0即不显示分割
  final AssistTextShowType assistTextShowType; //辅助性文案显示的样式
  final Color assistBGColor; //辅助性文案的背景框背景颜色
  final int decimalDigits; //辅助性百分比显示的小数位数,（饼状图还是真实的比例）

  const ChartPie({
    Key key,
    @required this.size,
    @required this.chartBeans,
    this.duration = const Duration(milliseconds: 800),
    this.backgroundColor,
    this.isAnimation = true,
    this.R,
    this.centerR,
    this.centerColor,
    this.divisionWidth = 0,
    this.assistTextShowType = AssistTextShowType.None,
    this.assistBGColor,
    this.decimalDigits = 0,
  }) : super(key: key);

  @override
  State<StatefulWidget> createState() => ChartPieState();
}

class ChartPieState extends State<ChartPie>
    with SingleTickerProviderStateMixin {
  AnimationController _controller;
  double _value = 0;
  double begin = 0.0, end = 360;

  @override
  void initState() {
    super.initState();
    if (widget.isAnimation) {
      _controller = AnimationController(vsync: this, duration: widget.duration);
      Tween(begin: begin, end: end).animate(_controller)
        ..addStatusListener((status) {
          if (status == AnimationStatus.completed) {
          }
        })
        ..addListener(() {
          _value = _controller.value;
          setState(() {});
        });
      _controller.forward();
    }
  }

  @override
  void dispose() {
    if (_controller != null) _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var painter = ChartPiePainter(
      widget.chartBeans,
      value: _value,
      R: widget.R,
      centerR: widget.centerR,
      centerColor: widget.centerColor,
      divisionWidth: widget.divisionWidth,
      assistTextShowType: widget.assistTextShowType,
      assistBGColor:widget.assistBGColor,
      decimalDigits: widget.decimalDigits,
    );
    return CustomPaint(
        size: widget.size,
        foregroundPainter: widget.backgroundColor != null ? painter : null,
        child: widget.backgroundColor != null
            ? Container(
                width: widget.size.width,
                height: widget.size.height,
                color: widget.backgroundColor,
              )
            : null,
        painter: widget.backgroundColor == null ? painter : null);
  }
}

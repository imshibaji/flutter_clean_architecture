import 'package:flutter/material.dart';

// ignore: must_be_immutable
class Display extends StatelessWidget {
  String title;
  Color? headerColor;

  Widget xs;
  Widget? xxl, xl, lg, md, sm;

  Display({
    Key? key,
    required this.title,
    required this.xs,
    this.sm,
    this.md,
    this.lg,
    this.xl,
    this.xxl,
    this.headerColor,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    // log(size.width.toString());
    double width = size.width;
    return Title(
      color: headerColor ?? Theme.of(context).primaryColor,
      title: title,
      child: Container(
        child: (width > 1400 && xxl != null)
            ? xxl
            : (width > 1200 && xl != null)
                ? xl
                : (width > 992 && lg != null)
                    ? lg
                    : (width > 768 && md != null)
                        ? md
                        : (width > 576 && sm != null)
                            ? sm
                            : xs,
      ),
    );
  }
}

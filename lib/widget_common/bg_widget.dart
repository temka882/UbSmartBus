import 'package:flutter_application_1/consts/consts.dart';

Widget bgwidget({Widget? child}) {
  return Container(
    decoration: const BoxDecoration(
        image: DecorationImage(
            image: AssetImage(imgbackground), fit: BoxFit.fill)),
    child: child,
  );
}

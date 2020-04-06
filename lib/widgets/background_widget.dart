import 'package:flutter/material.dart';

class BackgroundWidget extends StatelessWidget {
  final child;

  const BackgroundWidget({Key key, @required this.child}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
          height: MediaQuery.of(context).size.height,
          decoration: BoxDecoration(
              gradient: LinearGradient(
                  begin: Alignment.topRight,
                  end: Alignment.bottomLeft,
                  colors: [Color(0xff00005a), Color(0xffed1650)])),
                  child: this.child,);
  }
}
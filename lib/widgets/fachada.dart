import 'package:flutter/material.dart';

class Fachada extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Stack(
          children: <Widget>[
            Container(
              height: 240,
              width: double.infinity,
              decoration: BoxDecoration(
                gradient:LinearGradient(colors:[Color(0xff1b0088),Color(0xffed1650)],
            begin: FractionalOffset.topLeft,
            end: FractionalOffset.bottomRight,
            stops: [0,1],
            tileMode: TileMode.clamp
            ),

                  //color: Colors.deepPurple[900],
                  
                  borderRadius: BorderRadius.only(
//                  bottomLeft: Radius.circular(60),
                   // bottomRight: Radius.circular(60),
                  )),
            ),
            Positioned(
              top: 240 * 0.3,
              left: MediaQuery.of(context).size.width * 0.20,
              child: Image.asset('assets/images/logo.png',
                height: 70,
              ),
            )
          ],
        ),
      ],
    );
  }
}

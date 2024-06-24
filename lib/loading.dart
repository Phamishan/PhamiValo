import 'package:flutter/material.dart';
import 'package:stroke_text/stroke_text.dart';

class Loading extends StatelessWidget {
  const Loading({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        extendBodyBehindAppBar: true,
        appBar: AppBar(
          elevation: 0,
          title: const StrokeText(
            text: "LOADING...",
            textStyle: TextStyle(fontFamily: "JockeyOne", color: Colors.white),
            strokeColor: Colors.black,
            strokeWidth: 3,
          ),
          titleTextStyle: TextStyle(fontSize: 40),
          backgroundColor: Colors.transparent,
          centerTitle: true,
        ),
        body: Center(
          child: Container(
              decoration: BoxDecoration(
            color: const Color(0xFF7c2128),
            image: DecorationImage(
                image: AssetImage("assets/images/vertical_jett.png"),
                fit: BoxFit.fitWidth,
                colorFilter: ColorFilter.mode(
                    Colors.black.withOpacity(0.5), BlendMode.darken)),
          )),
        ));
  }
}

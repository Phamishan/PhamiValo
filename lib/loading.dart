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
        titleTextStyle: TextStyle(fontSize: 48),
        backgroundColor: const Color.fromARGB(0, 250, 229, 229),
        centerTitle: true,
      ),
      body: Stack(
        alignment: Alignment.center,
        children: [
          Container(
            decoration: BoxDecoration(
              color: const Color(0xFF7c2128),
              image: DecorationImage(
                  image: AssetImage("assets/images/vertical_jett.png"),
                  fit: BoxFit.fitWidth,
                  colorFilter: ColorFilter.mode(
                      Colors.black.withOpacity(0.5), BlendMode.darken)),
            ),
          ),
          Container(
            margin: const EdgeInsets.all(20),
            width: 125,
            height: 125,
            child: Container(
              child: Image.asset("assets/images/Jett_Knife.gif"),
            ),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(25), color: Colors.black),
          ),
        ],
      ),
    );
  }
}

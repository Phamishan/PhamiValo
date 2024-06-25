import 'package:flutter/material.dart';
import 'package:stroke_text/stroke_text.dart';

class User extends StatelessWidget {
  const User({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        elevation: 0,
        title: const StrokeText(
          text: "f",
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
              color: const Color(0xFFe6e3dc),
              image: DecorationImage(
                  image: AssetImage("assets/images/vertical_phx.png"),
                  fit: BoxFit.cover),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Expanded(
                child: Center(child: Text('Middle Row')),
              ),
              Container(
                alignment: Alignment.bottomLeft,
                color: const Color(0xFFE6E3DC),
                height: 50,
                padding: const EdgeInsets.all(2),
                width: MediaQuery.of(context).size.width,
                child: IconButton(
                  icon: Image.asset("assets/images/user-solid.png"),
                  onPressed: () => {
                    debugPrint("Logged!"),
                  },
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

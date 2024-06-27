import 'package:flutter/material.dart';
import 'package:stroke_text/stroke_text.dart';

class User extends StatelessWidget {
  const User({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        title: const StrokeText(
          text: "RIOT#TAG",
          textStyle: TextStyle(fontFamily: "JockeyOne", color: Colors.white),
          strokeColor: Colors.black,
          strokeWidth: 3,
        ),
        titleTextStyle: TextStyle(fontSize: 48),
        backgroundColor: const Color(0xFFE6E3DC),
        centerTitle: true,
        actions: [
          IconButton(
            icon: Image.asset("assets/images/icons/repeat-solid.png"),
            onPressed: () => {
              debugPrint("DROPDOWN"),
            },
          )
        ],
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
          Stack(
            children: [
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(25),
                  color: const Color(0xFFE6E3DC).withOpacity(0.8),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.5),
                      spreadRadius: 5,
                      blurRadius: 7,
                      offset: Offset(0, 3), // changes position of shadow
                    ),
                  ],
                  image: DecorationImage(
                    alignment: Alignment.topCenter,
                    image: AssetImage("assets/images/wideart.png"),
                    fit: BoxFit.contain,
                  ),
                ),
                margin: const EdgeInsets.only(
                    top: 100.0, bottom: 100.0, right: 25.0, left: 25.0),
                child: Container(
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      alignment: Alignment.topLeft,
                      image: AssetImage("assets/images/rank_icon.png"),
                    ),
                  ),
                ),
              ),
            ],
          ),
          Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Expanded(
                child: Center(),
              ),
              Container(
                alignment: Alignment.bottomLeft,
                color: const Color(0xFFE6E3DC),
                height: 60,
                padding: const EdgeInsets.all(2),
                width: MediaQuery.of(context).size.width,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      color: const Color(0xFFCCCAC3),
                      margin: const EdgeInsets.all(5),
                      child: IconButton(
                        icon: Image.asset("assets/images/icons/user-solid.png"),
                        onPressed: () => {
                          debugPrint("User"),
                        },
                      ),
                    ),
                    Container(
                      margin: const EdgeInsets.all(5),
                      child: IconButton(
                        icon:
                            Image.asset("assets/images/icons/search-solid.png"),
                        onPressed: () => {
                          debugPrint("Search"),
                        },
                      ),
                    ),
                    Container(
                      margin: const EdgeInsets.all(5),
                      child: IconButton(
                        icon: Image.asset("assets/images/icons/cart-solid.png"),
                        onPressed: () => {
                          debugPrint("Store"),
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

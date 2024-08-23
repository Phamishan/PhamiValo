import 'package:flutter/material.dart';
import 'package:stroke_text/stroke_text.dart';

import 'package:PhamiValo/search.dart';
import 'package:PhamiValo/user.dart';
import 'package:PhamiValo/nightMarket.dart';

class Store extends StatelessWidget {
  const Store({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      body: Stack(
        alignment: Alignment.center,
        children: [
          Container(
            decoration: BoxDecoration(
              color: const Color(0xFFe6e3dc),
              image: DecorationImage(
                image: AssetImage("assets/images/vertical_phx.png"),
                fit: BoxFit.cover,
              ),
            ),
          ),
          Stack(
            children: [
              Container(
                decoration: BoxDecoration(
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.5),
                      spreadRadius: 5,
                      blurRadius: 7,
                      offset: Offset(0, 3), // changes position of shadow
                    ),
                  ],
                ),
              ),
              Container(
                margin: const EdgeInsets.all(25),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(25),
                  child: Image.asset(
                    "images/rgxBundle.png",
                    fit: BoxFit.contain,
                    alignment: Alignment.topCenter,
                  ),
                ),
                decoration: BoxDecoration(
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.8),
                      spreadRadius: 5,
                      blurRadius: 7,
                      offset: Offset(0, 5), // changes position of shadow
                    ),
                  ],
                ),
              ),
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(25),
                  color: const Color(0xFFE6E3DC).withOpacity(0.8),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.5),
                      spreadRadius: 5,
                      blurRadius: 7,
                      offset: Offset(0, 5), // changes position of shadow
                    ),
                  ],
                ),
                margin: const EdgeInsets.only(
                  top: 212,
                  bottom: 212,
                  right: 25,
                  left: 25,
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Container(
                      //margin: const EdgeInsets.only(bottom: 100),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Container(
                            child: Container(
                              width: 150,
                              height: 150,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(20.0),
                                color: Color.fromARGB(255, 0, 255, 47),
                              ),
                            ),
                          ),
                          Container(
                            child: Container(
                              width: 150,
                              height: 150,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(20.0),
                                color: Color.fromARGB(255, 255, 25, 0),
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                    Container(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Container(
                            child: Container(
                              width: 150,
                              height: 150,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(20.0),
                                color: Color.fromARGB(255, 0, 47, 255),
                              ),
                            ),
                          ),
                          Container(
                            child: Container(
                              width: 150,
                              height: 150,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(20.0),
                                color: Color.fromARGB(255, 255, 0, 221),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          Container(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Container(
                  padding: const EdgeInsets.only(bottom: 80),
                  child: Container(
                    width: 350,
                    height: 100,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20.0),
                      color: Color(0xFF33363F),
                      boxShadow: [
                        BoxShadow(
                          color: Color(0xFF33363F).withOpacity(0.5),
                          spreadRadius: 5,
                          blurRadius: 7,
                          offset: Offset(0, 3), // changes position of shadow
                        ),
                      ],
                    ),
                    alignment: Alignment.center,
                    child: TextButton(
                      onPressed: () => Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const Nightmarket()),
                      ),
                      child: const Text(
                        "NIGHT MARKET",
                        style: TextStyle(
                          fontSize: 36,
                          fontFamily: "JockeyOne",
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
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
                      margin: const EdgeInsets.all(5),
                      child: IconButton(
                        icon: Image.asset("assets/images/icons/user-solid.png"),
                        onPressed: () => Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => const User()),
                        ),
                      ),
                    ),
                    Container(
                      margin: const EdgeInsets.all(5),
                      child: IconButton(
                        icon:
                            Image.asset("assets/images/icons/search-solid.png"),
                        onPressed: () => Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const Search()),
                        ),
                      ),
                    ),
                    Container(
                      color: const Color(0xFFCCCAC3),
                      margin: const EdgeInsets.all(5),
                      child: IconButton(
                        icon: Image.asset("assets/images/icons/cart-solid.png"),
                        onPressed: () => Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const Store()),
                        ),
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

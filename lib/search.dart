import 'package:flutter/material.dart';
import 'package:stroke_text/stroke_text.dart';

import 'package:PhamiValo/store.dart';
import 'package:PhamiValo/user.dart';

class CustomPageRoute extends MaterialPageRoute {
  CustomPageRoute({builder}) : super(builder: builder);

  @override
  Duration get transitionDuration => const Duration(milliseconds: 0);
}

class Search extends StatelessWidget {
  const Search({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        title: TextField(
          decoration: InputDecoration(hintText: "Search..."),
          style: TextStyle(fontFamily: "JockeyOne", fontSize: 24),
        ),
        automaticallyImplyLeading: false,
        titleTextStyle: TextStyle(fontSize: 48),
        backgroundColor: const Color(0xFFE6E3DC),
        centerTitle: true,
        actions: [
          IconButton(
            icon: Image.asset("assets/images/icons/search-solid.png"),
            onPressed: () => {
              debugPrint("SEARCH"),
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
                fit: BoxFit.cover,
              ),
            ),
          ),
          Stack(
            children: [
              Container(
                decoration: BoxDecoration(
                  color: const Color(0xFFE6E3DC).withOpacity(0.8),
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
                      color: const Color(0xFFCCCAC3),
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

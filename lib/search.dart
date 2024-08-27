import 'package:flutter/material.dart';
import 'package:stroke_text/stroke_text.dart';
import 'package:http/http.dart' as http;

import 'dart:convert';

import 'package:PhamiValo/store.dart';
import 'package:PhamiValo/user.dart';

class CustomPageRoute extends MaterialPageRoute {
  CustomPageRoute({builder}) : super(builder: builder);

  @override
  Duration get transitionDuration => const Duration(milliseconds: 0);
}

class Search extends StatefulWidget {
  const Search({Key? key}) : super(key: key);

  @override
  _SearchState createState() => _SearchState();
}

class _SearchState extends State<Search> {
  TextEditingController _input = TextEditingController();

  final urlPlayerInfo = "https://phamivalo.onrender.com/PhamiValo/playerInfo";

  final urlRank = "https://phamivalo.onrender.com/PhamiValo/playerRank";

  final urlMatchList = "https://phamivalo.onrender.com/PhamiValo/getMatches";

  Map<String, dynamic> _playerInfoJson = {};
  Map<String, dynamic> _playerRankJson = {};
  List<String> _matchListJson = [];

  final matches = <Widget>[];

  Future<void> getPlayerInfo() async {
    try {
      final response = await http.post(
        Uri.parse(urlPlayerInfo),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(<String, dynamic>{
          'input': _input.text,
        }),
      );
      final jsonData = jsonDecode(response.body) as Map<String, dynamic>;

      setState(() {
        _playerInfoJson = jsonData;
      });
    } catch (e) {
      print("ERROR: $e");
    }
  }

  Future<void> getPlayerRank() async {
    try {
      final response = await http.post(
        Uri.parse(urlRank),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(<String, dynamic>{
          'input': _input.text,
        }),
      );
      final jsonData = jsonDecode(response.body) as Map<String, dynamic>;

      setState(() {
        _playerRankJson = jsonData;
      });
    } catch (e) {
      print("ERROR: $e");
    }
  }

  Future<void> getMatchList() async {
    try {
      final response = await http.post(
        Uri.parse(urlMatchList),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(<String, dynamic>{
          'input': _input.text,
        }),
      );
      final jsonData = jsonDecode(response.body) as Map<String, dynamic>;

      List<String> matchList = [];

      for (int i = 0; i < 5; i++) {
        for (int j = 0;
            j < jsonData['res']['data'][i]['players']['all_players'].length;
            j++) {
          if (jsonData['res']['data'][i]['players']['all_players'][j]
                  ['puuid'] ==
              _playerRankJson['res']['data']['puuid']) {
            if (jsonData['res']['data'][i]['players']['all_players'][j]
                        ['team'] ==
                    "Blue" &&
                jsonData['res']['data'][i]['teams']['blue']['has_won'] ==
                    false) {
              matchList.add(
                  "${jsonData['res']['data'][i]['teams']['blue']['rounds_won']} - ${jsonData['res']['data'][i]['teams']['blue']['rounds_lost']} LOSS");
            }

            if (jsonData['res']['data'][i]['players']['all_players'][j]
                        ['team'] ==
                    "Red" &&
                jsonData['res']['data'][i]['teams']['red']['has_won'] ==
                    false) {
              matchList.add(
                  "${jsonData['res']['data'][i]['teams']['red']['rounds_won']} - ${jsonData['res']['data'][i]['teams']['red']['rounds_lost']} LOSS");
            }

            if (jsonData['res']['data'][i]['players']['all_players'][j]
                        ['team'] ==
                    "Blue" &&
                jsonData['res']['data'][i]['teams']['blue']['has_won'] ==
                    true) {
              matchList.add(
                  "${jsonData['res']['data'][i]['teams']['blue']['rounds_won']} - ${jsonData['res']['data'][i]['teams']['blue']['rounds_lost']} WIN");
            }

            if (jsonData['res']['data'][i]['players']['all_players'][j]
                        ['team'] ==
                    "Red" &&
                jsonData['res']['data'][i]['teams']['red']['has_won'] == true) {
              matchList.add(
                  "${jsonData['res']['data'][i]['teams']['red']['rounds_won']} - ${jsonData['res']['data'][i]['teams']['red']['rounds_lost']} WIN");
            }
          }
        }
      }

      setState(() {
        _matchListJson.addAll(matchList);
      });
    } catch (e) {
      print("ERROR: $e");
    }
  }

  bool _isVisible = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        title: TextField(
          controller: _input,
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
            onPressed: () {
              getPlayerInfo();
              getPlayerRank();
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
              GestureDetector(
                onTap: () {
                  setState(() {
                    _isVisible = !_isVisible; // Toggle visibility
                  });
                },
                child: Opacity(
                  opacity: _isVisible
                      ? 1.0
                      : 0.0, // Change opacity based on visibility
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(25),
                      color: const Color(0xFFE6E3DC).withOpacity(0.8),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.5),
                          spreadRadius: 5,
                          blurRadius: 7,
                          offset: Offset(0, 3),
                        ),
                      ],
                    ),
                    margin: const EdgeInsets.only(
                      top: 100.0,
                      bottom: 100.0,
                      right: 25.0,
                      left: 25.0,
                    ),
                    child: SingleChildScrollView(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(25),
                              topRight: Radius.circular(25),
                            ),
                            child: Container(
                              child: _playerInfoJson.isEmpty
                                  ? Center(
                                      child: CircularProgressIndicator(
                                      color: Colors.black,
                                    ))
                                  : Image.network(
                                      _playerInfoJson['res']['data']['card']
                                          ['wide'],
                                      fit: BoxFit.fitWidth,
                                    ),
                            ),
                          ),
                          Container(
                            margin: const EdgeInsets.only(left: 15, right: 15),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Container(
                                  width: 100,
                                  height: 100,
                                  child: _playerRankJson.isEmpty
                                      ? Center(
                                          child: CircularProgressIndicator(
                                          color: Colors.black,
                                        ))
                                      : Image.network(
                                          _playerRankJson['res']['data']
                                                  ['current_data']['images']
                                              ['large'],
                                          fit: BoxFit.contain,
                                        ),
                                ),
                                Column(
                                  children: [
                                    Text(""),
                                  ],
                                ),
                                Column(
                                  children: [
                                    Container(
                                      child: Column(
                                        children: [
                                          _playerRankJson.isEmpty
                                              ? Center(
                                                  child:
                                                      CircularProgressIndicator(
                                                  color: Colors.black,
                                                ))
                                              : StrokeText(
                                                  text:
                                                      "${_playerRankJson['res']['data']['current_data']['currenttierpatched']}",
                                                  textStyle: TextStyle(
                                                    fontFamily: "Oswald",
                                                    color: Colors.black,
                                                    fontSize: 20,
                                                  ),
                                                ),
                                          _playerRankJson.isEmpty
                                              ? Center(
                                                  child:
                                                      CircularProgressIndicator(
                                                  color: Colors.black,
                                                ))
                                              : StrokeText(
                                                  text:
                                                      "${_playerRankJson['res']['data']['current_data']['ranking_in_tier']} RR",
                                                  textStyle: TextStyle(
                                                    fontFamily: "Oswald",
                                                    color: Colors.black,
                                                    fontSize: 16,
                                                  ),
                                                ),
                                        ],
                                      ),
                                    )
                                  ],
                                ),
                              ],
                            ),
                          ),
                          Container(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Column(
                                  children: [
                                    Container(
                                      margin: const EdgeInsets.all(15),
                                      alignment: Alignment.topLeft,
                                      child: _playerInfoJson.isEmpty
                                          ? Center(
                                              child: CircularProgressIndicator(
                                              color: Colors.black,
                                            ))
                                          : StrokeText(
                                              text:
                                                  "LEVEL: ${_playerInfoJson['res']['data']['account_level']}",
                                              textStyle: TextStyle(
                                                fontFamily: "Oswald",
                                                color: Colors.black,
                                                fontSize: 20,
                                              ),
                                            ),
                                    ),
                                  ],
                                ),
                                Column(
                                  children: [
                                    Text(""),
                                  ],
                                ),
                                Column(
                                  children: [
                                    Container(
                                      margin: const EdgeInsets.all(15),
                                      alignment: Alignment.bottomRight,
                                      child: StrokeText(
                                        text: "EPISODE 9 - ACT 1",
                                        textStyle: TextStyle(
                                          fontFamily: "Oswald",
                                          color: Colors.black,
                                          fontSize: 20,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                          Container(
                            margin: const EdgeInsets.all(5),
                            alignment: Alignment.center,
                            child: StrokeText(
                              text: "LAST 5 RANKED GAMES:",
                              textStyle: TextStyle(
                                fontFamily: "Oswald",
                                color: Colors.black,
                                fontSize: 20,
                              ),
                            ),
                          ),
                          Container(
                            margin: const EdgeInsets.only(bottom: 30),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                for (int i = 0; i < 5; i++)
                                  _matchListJson.isEmpty
                                      ? Center(
                                          child: CircularProgressIndicator(
                                          color: Colors.black,
                                        ))
                                      : StrokeText(
                                          text: "${_matchListJson[i]}",
                                          textStyle: TextStyle(
                                            fontSize: 20,
                                            fontFamily: "JockeyOne",
                                            color: Colors.black,
                                          ),
                                        ),
                              ],
                            ),
                          )
                        ],
                      ),
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

import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:stroke_text/stroke_text.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:PhamiValo/search.dart';
import 'package:PhamiValo/store.dart';

class User extends StatefulWidget {
  const User({super.key});

  @override
  State<User> createState() => _UserState();
}

class _UserState extends State<User> {
  final urlPlayerInfo =
      "https://d3d262f5-a02b-49c9-a036-6480023c4393-00-2egiss39iqtny.riker.replit.dev/PhamiValo/playerInfo";

  final urlRank =
      "https://d3d262f5-a02b-49c9-a036-6480023c4393-00-2egiss39iqtny.riker.replit.dev/PhamiValo/playerRank";

  final urlMatchList =
      "https://d3d262f5-a02b-49c9-a036-6480023c4393-00-2egiss39iqtny.riker.replit.dev/PhamiValo/getMatches";

  Map<String, dynamic> _playerInfoJson = {};
  Map<String, dynamic> _playerRankJson = {};
  List<String> _matchListJson = [];

  final matches = <Widget>[];

  void getPlayerInfo() async {
    try {
      final response = await http.get(Uri.parse(urlPlayerInfo));
      final jsonData = jsonDecode(response.body) as Map<String, dynamic>;

      setState(() {
        _playerInfoJson = jsonData;
      });
    } catch (e) {
      print("ERROR: $e");
    }
  }

  void getPlayerRank() async {
    try {
      final response = await http.get(Uri.parse(urlRank));
      final jsonData = jsonDecode(response.body) as Map<String, dynamic>;

      setState(() {
        _playerRankJson = jsonData;
      });
    } catch (e) {
      print("ERROR: $e");
    }
  }

  void getMatchList() async {
    try {
      final response = await http.get(Uri.parse(urlMatchList));
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

  @override
  void initState() {
    super.initState();
    getPlayerInfo();
    getPlayerRank();
    getMatchList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        title: _playerInfoJson.isEmpty
            ? Center(
                child: CircularProgressIndicator(
                color: Colors.black,
              ))
            : ListTile(
                contentPadding: EdgeInsets.only(left: 50),
                title: Center(
                  child: StrokeText(
                    text: "${_playerInfoJson['res']['data']['name']}" +
                        "#" +
                        "${_playerInfoJson['res']['data']['tag']}",
                    textStyle: TextStyle(
                        fontFamily: "Oswald",
                        color: Colors.white,
                        fontSize: 40),
                    strokeColor: Colors.black,
                    strokeWidth: 3,
                  ),
                ),
              ),
        automaticallyImplyLeading: false,
        backgroundColor: const Color(0xFFE6E3DC),
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
                fit: BoxFit.cover,
              ),
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
                                          ['current_data']['images']['large'],
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
                                              child: CircularProgressIndicator(
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
                                              child: CircularProgressIndicator(
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

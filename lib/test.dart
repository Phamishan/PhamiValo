import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart';

class MyApp extends StatefulWidget {
  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final url = Uri.parse(
      'https://api.henrikdev.xyz/valorant/v1/account/ph4m1/yin?api_key=HDEV-48c38b16-cdc8-4e54-8a86-eda4bec0d49b');
  Map<String, dynamic> _postJson = {};

  void fetchPost() async {
    try {
      final response = await get(url);
      final jsonData = jsonDecode(response.body) as Map<String, dynamic>;

      setState(() {
        _postJson = jsonData;
      });
    } catch (error) {
      print(error);
    }
  }

/*
for (int i = 0; i < 4; i++)
        for (int j = 0;
            j < jsonData['data'][i]['players']['all_players'].length;
            j++)
          if (jsonData['data'][i]['players']['all_players'][j] ==
              _playerInfoJson['data']['puuid']) if (jsonData['data'][i]
                      ['players']['all_players'][j]['team'] ==
                  "Blue" &&
              jsonData['data'][i]['teams']['blue']['has_won'] == false)
              */

  @override
  void initState() {
    super.initState();
    fetchPost();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: _postJson.isEmpty
            ? Center(child: CircularProgressIndicator())
            : ListView(
                children: [
                  ListTile(
                    title: Text(_postJson['data']['card']['small']),
                  ),
                ],
              ),
      ),
    );
  }
}

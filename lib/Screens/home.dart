import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  var liveScoreleaguename = [];

  bool isScoreLoading = true;
  getLiveScore() async {
    var headers = {
      'auth_type': 'email',
      'email': 'parveen1@yopmail.com',
      'dob': '02/02/2000',
      'password': '123123',
      'first_name': 'test',
      'last_name': 'test'
    };
    var request1 = http.Request(
        'GET',
        Uri.parse(
            'https://api.soccerdataapi.com/livescores/?auth_token=184c67b6e6f546650bee35d2ee6b8e1aba9f04a4'));

    request1.headers.addAll(headers);
    http.StreamedResponse response = await request1.send();

    if (response.statusCode == 200) {
      var res = await response.stream.bytesToString();
      var body = jsonDecode(res);

      setState(() {
        liveScoreleaguename = body;

        print('livescore=$liveScoreleaguename');

        isScoreLoading = false;
      });
    } else {
      print(response.reasonPhrase);
      setState(() {
        isScoreLoading = false;
      });
    }
  }

  TextEditingController search = TextEditingController();
  @override
  void initState() {
    getLiveScore();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          title: Text("League Scores"),
          centerTitle: true,
        ),
        body: SafeArea(
            child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Column(
            children: [
              Container(
                height: 55,
                child: TextFormField(
                  controller: search,
                  onChanged: (val) {
                    setState(() {});
                  },
                  maxLines: 1,
                  cursorColor: Colors.black,
                  decoration: InputDecoration(
                    fillColor: Colors.grey.shade200,
                    filled: true,
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: Colors.grey.shade200,
                      ),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: Colors.grey.shade200,
                      ),
                    ),
                    prefixIcon: Icon(
                      Icons.search,
                      color: Colors.grey,
                    ),
                    hintText: 'Search league...',
                    hintStyle: TextStyle(
                      color: Colors.grey,
                    ),
                    border: OutlineInputBorder(),
                  ),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              isScoreLoading
                  ? Center(child: CircularProgressIndicator())
                  : Expanded(
                      child: ListView.builder(
                          shrinkWrap: true,
                          itemCount: liveScoreleaguename.length,
                          itemBuilder: (context, index) {
                            if (
                                // liveScore[index]['stage']
                                //       .toLowerCase()
                                //       .contains(search.text.toLowerCase()) &&
                                //   liveScoreCountry[index]['country']
                                //       .toLowerCase()
                                //       .contains(search.text.toLowerCase()) &&
                                liveScoreleaguename[index]['league_name']
                                    .toLowerCase()
                                    .contains(search.text.toLowerCase())) {
                              return GestureDetector(
                                onTap: () {
                                  // Navigator.push(
                                  //     context,
                                  //     (
                                  //         builder: (context) => TopScoreScreen(
                                  //               leageKey:
                                  //                   liveScoreleaguename[index]
                                  //                       ['league_id'],
                                  //             )));
                                },
                                child: Container(
                                  width: MediaQuery.of(context).size.width,
                                  margin: const EdgeInsets.only(bottom: 15),
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 15, vertical: 10),
                                  decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(5),
                                      boxShadow: const [
                                        BoxShadow(
                                            color: Colors.black12,
                                            blurRadius: 6)
                                      ]),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Row(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          const Text(
                                            'league name: ',
                                          ),
                                          Spacer(),
                                          Text(
                                            liveScoreleaguename[index]
                                                    ['league_name']
                                                .toString(),
                                            style: const TextStyle(
                                                color: Colors.grey),
                                          ),
                                        ],
                                      ),
                                      const SizedBox(
                                        height: 5,
                                      ),
                                      Row(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          const Text('country name: '),
                                          Spacer(),
                                          Text(
                                            liveScoreleaguename[index]
                                                    ['country']['name']
                                                .toString(),
                                            style: const TextStyle(
                                                color: Colors.grey),
                                          ),
                                        ],
                                      ),
                                      const SizedBox(
                                        height: 5,
                                      ),
                                      Row(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          const Text('Stage: '),
                                          Spacer(),
                                          Text(
                                            liveScoreleaguename[index]['stage']
                                                    [0]['stage_name']
                                                .toString(),
                                            style: const TextStyle(
                                                color: Colors.grey),
                                          ),
                                        ],
                                      ),
                                      const SizedBox(
                                        height: 5,
                                      ),
                                      Row(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          const Text('Team Home: '),
                                          Spacer(),
                                          Text(
                                            liveScoreleaguename[index]['stage']
                                                        [0]['matches'][0]
                                                    ['teams']['home']['name']
                                                .toString(),
                                            style: const TextStyle(
                                                color: Colors.grey),
                                          ),
                                        ],
                                      ),
                                      const SizedBox(
                                        height: 5,
                                      ),
                                      Row(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          const Text('Team Away: '),
                                          Spacer(),
                                          Text(
                                            liveScoreleaguename[index]['stage']
                                                        [0]['matches'][0]
                                                    ['teams']['away']['name']
                                                .toString(),
                                            style: const TextStyle(
                                                color: Colors.grey),
                                          ),
                                        ],
                                      ),
                                      const SizedBox(
                                        height: 5,
                                      ),
                                      Row(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          const Text('Matches Time: '),
                                          Spacer(),
                                          Text(
                                            liveScoreleaguename[index]['stage']
                                                    [0]['matches'][0]['time']
                                                .toString(),
                                            style: const TextStyle(
                                                color: Colors.grey),
                                          ),
                                        ],
                                      ),
                                      const SizedBox(
                                        height: 5,
                                      ),
                                      Row(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          const Text('Matches Date: '),
                                          Spacer(),
                                          Text(
                                            liveScoreleaguename[index]['stage']
                                                    [0]['matches'][0]['date']
                                                .toString(),
                                            style: const TextStyle(
                                                color: Colors.grey),
                                          ),
                                        ],
                                      ),
                                      const SizedBox(
                                        height: 5,
                                      ),
                                      Row(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          const Text('Home Win Odds: '),
                                          Spacer(),
                                          Text(
                                            liveScoreleaguename[index]['stage']
                                                            [0]['matches'][0]
                                                        ['odds']['match_winner']
                                                    ['home']
                                                .toString(),
                                            style: const TextStyle(
                                                color: Colors.grey),
                                          ),
                                        ],
                                      ),
                                      const SizedBox(
                                        height: 5,
                                      ),
                                      Row(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          const Text('Away Win Odds: '),
                                          Spacer(),
                                          Text(
                                            liveScoreleaguename[index]['stage']
                                                            [0]['matches'][0]
                                                        ['odds']['match_winner']
                                                    ['away']
                                                .toString(),
                                            style: const TextStyle(
                                                color: Colors.grey),
                                          ),
                                        ],
                                      ),
                                      const SizedBox(
                                        height: 5,
                                      ),
                                      Row(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          const Text('Draw: '),
                                          Spacer(),
                                          Text(
                                            liveScoreleaguename[index]['stage']
                                                            [0]['matches'][0]
                                                        ['odds']['match_winner']
                                                    ['draw']
                                                .toString(),
                                            style: const TextStyle(
                                                color: Colors.grey),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              );
                            } else {
                              return Container();
                            }
                          }),
                    ),
            ],
          ),
        )));
  }
}

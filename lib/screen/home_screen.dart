import 'dart:convert' show jsonDecode;

import 'package:cached_network_image/cached_network_image.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'detail_screen.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List? pokedex;

  @override
  void initState() {
    super.initState();
    if (mounted) {
      fetchPokemonData();
    }
  }

  static Color getcolor(String type) {
    switch (type) {
      case 'Grass':
        return Colors.greenAccent;
      case 'Fire':
        return Colors.redAccent;
      case 'Water':
        return Colors.blue;
      case 'Poison':
        return Colors.deepPurpleAccent;
      case 'Electric':
        return Colors.amber;
      case 'Rock':
        return Colors.grey;
      case 'Ground':
        return Colors.brown;
      case 'Psychic':
        return Colors.indigo;
      case 'Fighting':
        return Colors.orange;
      case 'Bug':
        return Colors.lightGreenAccent;
      case 'Ghost':
        return Colors.deepPurple;
      case 'Normal':
        return Colors.black26;
      default:
        return Colors.pink;
    }
  }

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;

    Color _greenColor = Color(0xff2a9d8f);
    Color _redColor = Color(0xffe76f51);
    Color _blueColor = Color(0xff37A5C6);

    return Scaffold(
        appBar: AppBar(
            elevation: 0,
            backgroundColor: Colors.white,
            centerTitle: false,
            title: const Padding(
              padding: EdgeInsets.only(left: 10),
              child: Text(
                'Pokedex',
                style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                  fontSize: 30,
                ),
              ),
            )),
        backgroundColor: Colors.white,
        body: Stack(children: [
          Positioned(
            top: -50,
            right: -50,
            child: Image.asset(
              'images/pokeball.png',
              width: 200,
              fit: BoxFit.fitWidth,
            ),
          ),
          // Positioned(
          //   top: 100,
          //   left: 20,
          //   child: Text(
          //     'Pokedex',
          //     style: TextStyle(
          //       color: Colors.black.withOpacity(0.6),
          //       fontWeight: FontWeight.bold,
          //       fontSize: 30,
          //     ),
          //   ),
          // ),
          // Positioned(
          //   top: 40,
          //   left: 30,
          //   child: ElevatedButton(
          //       onPressed: () {
          //         FirebaseAuth.instance.signOut();
          //       },
          //       child: null),
          // ),
          Positioned(
            top: 150,
            bottom: 0,
            width: width,
            child: Column(
              children: [
                pokedex != null
                    ? Expanded(
                        child: GridView.builder(
                            gridDelegate:
                                const SliverGridDelegateWithFixedCrossAxisCount(
                                    crossAxisCount: 2, childAspectRatio: 1.4),
                            shrinkWrap: true,
                            physics: BouncingScrollPhysics(),
                            itemCount: pokedex?.length,
                            itemBuilder: (context, index) {
                              return Padding(
                                padding: const EdgeInsets.symmetric(
                                    vertical: 5, horizontal: 5),
                                child: InkWell(
                                  child: SafeArea(
                                    child: Container(
                                      decoration: BoxDecoration(
                                          color: getcolor(
                                              pokedex?[index]['type'][0]),
                                          borderRadius: const BorderRadius.all(
                                              Radius.circular(25))),
                                      child: Stack(
                                        children: [
                                          Positioned(
                                            bottom: -10,
                                            right: -10,
                                            child: Image.asset(
                                              'images/pokeball.png',
                                              height: 100,
                                              fit: BoxFit.fitHeight,
                                            ),
                                          ),
                                          Positioned(
                                            bottom: 5,
                                            right: 5,
                                            child: Hero(
                                              tag: index,
                                              child: CachedNetworkImage(
                                                  imageUrl: pokedex?[index]
                                                      ['img'],
                                                  height: 100,
                                                  fit: BoxFit.fitHeight,
                                                  placeholder: (context, url) =>
                                                      const Center(
                                                        child:
                                                            CircularProgressIndicator(),
                                                      )),
                                            ),
                                          ),
                                          Positioned(
                                            top: 55,
                                            left: 15,
                                            child: Container(
                                              decoration: BoxDecoration(
                                                  borderRadius:
                                                      const BorderRadius.all(
                                                          Radius.circular(20)),
                                                  color: Colors.black
                                                      .withOpacity(0.5)),
                                              child: Padding(
                                                padding: const EdgeInsets.only(
                                                    left: 10.0,
                                                    right: 10,
                                                    top: 5,
                                                    bottom: 5),
                                                child: Text(
                                                  pokedex?[index]['type'][0],
                                                  style: const TextStyle(
                                                      color: Colors.white,
                                                      shadows: [
                                                        BoxShadow(
                                                            color:
                                                                Colors.blueGrey,
                                                            offset:
                                                                Offset(0, 0),
                                                            spreadRadius: 1.0,
                                                            blurRadius: 15)
                                                      ]),
                                                ),
                                              ),
                                            ),
                                          ),
                                          Positioned(
                                            top: 30,
                                            left: 15,
                                            child: Text(
                                              pokedex?[index]['name'],
                                              style: const TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 18,
                                                  color: Colors.white,
                                                  shadows: [
                                                    BoxShadow(
                                                        color: Colors.blueGrey,
                                                        offset: Offset(0, 0),
                                                        spreadRadius: 1.0,
                                                        blurRadius: 15)
                                                  ]),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                  onTap: () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (_) => DetailScreen(
                                                heroTag: index,
                                                pokemonDetail: pokedex?[index],
                                                color: getcolor(pokedex?[index]
                                                    ['type'][0]))));
                                  },
                                ),
                              );
                            }))
                    : const Center(
                        child: CircularProgressIndicator(),
                      )
              ],
            ),
          ),
          Positioned(
            top: 0,
            child: Container(
              height: 150,
              width: width,
            ),
          ),
        ]));
  }

  void fetchPokemonData() {
    var url = Uri.https('raw.githubusercontent.com',
        '/Biuni/PokemonGO-Pokedex/master/pokedex.json');
    http.get(url).then((value) {
      if (value.statusCode == 200) {
        var data = jsonDecode(value.body);
        pokedex = data['pokemon'];

        setState(() {});

        // print(pokedex);
      }
    }).catchError((e) {
      print(e);
    });
  }
}

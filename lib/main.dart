import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:pokemon_api/pokemonDetail.dart';

import 'pokemon.dart';


void main() => runApp(MaterialApp(
    title: 'Pokemon App',
    home: HomePage(),

    debugShowCheckedModeBanner: false,
));

class HomePage extends StatefulWidget{
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
    var url = Uri.parse('https://raw.githubusercontent.com/Biuni/PokemonGO-Pokedex/master/pokedex.json');
    PokeHub pokeHub;
    @override
      void initState() {

        super.initState();
        fetchData();
      }

      fetchData() async {
          var res = await http.get(url);
          var decodedJson = jsonDecode(res.body);
          pokeHub = PokeHub.fromJson(decodedJson);
          print(pokeHub.toJson());
          setState(() {});
      }

    @override
    Widget build(BuildContext context){
        return Scaffold(
            appBar: AppBar(title: Text("Poke App"), backgroundColor: Colors.cyan),
            floatingActionButton: FloatingActionButton(onPressed: (){},child: Icon(Icons.refresh),),
            body: pokeHub == null ? Center(child: CircularProgressIndicator()) : GridView.count(crossAxisCount: 2,
              children: pokeHub.pokemon.map((poke) =>
                  Padding(
                      padding: EdgeInsets.all(2),
                      child:InkWell (
                          onTap : () {
                            Navigator.push(context, MaterialPageRoute(builder:  (context) =>
                              PokeDetail(pokemon:  poke,)
                            ));
                          },
                          child: Hero(
                          tag: poke.img,
                          child: Card(
                        elevation: 3.0,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Container(
                              height: 100,
                              width: 100,
                              decoration: BoxDecoration(
                                image: DecorationImage(image:  NetworkImage(
                                  poke.img
                                ))
                              ),
                            ),
                            Text(poke.name,
                                style: TextStyle(fontSize: 20,
                                    fontWeight: FontWeight.bold)
                            )
                          ],
                        )
                      )))
                  )
              ).toList(),
            )
        );
    }
}
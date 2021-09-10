import 'package:flutter/material.dart';
import 'package:pokemon_api/pokemon.dart';

class PokeDetail extends StatelessWidget {
  const PokeDetail({Key  key, this.pokemon}) : super(key: key);

  final Pokemon pokemon;
  bodyWidget(BuildContext context) => Stack(
    children: [
      Positioned(
        height: MediaQuery.of(context).size.height/1.5,
        width: MediaQuery.of(context).size.width - 20,
        top: MediaQuery.of(context).size.height * 0.1,
        left: 10,
        child: Card(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15)
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              SizedBox(height: 80),
              Text(pokemon.name, style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),),
              Text("Altura: ${pokemon.height}"),
              Text("Peso: ${pokemon.weight}"),
              Text("Tipos"),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children:pokemon.type.map((t) => FilterChip(
                backgroundColor: Colors.amber,
                label: Text(t) ,onSelected: (b) {},
              )).toList()
            ),
              Text("Debilidades"),
              Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children:pokemon.weaknesses.map((w) => FilterChip(
                    backgroundColor:  Colors.red,
                    label: Text(w, style: TextStyle(color: Colors.white),) ,onSelected: (b) {},
                  )).toList()
              ),
              Text("Evoluciones"),
              Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: pokemon.nextEvolution == null ? <Widget>[Text("This is the final form")] : pokemon.nextEvolution.map((n) => FilterChip(
                    backgroundColor: Colors.green,
                    label: Text(n.name, style: TextStyle(color: Colors.white)) ,onSelected: (b) {},
                  )).toList()
              ),
            ],
          )
        ),
      ),
      Align(
        alignment: Alignment.topCenter,
        child: Hero(
          tag: pokemon.img,
          child: Container(
            height: 200,
            width: 200,
            decoration: BoxDecoration(
              image: DecorationImage(
                  fit: BoxFit.cover,
                  image: NetworkImage(pokemon.img))
            ),
          ),
        ),
      )
    ],
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.cyan,
      appBar: AppBar(
        backgroundColor: Colors.cyan,
        title: Text(pokemon.name),),
      body:  bodyWidget(context),
    );
  }
}

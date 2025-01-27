import 'package:flutter/material.dart';

class Album extends StatelessWidget {
  Album({Key? key, this.nomAlbum, this.description, this.nomGroupe, this.image})
      : super(key: key);
  final String? nomAlbum;
  final String? description;
  final int? nomGroupe;
  final String? image;

  Widget build(BuildContext context) {
    return

      Container(
        padding: EdgeInsets.all(2), height: 120,  child: Card(
        child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly, children:    <Widget>[
          Image.asset("images/" +image!), Expanded(
              child: Container(
                  padding: EdgeInsets.all(5), child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[

                  Text(this.nomAlbum!, style: TextStyle(fontWeight:
                  FontWeight.bold)), Text(this.description!),
                  Text("Valeur: " + this.nomGroupe.toString()),
                ],
              )
              )
          )
        ]
        )
    )
    );
  }
}

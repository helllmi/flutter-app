import 'package:flutter/material.dart';

class Acceuil extends StatelessWidget {
  const Acceuil({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: 110,
        decoration: BoxDecoration(color: Colors.blue.shade900),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center, // Centre les éléments
          children: <Widget>[
            // Bouton dans un Stack
            Stack(
              alignment: Alignment.center, // Correction de l'alignement
              children: [
                Container(
                  width: 40,
                  height: 50,
                  decoration: BoxDecoration(
                    color: const Color.fromARGB(223, 158, 158, 158),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  padding: const EdgeInsets.all(1),
                  margin: const EdgeInsets.only(left: 20, right: 20, top: 40, bottom: 20),
                  child: IconButton(
                    icon: const Icon(Icons.more_vert),
                    color: Colors.black,
                    iconSize: 25,
                    onPressed: () {},
                  ),
                ),
              ],
            ),

            
            Container(
              width: 160,
              height: 50,
              decoration: BoxDecoration(
                color: const Color.fromARGB(223, 158, 158, 158),
                borderRadius: const BorderRadius.all(Radius.circular(12)),
              ),
              margin: const EdgeInsets.only(left: 20, right: 20, top: 45, bottom: 20),
              child: TextField(
                decoration: InputDecoration(icon:Icon(Icons.search),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  hintText: 'Rechercher ',
                  filled: true,
                  fillColor:const Color.fromARGB(223, 158, 158, 158),
                ),
              ),
            ),
            Stack(
              alignment: Alignment.center, 
              children: [
                Container(
                  width: 40,
                  height: 50,
                  decoration: BoxDecoration(
                    color: const Color.fromARGB(223, 158, 158, 158),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  padding: const EdgeInsets.all(1),
                  margin: const EdgeInsets.only(left: 20, right: 20, top: 40, bottom: 20),
                  child: IconButton(
                    icon: const Icon(Icons.notifications),
                    color: Colors.black,
                    iconSize: 25,
                    onPressed: () {},
                  ),
                ),
              ],
            ),
            
          ],
        ),
      ),
    );
  }
}

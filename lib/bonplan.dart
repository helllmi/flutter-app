import 'package:flutter/material.dart';
import 'package:weshare/API/maps_resto.dart';
import 'package:weshare/import_photo.dart';
// ignore: depend_on_referenced_packages, unused_import


void main() {
  runApp(const Page2());
}

class Page2 extends StatefulWidget {
  const Page2({super.key});

  @override
  State<Page2> createState() => _Page2State();
}

class _Page2State extends State<Page2> {
  get onPressed => null;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Ajouter un bon plan"),
        centerTitle: true,
        backgroundColor: Colors.blue.shade900,
        toolbarHeight: 60,
      ),
      body: Column(children: [
        Container(
          width: 250,
          height: 110,
          decoration: BoxDecoration(
            color: Colors.white,
            border: Border.all(color: Colors.blue.shade900, width: 2.0,style: BorderStyle.solid),
            borderRadius: BorderRadius.circular(20),
            boxShadow: [
              BoxShadow(
                color: Colors.black
                    .withOpacity(0.3), // Couleur de l'ombre avec transparence
                spreadRadius: 1, // Diffusion de l'ombre
                blurRadius: 10, // Flou de l'ombre
                offset: const Offset(
                    5, 5), // Décalage de l'ombre (horizontal, vertical)
              ),
            ],
          ),
          margin: const EdgeInsets.only(left: 50, top: 40, right: 40),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(
                Icons.camera_enhance_outlined,
                size: 35,
              ),
              const SizedBox(
                width: 40,
              ),
              ElevatedButton(
                  onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => ImportPhoto()),
          );},
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blue.shade900,
                    padding: EdgeInsets.all(10),
                  ),
                  child: Text(
                    "Prendre une photo",
                    style: TextStyle(
                        color: Colors.white, fontStyle: FontStyle.italic),
                  ))
            ],
          ),
        ),
        Container(
          width: 250,
          height: 110,
          decoration: BoxDecoration(
             color: Colors.white,
            border: Border.all(color: Colors.blue.shade900, width: 2.0,style: BorderStyle.solid),
            borderRadius: BorderRadius.circular(20),
            boxShadow: [
              BoxShadow(
                color: Colors.black
                    // ignore: deprecated_member_use
                    .withOpacity(0.3), // Couleur de l'ombre avec transparence
                spreadRadius: 1, // Diffusion de l'ombre
                blurRadius: 10, // Flou de l'ombre
                offset: const Offset(
                    5, 5), // Décalage de l'ombre (horizontal, vertical)
              ),
            ],
          ),
          margin: const EdgeInsets.only(left: 50, top: 40, right: 40),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(
                Icons.star_half,
                size: 35,
              ),
              SizedBox(
                width: 40,
              ),
              ElevatedButton(
                  onPressed: () {},
                  child: Text(
                    "Donner votre avis",
                    style: TextStyle(
                        color: Colors.white, fontStyle: FontStyle.italic),
                  ),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blue.shade900,
                    padding: EdgeInsets.all(10),
                  ))
            ],
          ),
        ),
        Container(
          width: 250,
          height: 110,
          decoration: BoxDecoration(
              color: Colors.white,
            border: Border.all(color: Colors.blue.shade900, width: 2.0,style: BorderStyle.solid),
            borderRadius: BorderRadius.circular(20),
            boxShadow: [
              BoxShadow(
                color: Colors.black
                    .withOpacity(0.3), // Couleur de l'ombre avec transparence
                spreadRadius: 1, // Diffusion de l'ombre
                blurRadius: 10, // Flou de l'ombre
                offset: const Offset(
                    5, 5), // Décalage de l'ombre (horizontal, vertical)
              ),
            ],
          ),
          margin: const EdgeInsets.only(left: 50, top: 40, right: 40),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(
                Icons.restaurant_outlined,
                size: 35,
              ),
              SizedBox(
                width: 40,
              ),
              ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => ImportPhoto()),
                    );
                  },
                  child: Text(
                    "Ajouter un menu",
                    style: TextStyle(
                        color: Colors.white, fontStyle: FontStyle.italic),
                  ),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blue.shade900,
                    padding: EdgeInsets.all(10),
                  ))
            ],
          ),
        ),
        Container(
          width: 250,
          height: 110,
          decoration: BoxDecoration(
              color: Colors.white,
            border: Border.all(color: Colors.blue.shade900, width: 2.0,style: BorderStyle.solid),
            borderRadius: BorderRadius.circular(20),
            boxShadow: [
              BoxShadow(
                color: Colors.black
                    .withOpacity(0.3), // Couleur de l'ombre avec transparence
                spreadRadius: 1, // Diffusion de l'ombre
                blurRadius: 10, // Flou de l'ombre
                offset: const Offset(
                    5, 5), // Décalage de l'ombre (horizontal, vertical)
              ),
            ],
          ),
          margin: const EdgeInsets.only(left: 50, top: 40, right: 40),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(
                Icons.home_outlined,
                size: 35,
              ),
              SizedBox(
                width: 40,
              ),
              ElevatedButton(
                  onPressed: () { Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const MapsResto()),
                  );},
                  child: Text(
                    "Ajouter un restaurant",
                    style: TextStyle(
                        color: Colors.white, fontStyle: FontStyle.italic),
                  ),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blue.shade900,
                    padding: const EdgeInsets.all(10),
                  ))
            ],
          ),
        ),
      ]),
    );
  }
}

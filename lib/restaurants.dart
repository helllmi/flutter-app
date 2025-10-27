import 'package:flutter/material.dart';
import 'package:weshare/main.dart';
import 'package:weshare/bonplan.dart';
import 'package:weshare/InteractionPage.dart';

class RestaurantPage extends StatelessWidget {
  final List<Map<String, dynamic>> restaurants = [
    {
      "name": "The Castle",
      "category": "Café restau",
      "image": "assets/thecastle.jpg",
      "address": "Kantaoui 4089, Hammam Sousse",
      "phone": "26 300 020"
    },
    {
      "name": "Biscottino's",
      "category": "Café",
      "image": "assets/biscottinos.jpg",
      "address": "Rue Imam Boukhari, Sousse",
      "phone": "27 500 030"
    },
    {
      "name": "Le Gourmet",
      "category": "Restaurant",
      "image": "assets/gourmand.jpg",
      "address": "Avenue Habib Bourguiba, Sousse",
      "phone": "73 456 789"
    }
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Stack(
            alignment: Alignment.center,
            children: [
              Container(
                height: 220,
                decoration: BoxDecoration(
                  color: Colors.blue[900],
                  borderRadius: BorderRadius.vertical(bottom: Radius.circular(40)),
                ),
              ),
              Positioned(
                left: 15,
                top: 50,
                child: IconButton(
                  icon: Icon(Icons.arrow_back, color: Colors.white, size: 30),
                  onPressed: () {},
                ),
              ),
              Positioned(
                right: 15,
                top: 50,
                child: IconButton(
                  icon: Icon(Icons.settings, color: Colors.white, size: 30),
                  onPressed: () {Navigator.push(context, MaterialPageRoute(builder: (context)=> HomeScreen()));},
                ),
              ),
              Positioned(
                top: 70,
                child: CircleAvatar(
                  radius: 45,
                  backgroundImage: AssetImage('assets/lazania.jpg'),
                ),
              ),
              Positioned(
                bottom: -10,
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 30, vertical: 10),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(30),
                    boxShadow: [
                      BoxShadow(color: Colors.black26, blurRadius: 5, spreadRadius: 2),
                    ],
                  ),
                  child: Text(
                    "RESTAURANTS",
                    style: TextStyle(color: Colors.blue[900], fontWeight: FontWeight.bold, fontSize: 18),
                  ),
                ),
              ),
            ],
          ),
          Expanded(
            child: ListView.builder(
              padding: EdgeInsets.all(15),
              itemCount: restaurants.length,
              itemBuilder: (context, index) {
                var restaurant = restaurants[index];
                return Card(
                  margin: EdgeInsets.only(bottom: 15),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
                  elevation: 3,
                  child: Column(
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.vertical(top: Radius.circular(15)),
                        child: Image.asset(restaurant["image"], height: 150, width: double.infinity, fit: BoxFit.cover),
                      ),
                      Padding(
                        padding: EdgeInsets.all(10),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(restaurant["name"], style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                            SizedBox(height: 5),
                            Container(
                              padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                              decoration: BoxDecoration(
                                color: Colors.blue[900],
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: Text(restaurant["category"], style: TextStyle(color: Colors.white, fontSize: 14)),
                            ),
                            SizedBox(height: 8),
                            Row(
                              children: [
                                Icon(Icons.location_on, color: Colors.black54, size: 16),
                                SizedBox(width: 5),
                                Expanded(child: Text(restaurant["address"], style: TextStyle(color: Colors.black54))),
                              ],
                            ),
                            Row(
                              children: [
                                Icon(Icons.phone, color: Colors.black54, size: 16),
                                SizedBox(width: 5),
                                Text(restaurant["phone"], style: TextStyle(fontWeight: FontWeight.bold)),
                              ],
                            ),
                            SizedBox(height: 8),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                ElevatedButton(
                                  onPressed: () {},
                                  child: Text("Menu",style: TextStyle(color: Colors.white)),
                                  style: ElevatedButton.styleFrom(backgroundColor: Colors.blue[900]),
                                ),
                                ElevatedButton(
                                  onPressed: () {
                                    Navigator.push(context, MaterialPageRoute(builder: (context)=> InteractionPage()));
                                  },
                                  child: Text("Interagir",style: TextStyle(color: Colors.white)),
                                  style: ElevatedButton.styleFrom(backgroundColor: Colors.blue[900]),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => Page2()),
          );
        },
        backgroundColor: Colors.white,
        shape: CircleBorder(),
        child: Icon(Icons.add, color: Colors.blue[900], size: 30),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: BottomAppBar(
        shape: CircularNotchedRectangle(),
        color: Colors.blue[900],
        notchMargin: 6,
        child: Container(height: 50),
      ),
    );
  }
}
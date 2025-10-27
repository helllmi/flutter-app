import 'package:flutter/material.dart';

class InteractionPage extends StatefulWidget {
  @override
  _InteractionPageState createState() => _InteractionPageState();
}

class _InteractionPageState extends State<InteractionPage> {
  final TextEditingController _commentController = TextEditingController();

  List<Map<String, dynamic>> reviews = [
    {"name": "Israa", "comment": "Very nice", "rating": 5.0},
    {"name": "Helmi", "comment": "Accueil chaleureux", "rating": 4.0},
    {"name": "Intidhar", "comment": "Un bon plan", "rating": 4.5},
  ];

  void _addComment() {
    String text = _commentController.text.trim();
    if (text.isNotEmpty) {
      setState(() {
        reviews.add({
          "name": "Vous", // Tu peux modifier le nom ici
          "comment": text,
          "rating": 4.0, // Note fixe ou tu peux ajouter un champ plus tard
        });
        _commentController.clear();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(20),
                child: Image.asset(
                  'assets/thecastle.jpg',
                  height: 200,
                  width: double.infinity,
                  fit: BoxFit.cover,
                ),
              ),
              SizedBox(height: 16),
              Text(
                "The Castle",
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 8),
              Row(
                children: [
                  SizedBox(width: 8),
                  Text("3.5 (147 avis)", style: TextStyle(color: Colors.grey)),
                ],
              ),
              SizedBox(height: 16),
              Text(
                "Avis des clients :",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.blue[900]),
              ),
              SizedBox(height: 10),
              Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black12,
                      blurRadius: 6,
                      spreadRadius: 1,
                    ),
                  ],
                ),
                padding: EdgeInsets.all(12),
                child: Column(
                  children: reviews
                      .map((review) => Column(
                    children: [
                      _buildReview(review["name"], review["comment"], review["rating"]),
                      if (review != reviews.last) Divider(),
                    ],
                  ))
                      .toList(),
                ),
              ),
              SizedBox(height: 20),
              TextField(
                controller: _commentController,
                decoration: InputDecoration(
                  hintText: "Commenter...",
                  filled: true,
                  fillColor: Colors.grey[200],
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(30),
                    borderSide: BorderSide.none,
                  ),
                ),
              ),
              SizedBox(height: 10),
              ElevatedButton(
                onPressed: _addComment,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue[900],
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                ),
                child: Padding(
                  padding: EdgeInsets.symmetric(vertical: 12),
                  child: Center(
                    child: Text("Donner un avis", style: TextStyle(fontSize: 16, color: Colors.white)),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildReview(String name, String comment, double rating) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(name, style: TextStyle(fontWeight: FontWeight.bold)),
        SizedBox(height: 4),
        Text(comment, style: TextStyle(color: Colors.grey[700])),
      ],
    );
  }
}

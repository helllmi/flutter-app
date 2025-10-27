import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'firebase_options.dart';
import 'package:weshare/bonplan.dart';
import 'package:weshare/login.dart';
import 'package:weshare/profil.dart';
import 'package:weshare/acceuil.dart';
import 'package:weshare/restaurants.dart';
import 'package:weshare/homepage.dart';

void main() async {
  try {
    WidgetsFlutterBinding.ensureInitialized();
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );
    runApp(const MyApp());
  } catch (e) {
    print('Erreur d\'initialisation Firebase: $e');
  }
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: StreamBuilder<User?>(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          
          if (snapshot.hasError) {
            return const Center(child: Text('Une erreur est survenue'));
          }
          
          // Si l'utilisateur est connecté
          if (snapshot.hasData && snapshot.data != null) {
            return  RestaurantPage();
          }
          
          // Si l'utilisateur n'est pas connecté
          return LoginPage();
        },
      ),
    );
  }
}

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        children: [
          
          Container(
            width: double.infinity, 
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: Colors.blue.shade900,
              borderRadius: const BorderRadius.only(
                bottomLeft: Radius.circular(30),
                bottomRight: Radius.circular(30),
              ),
            ),
            child: const Column(
              children: [
                CircleAvatar(
                  radius: 30,
                  backgroundColor: Colors.white,
                  child: Icon(Icons.person, size: 40, color: Colors.black),
                ),
                SizedBox(height: 10),
                Text(
                  'Helmi Bouhlel',
                  style: TextStyle(color: Colors.white, fontSize: 18),
                ),
              ],
            ),
          ),
          const SizedBox(height: 20),

          // Liste des menus (prennent toute la largeur)
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                buildMenuItem(Icons.person, 'Profil', () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const MyProfil()),
                  );
                }),
                const SizedBox(height: 30),
                buildMenuItem(Icons.favorite, 'Favoris', () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const MyProfil()),
                  );
                }),
                const SizedBox(height: 30),
                buildMenuItem(Icons.notifications, 'Notifications',  () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const Acceuil()),
                  );
                }),
                const SizedBox(height: 30),
                buildMenuItem(Icons.logout, 'Déconnexion', () async {
                  try {
                    await FirebaseAuth.instance.signOut();
                    // ignore: use_build_context_synchronously
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(builder: (context) => LoginPage()),
                    );
                  } catch (e) {
                    print('Erreur lors de la déconnexion: $e');
                  }
                }),
              ],
            ),
          ),

          // Bas de l'écran avec bouton (prend toute la largeur)
          Container(
            width: double.infinity, // Prend toute la largeur
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: Colors.blue.shade900,
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(30),
                topRight: Radius.circular(30),
              ),
            ),
            child: Center(
              child: FloatingActionButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const Page2()),
                  );
                },
                backgroundColor: Colors.white,
                child: Icon(Icons.add, color: Colors.blue.shade900),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget buildMenuItem(IconData icon, String title, VoidCallback onTap) {
    return SizedBox(
      width: double.infinity, 
      child: ListTile(
        leading: Icon(icon, color: Colors.blue.shade900),
        title: Text(
          title,
          style: const TextStyle(fontSize: 16, fontStyle: FontStyle.italic),
        ),
        onTap: onTap,
      ),
    );
  }
}

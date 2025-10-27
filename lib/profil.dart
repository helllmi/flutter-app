import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart';

void main() {
  runApp(const MyProfil());
}

class MyProfil extends StatelessWidget {
  const MyProfil({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: ProfilScreen(),
    );
  }
}

class ProfilScreen extends StatefulWidget {
  const ProfilScreen({super.key});

  @override
  _ProfilScreenState createState() => _ProfilScreenState();
}

class _ProfilScreenState extends State<ProfilScreen> {
  final _auth = FirebaseAuth.instance;
  final _firestore = FirebaseFirestore.instance;
  final _storage = FirebaseStorage.instance;

  final _titreController = TextEditingController();
  final _preferencesController = TextEditingController();
  final _pseudoController = TextEditingController();
  final _prenomController = TextEditingController();
  final _nomController = TextEditingController();
  final _emailController = TextEditingController();
  final _telephoneController = TextEditingController();
  final _gouvernoratController = TextEditingController();

  String? _imageUrl;
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    _loadUserData();
  }

  Future<void> _loadUserData() async {
    final user = _auth.currentUser;
    if (user != null) {
      try {
        final userData = await _firestore.collection('users').doc(user.uid).get();
        if (userData.exists) {
          setState(() {
            _titreController.text = userData.get('titre') ?? '';
            _preferencesController.text = userData.get('preferences') ?? '';
            _pseudoController.text = userData.get('pseudo') ?? '';
            _prenomController.text = userData.get('prenom') ?? '';
            _nomController.text = userData.get('nom') ?? '';
            _emailController.text = user.email ?? '';
            _telephoneController.text = userData.get('telephone') ?? '';
            _gouvernoratController.text = userData.get('gouvernorat') ?? '';
            _imageUrl = userData.get('photoUrl');
          });
        }
      } catch (e) {
        print('Erreur lors du chargement des données: $e');
      }
    }
  }

  Future<void> _pickAndUploadImage() async {
    final ImagePicker picker = ImagePicker();
    try {
      final XFile? image = await picker.pickImage(source: ImageSource.gallery);
      if (image == null) return;

      setState(() => _isLoading = true);

      final user = _auth.currentUser;
      if (user == null) return;

      final ref = _storage.ref().child('profile_images/${user.uid}');
      await ref.putFile(File(image.path));
      final url = await ref.getDownloadURL();

      await _firestore.collection('users').doc(user.uid).update({
        'photoUrl': url,
      });

      setState(() {
        _imageUrl = url;
        _isLoading = false;
      });
    } catch (e) {
      print('Erreur lors du téléchargement de l\'image: $e');
      setState(() => _isLoading = false);
    }
  }

  Future<void> _saveUserData() async {
    final user = _auth.currentUser;
    if (user == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Vous devez être connecté pour effectuer cette action')),
      );
      return;
    }

    if (_isLoading) return;

    setState(() {
      _isLoading = true;
    });

    try {
      // Validation des champs obligatoires
      if (_prenomController.text.trim().isEmpty || _nomController.text.trim().isEmpty) {
        throw Exception('Le prénom et le nom sont obligatoires');
      }

      final userDocRef = _firestore.collection('users').doc(user.uid);

      final userData = {
        'titre': _titreController.text.trim(),
        'preferences': _preferencesController.text.trim(),
        'pseudo': _pseudoController.text.trim(),
        'prenom': _prenomController.text.trim(),
        'nom': _nomController.text.trim(),
        'email': user.email,
        'telephone': _telephoneController.text.trim(),
        'gouvernorat': _gouvernoratController.text.trim(),
        'updatedAt': FieldValue.serverTimestamp(),
      };

      // Vérifier si le document existe
      final userDoc = await userDocRef.get();

      if (!userDoc.exists) {
        // Créer un nouveau document avec toutes les données nécessaires
        userData['createdAt'] = FieldValue.serverTimestamp();
        await userDocRef.set(userData);
      } else {
        // Mettre à jour le document existant
        await userDocRef.update(userData);
      }

      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Profil mis à jour avec succès'),
            backgroundColor: Colors.green,
          ),
        );
      }
    } catch (e) {
      print('Erreur détaillée lors de la mise à jour: $e');
      if (mounted) {
        String errorMessage;
        if (e.toString().contains('Exception:')) {
          errorMessage = e.toString().split('Exception: ')[1];
        } else if (e.toString().contains('FirebaseException')) {
          errorMessage = 'Erreur de connexion avec la base de données';
        } else {
          errorMessage = 'Erreur lors de la mise à jour du profil';
        }

        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Erreur: $errorMessage'),
            backgroundColor: Colors.red,
          ),
        );
      }
    } finally {
      if (mounted) {
        setState(() => _isLoading = false);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Column(
          children: [
            // HEADER
            Container(
              color: Colors.blue.shade900,
              width: double.infinity,
              height: 300,
              child: Stack(
                alignment: Alignment.center,
                children: [
                  Positioned(
                    top: 40,
                    left: 10,
                    child: IconButton(
                      icon: const Icon(Icons.arrow_back, color: Colors.white, size: 30),
                      onPressed: () => Navigator.pop(context),
                    ),
                  ),
                  Positioned(
                    top: 70,
                    child: GestureDetector(
                      onTap: _pickAndUploadImage,
                      child: CircleAvatar(
                        radius: 40,
                        backgroundColor: Colors.white,
                        backgroundImage: _imageUrl != null ? NetworkImage(_imageUrl!) : null,
                        child: _imageUrl == null
                            ? const Icon(Icons.person, size: 50, color: Colors.black)
                            : null,
                      ),
                    ),
                  ),
                  Positioned(
                    bottom: 10,
                    child: Container(
                      width: 303,
                      height: 129,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(20),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.1),
                            blurRadius: 5,
                            offset: const Offset(0, 5),
                          ),
                        ],
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "${_prenomController.text} ${_nomController.text}",
                            style: const TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: Colors.black,
                            ),
                          ),
                          const SizedBox(height: 5),
                          Text(
                            _emailController.text,
                            style: const TextStyle(
                              fontSize: 16,
                              color: Colors.grey,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),

            // FORMULAIRE
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              child: Column(
                children: [
                  CustomTextField(
                    label: "Titre",
                    hintText: "titre",
                    controller: _titreController,
                  ),
                  CustomTextField(
                    label: "Préférences culinaires",
                    hintText: "Ajouter des préférences",
                    controller: _preferencesController,
                  ),
                  CustomTextField(
                    label: "Pseudo",
                    hintText: "Pseudo",
                    controller: _pseudoController,
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: CustomTextField(
                          label: "Prénom",
                          hintText: "Prénom",
                          controller: _prenomController,
                        ),
                      ),
                      const SizedBox(width: 10),
                      Expanded(
                        child: CustomTextField(
                          label: "Nom",
                          hintText: "Nom",
                          controller: _nomController,
                        ),
                      ),
                    ],
                  ),
                  CustomTextField(
                    label: "Email",
                    hintText: "Email",
                    controller: _emailController,
                    enabled: false,
                  ),
                  CustomTextField(
                    label: "Numéro de téléphone",
                    hintText: "Numéro de téléphone",
                    controller: _telephoneController,
                  ),
                  CustomTextField(
                    label: "Gouvernorat",
                    hintText: "Gouvernorat",
                    controller: _gouvernoratController,
                  ),
                  const SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: _isLoading ? null : _saveUserData,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blue.shade900,
                      padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 15),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30),
                      ),
                    ),
                    child: _isLoading
                        ? const CircularProgressIndicator(color: Colors.white)
                        : const Text(
                            'Enregistrer',
                            style: TextStyle(fontSize: 16, color: Colors.white),
                          ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    _titreController.dispose();
    _preferencesController.dispose();
    _pseudoController.dispose();
    _prenomController.dispose();
    _nomController.dispose();
    _emailController.dispose();
    _telephoneController.dispose();
    _gouvernoratController.dispose();
    super.dispose();
  }
}

class CustomTextField extends StatelessWidget {
  final String label;
  final String hintText;
  final TextEditingController controller;
  final bool enabled;

  const CustomTextField({
    super.key,
    required this.label,
    required this.hintText,
    required this.controller,
    this.enabled = true,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: const TextStyle(color: Colors.grey, fontSize: 14),
          ),
          const SizedBox(height: 5),
          TextField(
            controller: controller,
            enabled: enabled,
            decoration: InputDecoration(
              hintText: hintText,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(20),
                borderSide: const BorderSide(color: Colors.grey),
              ),
              contentPadding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
            ),
          ),
        ],
      ),
    );
  }
}

import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';


class ImportPhoto extends StatefulWidget {
  const ImportPhoto ({super.key});

  @override
  State<ImportPhoto> createState() => _ImportPhotoState();
}

class _ImportPhotoState extends State<ImportPhoto> {
  File? _image;

  Future<void> _pickImagefromCamera() async{
   final pickedFile=
     await ImagePicker().pickImage(source: ImageSource.camera);
   if(pickedFile != null){
     setState(() {
       _image=File(pickedFile.path);
     });
   }
  }



  Future<void> _pickImagefromGallery() async{
    final pickedFile=
    await ImagePicker().pickImage(source: ImageSource.gallery);
    if(pickedFile != null){
      setState(() {
        _image=File(pickedFile.path);
      });
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:AppBar(
        foregroundColor:Colors.white,
        backgroundColor: Colors.blue.shade900,
        title: Text(
          "Choisir une image",
        ),
      ),
      body: Center(
        child: Column(
          children: [
            SizedBox(height: 100),
            _image !=null ? ClipRRect(borderRadius:BorderRadius.circular(20),
              child: Image.file(
                _image!,
                height: 250,
                width: 350,
                fit: BoxFit.cover,
              ),
            )
            :Container(
            height:250,
            width:350,
           decoration: BoxDecoration(
           border: Border.all(),
           borderRadius: BorderRadius.circular(20),
            ),
           child: Center(
             child: Icon(
              Icons.image,
              size: 50,
               ),
             ),
            ),
            SizedBox(height: 50,),
            SizedBox(
             height: 50,
             child: ElevatedButton(
               onPressed: _pickImagefromCamera,
                style: ElevatedButton.styleFrom(
                    backgroundColor:Colors.blue.shade900,
                    foregroundColor: Colors.white),
               child:Text("Choisir une image depuis l'appareil photo") ,

            ),
            ),

            SizedBox(height: 20,),
            SizedBox(
              height: 50,
              child: ElevatedButton(
                onPressed: _pickImagefromGallery,
                style: ElevatedButton.styleFrom(
                    minimumSize: Size(300, 50),
                    backgroundColor: Colors.blue.shade900,
                    foregroundColor: Colors.white),
                child:Text("Choisir une image depuis la gallery") ,

              ),
            )




            ],
        ),
      ),
    );
  }
}

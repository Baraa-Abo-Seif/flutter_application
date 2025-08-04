import 'package:flutter/material.dart';
import 'package:flutter_gemini/flutter_gemini.dart';
import 'dart:io';

import 'package:image_picker/image_picker.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State <HomePage> createState() =>  HomePageState();
}

class  HomePageState extends State <HomePage> {

  // Amro add 3 plugins
  // 1- Path provider : to get the path of files
  // 2- Image  picker : to pick up image from different sources
  // 3- flutter gemini : to request gemini

  
  String? _message = "No fruit exist"; 
  final imagePicker = ImagePicker();
  final gemini = Gemini.instance;

   @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      getImage();  // to open camera when app start
    });
  } 


  Future getImage() async{

    final selectedImage = await imagePicker.pickImage(source: ImageSource.camera); // this line will open the camera and get the image
    
    
    if(selectedImage != null){
      final image = File(selectedImage.path);

      // Start Loading Animation
      showDialog(
      context: context,
      builder: (context){
        return Center(child: CircularProgressIndicator(color: Colors.green,));
      },

    );


      final prompt = "What is the fruit or plant in this image? If identified, is it fresh or not, edible or not, and what is the standard amount of water it's (if you can) need per day?";

      String? text;

      try{
      text = await gemini.textAndImage(
      text: prompt,
      images: [image.readAsBytesSync()],
    ).then((value) => value?.content?.parts?.last.text);      // here we request gemini
    } catch(e){
      text = "Please check your internet connection and try again.";
    }

      setState(() {
        _message = text;
        });
        Navigator.of(context).pop(); // End Loading Animation
      }
    
    }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // layout:
      body: Center(
        child: Text(_message!),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: getImage,
        backgroundColor: Colors.green,
        child: Icon(Icons.camera_alt, color: Colors.white),
      ),
    );
  }
}
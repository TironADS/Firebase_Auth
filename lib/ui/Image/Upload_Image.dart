
// Changed 'dart:html' to 'dart:io' //
import 'dart:io';

import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:untitled6/utils/utils.dart';

class UploadImageScreen extends StatefulWidget {
  const UploadImageScreen({super.key});

  @override
  State<UploadImageScreen> createState() => _UploadImageScreenState();
}

class _UploadImageScreenState extends State<UploadImageScreen> {
  File? _image;
  final picker = ImagePicker();
  firebase_storage.FirebaseStorage storage = firebase_storage.FirebaseStorage.instance;
  DatabaseReference databaseRef =FirebaseDatabase.instance.ref('Post');

  Future getImageGallery() async {
    final pickedFile = await picker.pickImage(source: ImageSource.gallery , imageQuality: 80);
    setState(() {
      if(pickedFile != null){
        _image= File(pickedFile.path);
      }else{
        print('no image picked');
      }
    });

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text('Upload Image'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Center(
              child: InkWell(
                onTap: (){
                  getImageGallery();
                },
                child: Container(
                  height: 200,
                  width: 200,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                    border: Border.all()
                  ),
                  child: _image != null ? Image.file(_image!.absolute) : Icon(Icons.image),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(30.0),
              child: GestureDetector(
                onTap: ()async{
                  firebase_storage.Reference ref = firebase_storage.FirebaseStorage.instance.ref('/image/'+DateTime.now().millisecondsSinceEpoch.toString());
                  firebase_storage.UploadTask uploadTask = ref.putFile(_image!.absolute);
                   Future.value(uploadTask).then((value) async {
                    var newUrl = await ref.getDownloadURL();
                    databaseRef.child('1').set({
                      'id' : '1516',
                      'title': newUrl.toString()
                    }).then((value){
                      Utils().toastMessage('Uploaded');
                    }).onError((error, stackTrace) {

                    });
                  }).onError((error, stackTrace) {
                    Utils().toastMessage(error.toString());
                  });



                },
                child: Container(
                  height: 50,width: 200,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                    color: Colors.deepPurple
                  ),
                  child: Center(child: Text('Uplaod image',style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold),)),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}

import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:flutter/material.dart';
import 'package:untitled6/ui/FireStore/Add_FireStore_Data.dart';
import 'package:untitled6/ui/add_post.dart';
import 'package:untitled6/ui/logIn.dart';
import 'package:untitled6/utils/utils.dart';
class FireStoreScreen extends StatefulWidget {
  const FireStoreScreen({super.key});

  @override
  State<FireStoreScreen> createState() => _FireStoreScreenState();
}

class _FireStoreScreenState extends State<FireStoreScreen> {
  final auth = FirebaseAuth.instance;
  final editController = TextEditingController();
  final fireStore = FirebaseFirestore.instance.collection('users').snapshots();

  CollectionReference ref = FirebaseFirestore.instance.collection('users');
  final ref1 = FirebaseFirestore.instance.collection('users');

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.deepPurple[100],
        automaticallyImplyLeading: false,
        title: Text('Firestore'),
        actions: [
          IconButton(
              onPressed: () {
                auth.signOut().then((value) {
                  Navigator.of(context)
                      .push(MaterialPageRoute(builder: (_) => LogIn()));
                }).onError((error, stackTrace) {
                  Utils().toastMessage(error.toString());
                });
              },
              icon: Icon(Icons.exit_to_app_rounded))
        ],
      ),
      body: Column(
        children: [
          StreamBuilder<QuerySnapshot>(
              stream: fireStore,
              builder: (BuildContext context,AsyncSnapshot<QuerySnapshot>snapshot){
            if (snapshot.connectionState == ConnectionState.waiting)
              return Center(child: CircularProgressIndicator(),);
            if (snapshot.hasError)
              return Center(child: Text('Something else!!!'),);
            return  Expanded(
              child: ListView.builder(
                  itemCount: snapshot.data!.docs.length,
                  itemBuilder: (context,index){
                    return ListTile(
                      onTap: (){
                        // ref.doc(snapshot.data!.docs[index]['id'].toString()).update({
                        //   'title': 'hi Tiron'
                        // }).then((value){
                        //   Utils().toastMessage('data updated');
                        // }).onError((error, stackTrace) {
                        //   Utils().toastMessage(error.toString());
                        // });

                        // ref.doc(snapshot.data!.docs[index]['id'].toString()).delete();
                      },
                      title: Text(snapshot.data!.docs[index]['title'].toString()),
                      subtitle: Text(snapshot.data!.docs[index]['id'].toString()),
                    );
                  }),
            );
          }),

        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context)
              .push(MaterialPageRoute(builder: (_) => AddFirestoreData()));
        },
        child: Icon(Icons.add),
      ),
    );
  }
  Future<void> showMyDialog(String title, String id) async {
    editController.text = title;
    return showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Update'),
          content: Container(
            child: TextField(
              controller: editController,
              decoration: InputDecoration(
                  hintText: 'Edit text'
              ),
            ),
          ),
          actions: [
            TextButton(onPressed: (){
              Navigator.pop(context);
            }, child: Text('Cancel')),
            TextButton(onPressed: (){
              Navigator.pop(context);
            }, child: Text('Update')),
          ],
        );
      },
    );
  }
}

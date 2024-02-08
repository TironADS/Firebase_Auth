import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:untitled6/utils/utils.dart';

class AddPostScreen extends StatefulWidget {
  const AddPostScreen({super.key});

  @override
  State<AddPostScreen> createState() => _AddPostScreenState();
}

class _AddPostScreenState extends State<AddPostScreen> {
  final postController = TextEditingController();
  final databadeRef = FirebaseDatabase.instance.ref('Post');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add Post'),
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(
              height: 30,
            ),
            Center(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15),
                child: SizedBox(
                  child: TextFormField(
                    maxLines: 4,
                    controller: postController,
                    decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        hintText: 'Write something here...'),
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 30,
            ),
            GestureDetector(
              onTap: () {
                String id = DateTime.now().millisecondsSinceEpoch.toString();
                databadeRef.child(id).set({
                  'title': postController.text.toString(),
                  'id': id
                }).then((value) {
                  Navigator.pop(context);
                  Utils().toastMessage('Post added');
                }).onError((error, stackTrace) {
                  Utils().toastMessage(error.toString());
                });
              },
              child: Container(
                height: 50,
                width: 330,
                decoration: BoxDecoration(
                    color: Colors.deepPurple,
                    borderRadius: BorderRadius.circular(10)),
                child: const Center(
                  child: Text('Add',
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 20,
                          color: Colors.white)),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }


}

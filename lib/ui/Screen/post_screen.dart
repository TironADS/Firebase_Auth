import 'dart:math';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:flutter/material.dart';
import 'package:untitled6/ui/add_post.dart';
import 'package:untitled6/ui/logIn.dart';
import 'package:untitled6/utils/utils.dart';

class PostScreen extends StatefulWidget {
  const PostScreen({super.key});

  @override
  State<PostScreen> createState() => _PostScreenState();
}

class _PostScreenState extends State<PostScreen> {
  final auth = FirebaseAuth.instance;
  final ref = FirebaseDatabase.instance.ref('Post');
  final seachFilter = TextEditingController();
  final editController = TextEditingController();

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
        title: Text('Post'),
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
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: SizedBox(
              height: 50,
              child: TextFormField(
                controller: seachFilter,
                decoration: InputDecoration(
                    hintText: 'Search', border: OutlineInputBorder()),
                onChanged: (String value) {
                  setState(() {});
                },
              ),
            ),
          ),
          // Expanded(child: StreamBuilder(
          //   builder: (context, AsyncSnapshot<DatabaseEvent> snapshot) {
          //
          //
          //     if (!snapshot.hasData){
          //       return Center(child: CircularProgressIndicator( ));
          //     }else{
          //       Map<dynamic,dynamic>map=snapshot.data!.snapshot.value as dynamic;
          //       List<dynamic>list=[];
          //       list.clear();
          //       list=map.values.toList();
          //       return ListView.builder(itemCount:snapshot.data!.snapshot.children.length,
          //           itemBuilder: (context, index) {
          //             return ListTile(
          //                 title: Text(list[index]['title']),
          //                 subtitle: Text(list[index]['id'].toString())
          //             );
          //           });              }
          //
          //   }, stream: ref.onValue,
          // )),
          Expanded(
            child: FirebaseAnimatedList(
              defaultChild: Center(
                child: CircularProgressIndicator(),
              ),
              query: ref,
              itemBuilder: (context, snapshot, animation, index) {
                final title = snapshot.child('title').value.toString();
                if (seachFilter.text.isEmpty) {
                  return ListTile(
                    title: Text(snapshot.child('title').value.toString()),
                    subtitle: Text(snapshot.child('id').value.toString()),
                    trailing: PopupMenuButton(
                        icon: Icon(Icons.more_vert_rounded),
                        itemBuilder: (context) => [
                              PopupMenuItem(
                                  value: 1,
                                  child: ListTile(
                                    onTap: (){
                                      Navigator.pop(context);
                                      showMyDialog(title,snapshot.child('id').value.toString());
                                    },
                                    leading: Icon(Icons.edit_outlined),
                                    title: Text('Edit'),
                                  )),
                          PopupMenuItem(
                              value: 1,
                              child: ListTile(
                                onTap: (){
                                  Navigator.pop(context);
                                  ref.child(snapshot.child('id').value.toString()).remove();
                                },
                                leading: Icon(Icons.delete),
                                title: Text('Delete'),
                              ))
                            ]),
                  );
                } else if (title
                    .toLowerCase()
                    .contains(seachFilter.text.toLowerCase().toString())) {
                  return ListTile(
                    title: Text(snapshot.child('title').value.toString()),
                    subtitle: Text(snapshot.child('id').value.toString()),
                  );
                } else {
                  return Container();
                }
              },
            ),
          )
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context)
              .push(MaterialPageRoute(builder: (_) => AddPostScreen()));
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
              ref.child(id).update({
                'title': editController.text.toLowerCase()
              }).then((value) {
                Utils().toastMessage('Post Updated');
              }).onError((error, stackTrace) {
                Utils().toastMessage(e.toString());
              });
            }, child: Text('Update')),
          ],
        );
      },
    );
  }
}

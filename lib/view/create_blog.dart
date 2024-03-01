import 'dart:html';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_farmtofabric/sevices/crud.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';

class CreateBlog extends StatefulWidget {
  const CreateBlog({super.key});

  @override
  State<CreateBlog> createState() => _CreateBlogState();
}

class _CreateBlogState extends State<CreateBlog> {
  late String authorName, title, desc;
  File? selectedImage;
  bool _isLoading = false;
  CrudMethods crudMethods = CrudMethods();

  Future getImage() async {
    var image = await ImagePicker().pickImage(source: ImageSource.gallery);
    setState(() {
      selectedImage = image;
    });
  }

  uploadBlog() {
    if (selectedImage != null) {
      setState(() {
        _isLoading = true;
        });

      //uploading image to frirebase  storage
      StorageRefrence firebaseStorageRef = FirebaseStorage.insatnce
          .ref()
          .child("blogImages")
          .child("${randomAlphaNumeric(9)}.jpg");
          //getting download url of the uploaded file
          final StorageUploadTask task = firebaseStorageRef.putFile(selectedImage!);
           task.then((snapshot) async {
          var downloadUrl = await(await task.onComplete).ref.getDownloadURL();
          print("this is the URL $downloadUrl");
          Map<String, String> blogMap = {
            "imageUrl": downloadUrl,
            "author" : authorName,
            "title": title,
            "desc" : desc,
          };
          crudMethods.addData(blogMap).then((result) {
          Navigator.pop(context); 
          }); 
    } else {}
  }
}

@override
Widget build(BuildContext context) {
  return Scaffold(
    appBar: AppBar(
      title: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text("Flutter", style: TextStyle(fontSize: 22)),
          Text(
            "Farm2Fabric_learn",
            style: TextStyle(fontSize: 22, color: Colors.blue),
          )
        ],
      ),
      backgroundColor: Colors.transparent,
      elevation: 0.0,
      actions: <Widget>[
        GestureDetector(
          onTap: () {
            uploadBlog();
          },
          child: Container(
              padding: EdgeInsets.symmetric(horizontal: 16),
              child: Icon(Icons.file_upload)),
        )
      ],
    ),
    body:  _isLoading
     ? Container(
      alignment:Alignment.center,
      child: CircularProgressIndicator(),
    ) 
    : SingleChildScrollView(
              child: Container(
                child: Column(
                  children: <Widget>[
                    SizedBox(
                      height: 10,
                    ),
          GestureDetector(
              onTap: () {
                getImage();
              },
              child: selectedImage != null
                  ? Container(
                      height: 150,
                      width: MediaQuery.of(context).size.width,
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(6),
                        child: Image.file(
                          selectedImage,
                          fit: BoxFit.cover,
                        ),
                      ),
                    )
                  : Container(
                      margin: EdgeInsets.symmetric(horizontal: 16),
                      height: 150,
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(6)),
                      width: MediaQuery.of(context).size.width,
                      child: Icon(
                        Icons.add_a_photo,
                        color: Colors.black45,
                      ),
                    )),
          SizedBox(
            height: 8,
          ),
          Container(
            margin: EdgeInsets.symmetric(horizontal: 16),
            child: Column(
              children: <Widget>[
                TextField(
                  decoration: InputDecoration(hintText: "Author Name"),
                  onChanged: (val) {
                    authorName = val;
                  },
                ),
                TextField(
                  decoration: InputDecoration(hintText: "Title"),
                  onChanged: (val) {
                    title = val;
                  },
                ),
                TextField(
                  decoration: InputDecoration(hintText: "Description"),
                  onChanged: (val) {
                    desc = val;
                  },
                )
              ],
            ),
          )
        ],
      ),
    ),
     floatingActionButton: FloatingActionButton(
      onPressed: getImage,
      tooltip: 'Pick Image',
      child: Icon(Icons.add_a_photo),
    ),
  );
}

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:flutter_sqlite/components/components/utility.dart';
import 'package:flutter_sqlite/data/data/database-helper.dart';
import 'package:flutter_sqlite/models/photo.dart';

class ProfilePage extends StatefulWidget {
  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  PickedFile _imageFile;
  final ImagePicker _picker = ImagePicker();
  Widget imageProfile() {
    return Center(
      child: Stack(
        children: [
          CircleAvatar(
            radius: 70,
            backgroundImage: _imageFile == null
                ? NetworkImage(
                    'https://th.bing.com/th/id/OIP.Sx6HOCnbBdNMAszbbD3VcAHaMS?pid=ImgDet&rs=1')
                : FileImage(File(_imageFile.path)),
          ),
          Positioned(
            bottom: 15,
            right: 5,
            child: GestureDetector(
              onTap: () {
                showModalBottomSheet(
                  context: context,
                  builder: (context) => bottomSheet(),
                );
              },
              child: CircleAvatar(
                backgroundColor: Colors.blue,
                child: Icon(
                  Icons.camera_alt,
                  color: Colors.white,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget bottomSheet() {
    return Container(
      height: 100,
      width: MediaQuery.of(context).size.width,
      margin: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
      child: Column(
        children: [
          Text(
            'Choose Profile photo',
            style: TextStyle(fontSize: 20),
          ),
          SizedBox(
            height: 20,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextButton(
                child: Icon(
                  Icons.image,
                  size: 30,
                ),
                onPressed: () {
                  takePhoto(ImageSource.gallery);
                  pickImageFromGallery();
                },
              ),
              Text('gallery'),
              TextButton(
                  onPressed: () {
                    takePhoto(ImageSource.camera);
                  },
                  child: Icon(
                    Icons.camera_alt,
                    size: 30,
                  )),
              Text('Camera'),
            ],
          )
        ],
      ),
    );
  }

  void takePhoto(ImageSource source) async {
    final pickedFile = await _picker.getImage(source: source);
    setState(() {
      _imageFile = pickedFile;
    });
  }

  Future<File> imageFile;
  Image image;
  DatabaseHelper dbHelper;
  List<Photo> images;

  @override
  void initState() {
    super.initState();
    images = [];
    dbHelper = DatabaseHelper();
    refreshImages();
  }

  refreshImages() {
    dbHelper.getPhotos().then((imgs) {
      setState(() {
        images.clear();
        images.addAll(imgs);
      });
    });
  }

  pickImageFromGallery() {
    ImagePicker.pickImage(source: ImageSource.gallery).then((imgFile) {
      String imgString = Utility.base64String(imgFile.readAsBytesSync());
      Photo photo = Photo(0, imgString);
      dbHelper.save(photo);
      refreshImages();
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        backgroundColor: Colors.black,
        body: SafeArea(
          child: Container(
            margin: EdgeInsets.all(20),
            alignment: Alignment.center,
            child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Text(
                    'Edit Profile',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 30,
                        color: Colors.white),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  imageProfile(),
                  SizedBox(
                    height: 20,
                  ),
                  // GestureDetector(
                  //   onTap: () {},
                  //   child: Container(
                  //     height: 40,
                  //     alignment: Alignment.center,
                  //     margin: EdgeInsets.symmetric(horizontal: 100),
                  //     child: Text(
                  //       'SAVE',
                  //       style: TextStyle(
                  //           color: Colors.white,
                  //           fontSize: 18,
                  //           fontWeight: FontWeight.bold),
                  //     ),
                  //     decoration: BoxDecoration(
                  //         color: Colors.blue,
                  //         borderRadius: BorderRadius.circular(30)),
                  //   ),
                  // ),
                ]),
          ),
        ),
      ),
    );
  }
}

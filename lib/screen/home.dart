import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final picker = ImagePicker();
  File? _image;
  pickImage() async {
    var image = await picker.pickImage(source: ImageSource.camera);

    if (image == null) {
      return null;
    }

    setState(() {
      _image = File(image.path);
    });
  }

  pickGalleryImage() async {
    var image = await picker.pickImage(source: ImageSource.gallery);

    if (image == null) {
      return null;
    }

    setState(() {
      _image = File(image.path);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF101010),
      body: Container(
        padding: EdgeInsets.symmetric(horizontal: 24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(
              height: 100,
            ),
            const Text(
              "Teachablemachine CNN",
              style: TextStyle(
                color: Color(0xFFEEDA28),
                fontSize: 15,
              ),
            ),
            SizedBox(
              height: 6,
            ),
            Text(
              "Detect Cats and Dogs",
              style: TextStyle(
                color: Color(0xFFE99600),
                fontSize: 28,
                fontWeight: FontWeight.w500,
              ),
            ),
            SizedBox(
              height: 50,
            ),
            Center(
              child: Container(
                width: 300,
                child: Column(
                  children: [
                    Image.asset("assets/cat.png"),
                    SizedBox(
                      height: 50,
                    ),
                  ],
                ),
              ),
            ),
            Container(
              width: MediaQuery.of(context).size.width,
              child: Column(
                children: [
                  GestureDetector(
                    onTap: pickImage,
                    child: Container(
                      width: MediaQuery.of(context).size.width - 260,
                      alignment: Alignment.center,
                      padding: EdgeInsets.symmetric(
                        horizontal: 24,
                        vertical: 17,
                      ),
                      decoration: BoxDecoration(
                        color: Color(
                          0xFFE99600,
                        ),
                        borderRadius: BorderRadius.circular(6),
                      ),
                      child: Text(
                        "Take Photo",
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 50,
                  ),
                  GestureDetector(
                    onTap: pickGalleryImage,
                    child: Container(
                      width: MediaQuery.of(context).size.width - 260,
                      alignment: Alignment.center,
                      padding: EdgeInsets.symmetric(
                        horizontal: 24,
                        vertical: 17,
                      ),
                      decoration: BoxDecoration(
                        color: Color(
                          0xFFE99600,
                        ),
                        borderRadius: BorderRadius.circular(6),
                      ),
                      child: Text(
                        "Camera Roll",
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

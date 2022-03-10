import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'package:tflite/tflite.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final picker = ImagePicker();
  File? _image;
  bool _loading = false;
  List? _output;
  pickImage() async {
    var image = await picker.pickImage(source: ImageSource.camera);

    if (image == null) {
      return null;
    }

    setState(() {
      _image = File(image.path);
    });
    classifyImage(_image!);
  }

  pickGalleryImage() async {
    var image = await picker.pickImage(source: ImageSource.gallery);

    if (image == null) {
      return null;
    }

    setState(() {
      _image = File(image.path);
    });
    classifyImage(_image!);
  }

  @override
  void initState() {
    _loading = true;
    loadModel().then((value) {
      //
    });
    super.initState();
  }

  @override
  void dispose() {
    Tflite.close();
    super.dispose();
  }

  classifyImage(File image) async {
    var output = await Tflite.runModelOnImage(
      path: image.path,
      numResults: 2,
      threshold: 0.5,
      imageMean: 127.5,
      imageStd: 127.5,
    );
    setState(() {
      _loading = false;
      _output = output;
    });
  }

  loadModel() async {
    await Tflite.loadModel(
      model: "assets/model_unquant.tflite",
      labels: "assets/labels.txt",
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF101010),
      body: Container(
        padding: const EdgeInsets.symmetric(horizontal: 24),
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
            const SizedBox(
              height: 6,
            ),
            const Text(
              "Detect Cats and Dogs",
              style: TextStyle(
                color: Color(0xFFE99600),
                fontSize: 28,
                fontWeight: FontWeight.w500,
              ),
            ),
            const SizedBox(
              height: 50,
            ),
            Center(
              child: _loading
                  ? SizedBox(
                      width: 300,
                      child: Column(
                        children: [
                          Image.asset("assets/cat.png"),
                          const SizedBox(
                            height: 50,
                          ),
                        ],
                      ),
                    )
                  : Container(
                      child: Column(
                        children: [
                          SizedBox(
                            height: 250.0,
                            child: Image.file(_image!),
                          ),
                          const SizedBox(
                            height: 15,
                          ),
                          _output != null
                              ? Text(
                                  "${_output![0]['label']}",
                                  style: const TextStyle(
                                    color: Colors.white,
                                    fontSize: 20,
                                  ),
                                )
                              : Container(),
                        ],
                      ),
                    ),
            ),
            SizedBox(
              width: MediaQuery.of(context).size.width,
              child: Column(
                children: [
                  GestureDetector(
                    onTap: pickImage,
                    child: Container(
                      width: MediaQuery.of(context).size.width - 260,
                      alignment: Alignment.center,
                      padding: const EdgeInsets.symmetric(
                        horizontal: 27,
                        vertical: 15,
                      ),
                      decoration: BoxDecoration(
                        color: const Color(
                          0xFFE99600,
                        ),
                        borderRadius: BorderRadius.circular(6),
                      ),
                      child: const Text(
                        "Take Photo",
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  GestureDetector(
                    onTap: pickGalleryImage,
                    child: Container(
                      width: MediaQuery.of(context).size.width - 260,
                      alignment: Alignment.center,
                      padding: const EdgeInsets.symmetric(
                        horizontal: 27,
                        vertical: 15,
                      ),
                      decoration: BoxDecoration(
                        color: const Color(
                          0xFFE99600,
                        ),
                        borderRadius: BorderRadius.circular(6),
                      ),
                      child: const Text(
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

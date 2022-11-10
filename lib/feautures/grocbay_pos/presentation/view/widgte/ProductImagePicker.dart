

import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import '../../../../../core/util/presentation/styles/screen_size_rario.dart';
import 'package:image_picker/image_picker.dart';

class ProductImagePicker extends StatefulWidget {
  const ProductImagePicker({Key? key}) : super(key: key);

  @override
  _ProductImagePickerState createState() => _ProductImagePickerState();
}

class _ProductImagePickerState extends State<ProductImagePicker> {
  File? imageFile;
  Uint8List webImage = Uint8List(10);
  File _file = File("zz");
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Center(
        child: Container(
            decoration:BoxDecoration(
              border: Border.all(color: Colors.grey),
                  borderRadius: BorderRadius.circular(10)
            ),
            child: imageFile == null
                ? Container(
              alignment: Alignment.center,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: MaterialButton(
                      //color: Colors.greenAccent,
                      onPressed: () {
                        _getFromGallery();
                      },
                      child: Icon(Icons.add_a_photo_outlined,color: Colors.grey,size:25),
                    ),
                  ),
                  // MaterialButton(
                  //   color: Colors.lightGreenAccent,
                  //   onPressed: () {
                  //     _getFromCamera();
                  //   },
                  //   child: Text("PICK FROM CAMERA"),
                  // )
                ],
              ),
            ): Column(
              // child: Image.file(
              //   imageFile!,
              //   fit: BoxFit.cover,
              // ),
                children: [(_file.path == "zz")
                    ? Image.asset("assets/img/images.jpeg")
                    : (LayoutView(context).isWeb)
                    ? SizedBox(
                  width: 100,
                  height: 100,
                  child: Image.memory(webImage),
                )
                    : Image.file(_file),
              SizedBox(
                height: 20,
                width: double.infinity,
              ),]



            )),
      ),
    );
}
  _getFromGallery() async {
    XFile? pickedFile = await ImagePicker().pickImage(
      source: ImageSource.gallery,
      maxWidth: 1800,
      maxHeight: 1800,
    );
    if (pickedFile != null) {
      debugPrint("picked image");
      if(LayoutView(context).isWeb){
        var f = await pickedFile.readAsBytes();
        setState(() {
          _file = File("a");
          imageFile = _file;
          webImage = f;
          debugPrint("webimage"+webImage.toString());
        });
      }
      else{
        setState(() {
          var selected = File(pickedFile.path);
          imageFile = File(pickedFile.path);
          _file = selected;
        });
      }

    }
  }

  /// Get from Camera
  _getFromCamera() async {
    PickedFile? pickedFile = await ImagePicker().getImage(
      source: ImageSource.camera,
      maxWidth: 1800,
      maxHeight: 1800,
    );
    if (pickedFile != null) {
      setState(() {
        imageFile = File(pickedFile.path);
      });
    }
  }
}


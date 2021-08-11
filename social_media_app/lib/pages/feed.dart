import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';

class Feed extends StatefulWidget {

  @override
  _FeedState createState() => _FeedState();
}

class _FeedState extends State<Feed> {

  ImageSource get cameraSource => ImageSource.camera;
  ImageSource get gallerySource => ImageSource.gallery;

  void uploadProfilePhoto(ImageSource source) async {
   //final file = await ImagePicker.pickImage(source: source); 
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromRGBO(250, 250, 250, 1),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Color.fromRGBO(75, 0, 130, 1),
        child: Icon(Icons.add, color: Color.fromRGBO(255,40,147, 1)),
        onPressed: (){
          showModalBottomSheet(
            context: context,
            builder: (context){
              return SizedBox(
                height: 130.0,
                child: Column(
                  children: [
                    ListTile(
                      leading: Icon(CupertinoIcons.camera),
                      title: Text("Camera"),
                      onTap: () async {
                        if(await Permission.camera.isGranted){
                          
                        }else{
                          await Permission.camera.request();
                          if(await Permission.camera.isGranted){
                           
                          }
                        }
                      },
                    ),
                    ListTile(
                      leading: Icon(CupertinoIcons.photo),
                      title: Text("Gallery"),
                      onTap: () async {
                        if(await Permission.photos.isGranted){
                          
                        }else{
                          await Permission.photos.request();
                          if(await Permission.photos.isGranted){
                            
                          }
                        }
                      },
                    )
                  ],
                )
              );
            }
          );
        },
      ),
    );
  }
}
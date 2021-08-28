import 'package:barcode_scan_fix/barcode_scan.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:social_media_app/pages/profile.dart';

class QrCode extends StatefulWidget {
  
  @override
  _QrCodeState createState() => _QrCodeState();
  QrCode({this.uid}); 

  final String uid;
}

class _QrCodeState extends State<QrCode> {


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        elevation: 0.0,
        leading: IconButton(
          icon: Icon(CupertinoIcons.xmark, color: Colors.white),
          onPressed: (){
            Navigator.of(context).pop();
          },
        ),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(
              height: 300.0,
              width: 300.0,
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(30.0)),
                  border: Border.all(
                    color: Colors.white,
                    width: 5.0
                  ),
                  color: Color.fromRGBO(75, 0, 130, 1)
                ),
                child: Padding(
                  padding: EdgeInsets.all(10.0),
                  child: QrImage(
                    data: widget.uid,
                    gapless: false,
                    foregroundColor: Colors.white,
                  ),
                )
              ),
            ),
            SizedBox(
              height: 40.0,
            ),
            Padding(
              padding: EdgeInsets.fromLTRB(0.0, 30.0, 0.0, 0.0),
              child: IconButton(
                iconSize: 45.0,
                splashColor: Color.fromRGBO(75, 0, 130, 1),
                icon: Icon(CupertinoIcons.viewfinder_circle_fill, color: Colors.white),
                onPressed: () async { 
                  try{
                    await BarcodeScanner.scan();
                    String codeScanner = await BarcodeScanner.scan();
                    // check if code exists in db
                    Navigator.popAndPushNamed(context, "/profile", arguments: {
                      "uId" : codeScanner
                    });
                    
                  } on PlatformException catch(e){
                    // String codeScanner = await BarcodeScanner.scan();
                    print(e);
                  }on FormatException{
                    
                  } catch (Exception) {
                    
                  }
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}
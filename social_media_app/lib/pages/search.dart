import 'package:flutter/material.dart';


class Search extends StatefulWidget {

  @override
  _SearchState createState() => _SearchState();
}

class _SearchState extends State<Search> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromRGBO(250, 250, 250, 1),
      // appBar: AppBar(
      //   backgroundColor: Colors.white,
      //   title: SizedBox(
      //     height: 50.0,
      //     child: Row(
      //       mainAxisAlignment: MainAxisAlignment.spaceBetween,
      //       children: [
      //         SizedBox(
      //           width: 310.0,
      //           child: Flexible(
      //             child: TextFormField(
      //               cursorColor: Color.fromRGBO(255,40,147, 1),
      //               enableSuggestions: true,
      //               decoration: InputDecoration(
      //                 hintText: "Search",
      //                 fillColor: Color.fromRGBO(200, 200, 200, 1),
      //                 filled: true,
      //                 enabledBorder: OutlineInputBorder(
      //                   borderSide: BorderSide(color: Color.fromRGBO(200, 200, 200, 1),),
      //                   borderRadius: new BorderRadius.circular(5.0),
      //                 ),
      //                 focusedBorder: OutlineInputBorder(
      //                   borderSide: BorderSide(color: Color.fromRGBO(200, 200, 200, 1),),
      //                   borderRadius: new BorderRadius.circular(5.0),
      //                 ),
      //               ),
      //             ),
      //           ),
      //         ),
      //         Flexible(
      //           child: IconButton(
      //             icon: Icon(Icons.search, color: Color.fromRGBO(75, 0, 130, 1)),
      //             onPressed: (){

      //             },
      //           ),
      //         )
      //       ],
      //     )
      //   )
      // ),
    );
  }
}
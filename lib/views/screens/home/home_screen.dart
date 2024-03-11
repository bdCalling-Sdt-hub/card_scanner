import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(


      // body:  Center(
      //   child: DottedBorder(
      //     padding: EdgeInsets.all(0),
      //     dashPattern: [10,6],
      //     color: Colors.green,
      //     strokeWidth: 1,
      //     borderType: BorderType.RRect,
      //     radius: Radius.circular(12),
      //     child: Container(
      //       decoration: BoxDecoration(
      //         color: Colors.amberAccent,
      //         borderRadius: BorderRadius.circular(12)
      //       ),
      //       width: 200,
      //       height: 200,
      //       child: Center(
      //         child: Text(
      //           'Dotted Border',
      //           style: TextStyle(fontSize: 20),
      //         ),
      //       ),
      //     ),
      //   ),
      // ),
    );
  }
}

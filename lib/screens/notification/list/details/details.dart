import 'package:flutter/material.dart';

class Details extends StatelessWidget {
  //final String imageURL;
  final String title;
  final String subTitle;
  const Details(
      {super.key,
      //required this.imageURL,
      required this.title,
      required this.subTitle});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
      ),
      body: Container(
        padding: const EdgeInsets.all(10),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Text(
              subTitle,
              style: const TextStyle(fontWeight: FontWeight.w100),
            ),
          ],
        ),
      ),
    );
  }
}

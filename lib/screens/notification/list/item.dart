import 'package:flutter/material.dart';

import 'package:notification_module/screens/notification/list/details/details.dart';

class Item extends StatelessWidget {
  //final String imageURL;
  final String title;
  final String subTitle;
  const Item(
      {super.key,
      //required this.imageURL,
      required this.title,
      required this.subTitle});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      // leading: CircleAvatar(
      //   foregroundImage: NetworkImage(imageURL),
      //   child: const Icon(Icons.person),
      // ),
      title: Text(
        title,
        overflow: TextOverflow.ellipsis,
      ),
      subtitle: Text(
        subTitle,
        overflow: TextOverflow.ellipsis,
      ),
      trailing: const Icon(Icons.navigate_next),
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => Details(
                /*imageURL: imageURL,*/ title: title, subTitle: subTitle),
          ),
        );
      },
    );
  }
}

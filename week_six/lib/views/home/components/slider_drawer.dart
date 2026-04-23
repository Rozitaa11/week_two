import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CustomDrawer extends StatelessWidget {
  CustomDrawer({super.key});

  //icons
  final List<IconData> icons = [
    CupertinoIcons.home,
    CupertinoIcons.person_fill,
    CupertinoIcons.settings,
    CupertinoIcons.info_circle_fill,
  ];
  //texts
  final List<String> texts = ['Home', 'Profile', 'Settings', 'Details'];

  @override
  Widget build(BuildContext context) {
    var textTheme = Theme.of(context).textTheme;
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 90),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: const [Colors.white, Colors.blue],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          CircleAvatar(
            radius: 50,
            backgroundImage: NetworkImage(
              'https://avatars.githubusercontent.com/u/91308754?v=4',
            ),
          ),
          const SizedBox(height: 20),
          Text('Yeabsra Birhanu', style: textTheme.displayMedium),
          Text('Flutter Developer', style: textTheme.displaySmall),
          const SizedBox(height: 40),
          Container(
            width: double.infinity,
            height: 300,
            child: ListView.builder(
              itemCount: icons.length,
              itemBuilder: (BuildContext context, int index) {
                return InkWell(
                  onTap: () {
                    log('${texts[index]} Item Clicked');
                  },
                  child: Container(
                    margin: const EdgeInsets.all(2),
                    child: ListTile(
                      leading: Icon(
                        icons[index],
                        color: Colors.white,
                        size: 30,
                      ),
                      title: Text(
                        texts[index],
                        style: textTheme.displaySmall?.copyWith(
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

import 'package:flutter/material.dart';
 

class MyButtonDrawer extends StatefulWidget {
  final GlobalKey <ScaffoldState>? scanffoldkey;
  const MyButtonDrawer({
    this.scanffoldkey,
  });

  @override
  State<MyButtonDrawer> createState() => _MyButtonDrawerState();
}

class _MyButtonDrawerState extends State<MyButtonDrawer> {
  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: () {
         widget.scanffoldkey!.currentState!.openDrawer();
      },
       icon: Icon(
      Icons.menu,
      color: Color(0xffffffff),
      ),
      );
  }
}
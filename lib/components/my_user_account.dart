import 'package:flutter/material.dart';


class MyUserAccount extends StatefulWidget {
  final String userEmail;
   final String full_name;
  const MyUserAccount({
    super.key,
    required this.userEmail,
    required this.full_name,
  });

  @override
  State<MyUserAccount> createState() => _MyUserAccountState();
}

class _MyUserAccountState extends State<MyUserAccount> {
  @override
  Widget build(BuildContext context) {
    return UserAccountsDrawerHeader(
      decoration: BoxDecoration(
        color: Color(0xff000000),
        border: Border(
          bottom: BorderSide(
            color: Color(0xffec1c24),
            width: 3.0,
          ),
        ),
        ),
    accountName: Text(widget.full_name),
     accountEmail: Text(widget.userEmail),
     currentAccountPicture: CircleAvatar(
      child:  Icon( 
        Icons.supervised_user_circle_rounded,
        size: 72.0,
        color: Theme.of(context).primaryColor,
        ),
      ),
     );
  }
}
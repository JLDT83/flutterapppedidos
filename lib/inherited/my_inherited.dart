// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';

class GetInfoUser extends InheritedWidget {
  GetInfoUser({
    super.key,
    required this.child,
    this.id,
    this.accessToken,
    this.tokenType,
    this.userEmail,
    this.fullName,
    this.conexion,

  }) : super(child: child);

  final Widget child;
  String? id;
  String? accessToken;
  String? tokenType;
  String? userEmail;
  String? fullName;
  bool? conexion;
  

  static GetInfoUser of(BuildContext context) {
    final  GetInfoUser? result = context.dependOnInheritedWidgetOfExactType<GetInfoUser>();

    return result!;
  }

  @override
  bool updateShouldNotify(GetInfoUser oldWidget) {
    return true;
  }


   void setId(String id){
    this.id = id;
  }

   void setAccessToken(String accessToken){
    this.accessToken = accessToken;
  }

   void setTokenType(String tokenType){
    this.tokenType = tokenType;
  }
   void setUserEmail(String userEmail){
    this.userEmail = userEmail;
  }

   void setFullName(String fullName){
    this.fullName = fullName;
  }
    void setConexion(bool conexion){
    this.conexion = conexion;
  }
}
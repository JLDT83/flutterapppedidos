import 'dart:convert';
import 'dart:io';

import 'package:app_pedido/models/user.dart';
import 'package:path_provider/path_provider.dart';

class UserStorage{

  Future <String> get _localPath async {
 final directortory = await getApplicationDocumentsDirectory();

 return directortory.path;
  }
  
  Future <File> get _localFile async {

    final path = await _localPath;

    return File('$path/user.json');
  }

  Future <String> readUser () async {

    try {
      final file = await _localFile;
      //leer archivo
      String contents = await file.readAsString();

      return contents;
      
    } catch (e) {
       //si encuentra un error,  retorna cadena vacia
      return  '';
      
    }
  }

  
  Future <File> writerUser (String id, String fullNAme, String userEmail) async {
    final file = await _localFile;

    final user = Usuario(id: id, fullNAme: fullNAme, userEmail: userEmail);
    final String jsonUser = jsonEncode([user]);

    return file.writeAsString(jsonUser);


  }


}
import 'dart:convert';
import 'dart:io';

import 'package:app_pedido/models/prices.dart';
import 'package:path_provider/path_provider.dart';

class PrecioStorage{

  Future <String> get _localPath async {
 final directortory = await getApplicationDocumentsDirectory();

 return directortory.path;
  }
  
  Future <File> get _localFile async {

    final path = await _localPath;

    return File('$path/precios.json');
  }

  Future <String> readPrice () async {

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

  
  Future <File> writerPrice (List<Precio>precios) async {
    final file = await _localFile;

    
    final String jsonPrinces = jsonEncode(precios);

    return file.writeAsString(jsonPrinces);


  }


}
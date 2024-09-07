import 'dart:convert';
import 'dart:io';

import 'package:app_pedido/models/category.dart';
import 'package:path_provider/path_provider.dart';

class CategoriaStorage{

  Future <String> get _localPath async {
 final directortory = await getApplicationDocumentsDirectory();

 return directortory.path;
  }
  
  Future <File> get _localFile async {

    final path = await _localPath;

    return File('$path/categorias.json');
  }

  Future <String> readCategoria () async {

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

  
  Future <File> writerCategoria (List<Categoria>categorias) async {
    final file = await _localFile;

    
    final String jsonCategorias= jsonEncode(categorias);

    return file.writeAsString(jsonCategorias);


  }


}
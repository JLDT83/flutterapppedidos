import 'dart:convert';
import 'dart:io';

import 'package:app_pedido/models/product.dart';
import 'package:path_provider/path_provider.dart';

class ProductStorage{

  Future <String> get _localPath async {
 final directortory = await getApplicationDocumentsDirectory();

 return directortory.path;
  }
  
  Future <File> get _localFile async {

    final path = await _localPath;

    return File('$path/productos.json');
  }

  Future <String> readProduct () async {

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

  
  Future <File> writerProduct (List<Producto>productos) async {
    final file = await _localFile;

    
    final String jsonproducts = jsonEncode(productos);

    return file.writeAsString(jsonproducts);


  }


}
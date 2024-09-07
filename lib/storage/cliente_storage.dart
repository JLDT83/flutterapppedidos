import 'dart:convert';
import 'dart:io';

import 'package:app_pedido/models/client.dart';
import 'package:path_provider/path_provider.dart';

class ClienteStorage{

Future <String> get _localPath async {
 final directortory = await getApplicationDocumentsDirectory();

 return directortory.path;
}
  
  Future <File> get _localFile async {

    final path = await _localPath;

    return File('$path/clientes.json');
  }

  Future <String> readClient() async {

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

  
  Future <File> writerClient (List<Cliente> clientes) async {
    final file = await _localFile;

    
    final String jsonClients = jsonEncode(clientes);

    return file.writeAsString(jsonClients);


  }


}
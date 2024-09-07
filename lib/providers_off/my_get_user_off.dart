
import 'dart:convert';

import 'package:app_pedido/models/user.dart';
import 'package:app_pedido/storage/user_storage.dart';

final userStorage = UserStorage();

Future <List <Usuario>> obtenerUsuarios() async {

  final response = await userStorage.readUser();

  List<Usuario> usuarios = [];

  if (response.isNotEmpty){
    final jsonData = jsonDecode(response);

    for (var item in jsonData) {
      usuarios.add(
        Usuario(
          id: item['id'], 
          fullNAme: item['full_name'],
          userEmail: item['email'],
          ),
      
      );
      
    }

  }

  return usuarios;
}
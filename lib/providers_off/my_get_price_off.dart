
import 'dart:convert';

import 'package:app_pedido/models/prices.dart';
import 'package:app_pedido/storage/precio_storage.dart';


final precioStorage = PrecioStorage();

Future <List <Precio>> obtenerPreciolocal() async {

  final response = await precioStorage.readPrice();

  List<Precio> precios = [];

  if (response.isNotEmpty){
    final jsonData = jsonDecode(response);

    for (var item in jsonData) {
      precios.add(
      Precio(
          id: item['id'].toString(), 
          codigo: item['codigo'],
          idproducto: item['idproducto'].toString(),
          precio: item['precio'].toString(),
          ),
      
      );
      
    }

  }

  return precios;
}
import 'package:app_pedido/models/prices.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

final supabase = Supabase.instance.client;

Future<List<Precio>> obtenerDatos(String table) async {

  final response = await supabase.from(table).select('*');

  List<Precio> listaDAtos  = [];
  if (response.isNotEmpty){
    for (var item in response) {
      listaDAtos.add(
        Precio(
          id:item['id'].toString(),
          codigo: item['codigo'],
          precio: item['precio'],
          idproducto: item['idproducto'].toString(),
          ),
          );
    }

     return listaDAtos;
  } else {
    
    return Future.error('fallo de conexion');

  }

}
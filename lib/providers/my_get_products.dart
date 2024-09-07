
import 'package:app_pedido/models/product.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

final supabase = Supabase.instance.client;

Future<List<Producto>> obtenerDatosProductos(String table) async {

  final response = await supabase.from(table).select('*');

  List<Producto> listaDAtos  = [];
  if (response.isNotEmpty){
    for (var item in response) {
      listaDAtos.add(
        Producto(
          id:item['id'].toString(),
          codigo: item['codigo'],
          producto: item['producto'],
          idcategoria: item['idcategoria'].toString(),
          existencia:item[' existencia'].toString(),
          ),
          );
    }

     return listaDAtos;
  } else {
    
    return Future.error('fallo de conexion');

  }

}
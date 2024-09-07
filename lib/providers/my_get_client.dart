import 'package:app_pedido/models/client.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

final supabase = Supabase.instance.client;

Future<List<Cliente>> obtenerDatos(String table) async {

  final response = await supabase.from(table).select('*');

  List<Cliente> listaDAtos  = [];
  if (response.isNotEmpty){
    for (var item in response) {
      listaDAtos.add(
        Cliente(
          id:item['id'].toString(),
          cliente: item['cliente'],
          rif: item['rif'],
          grupocliente: item['grupo_cliente'],
          ),
          );
  
    }

     return listaDAtos;
  } else {
    
    return Future.error('fallo de conexion');

  }

}

import 'dart:convert';

import 'package:app_pedido/models/category.dart';
import 'package:app_pedido/storage/categoria_storage.dart';


final categoriaStorage = CategoriaStorage();

Future <List <Categoria>> obtenercategoriaslocal() async {

  final response = await categoriaStorage.readCategoria();

  List<Categoria> categorias = [];

  if (response.isNotEmpty){
    final jsonData = jsonDecode(response);

    for (var item in jsonData) {
      categorias.add(
       Categoria(
          id:item['id'].toString(),
          categoria: item['categoria'],
          ),
      
      );
      
    }

  }

  return categorias;
}
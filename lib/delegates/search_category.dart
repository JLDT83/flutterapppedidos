
import 'package:app_pedido/extension/extension_string.dart';
import 'package:app_pedido/models/category.dart';
import 'package:flutter/material.dart';

class BuscarCategoria extends SearchDelegate{
  final List<Categoria> listaCategoria ;
  List<Categoria> _filtroCategoria = [];

  BuscarCategoria ({
    required this.listaCategoria,
    });

  @override
  String? get searchFieldLabel => 'Buscar Categoria';

  @override
  List<Widget>? buildActions(BuildContext context) {
   
   return [
    IconButton(onPressed: () {
      
      query = '';
      
    }, icon: Icon(Icons.clear))
   ];
   
  }

  @override
  Widget? buildLeading(BuildContext context) {
   return IconButton(onPressed: () {
      close(context, null);
      
    }, icon: Icon(Icons.arrow_back));
  }

  @override
  Widget buildResults(BuildContext context) {
    List<Categoria> categorias = [];
    for (var item in listaCategoria) {
      if (item.categoria.contains(
        query.isNotEmpty ? query.capitalize().trim(): query = '',
      )){ 
        categorias.add(
          Categoria(
            id: item.id,
            categoria: item.categoria,
           
            ),
            );
      }
      
    }
     
    return ListView.builder(
      itemCount:categorias.length,
      itemBuilder: (context,index){
        return Card(
          child: ListTile(
            leading: CircleAvatar(
              child: Text(
                categorias[index].categoria.substring(0,2),
                ),
            ),
            title: Text(categorias[index].categoria),
          /*  subtitle:Text(clientes[index].rif),
            trailing: Text(clientes[index].grupocliente), */
          ),
          );
      },
      );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    _filtroCategoria = listaCategoria.where(
      (categoria) {
        return categoria.categoria.contains(
          query.isNotEmpty ? query.capitalize().trim() : query = '');
      },
    ).toList();
    return ListView.builder(
      itemCount: _filtroCategoria.length,
      itemBuilder: (context, index) {
        return Card(
          child: ListTile(
            leading:CircleAvatar(
              child:  Text(_filtroCategoria[index].categoria.substring(0, 2),
              ),
            ),
            title: Text(_filtroCategoria[index].categoria),
          /*  subtitle:Text(_filtroCategoria[index].rif),
            trailing: Text(_filtroCategoria[index].grupocliente), */
          ),
        );
        
      },
    );
  }

}
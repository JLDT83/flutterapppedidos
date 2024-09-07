import 'package:app_pedido/models/product.dart';
import 'package:flutter/material.dart';

class BuscarExistencia extends SearchDelegate<Producto> {
  final List<Producto> listaProductos;

  List<Producto> _filtroProductos = [];

  BuscarExistencia({
    required this.listaProductos,
  });

  @override
  String? get searchFieldLabel => 'Buscar productos';

  @override
  List<Widget>? buildActions(BuildContext context) {
    return [
      IconButton(
        onPressed: () {
          query = '';
        },
        icon: const Icon(Icons.clear),
      ),
    ];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    return IconButton(
      onPressed: () {
        close(
          context,
          Producto(
            id: '',
            codigo: '',
            producto: '',
            idcategoria: '',
            existencia: '',
          ),
        );
      },
      icon: const Icon(Icons.arrow_back),
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    List<Producto> productos = [];

    for (var item in listaProductos) {
      if (item.producto.contains(query.toUpperCase().trim())) {
        productos.add(
          Producto(
            id: item.id,
            codigo: item.codigo,
            producto: item.producto,
            idcategoria: item.idcategoria,
            existencia: item.existencia,
          ),
        );
      }
    }

    return ListView.builder(
      itemCount: productos.length,
      itemBuilder: (context, index) {
        return Card(
          child: ListTile(
            leading: CircleAvatar(
              child: Text(
                productos[index].producto.substring(0, 2),
              ),
            ),
            title: Text(productos[index].producto),
            subtitle: Text(productos[index].codigo),
          ),
        );
      },
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    _filtroProductos = listaProductos.where(
      (producto) {
        return producto.producto.contains(query.toUpperCase().trim());
      },
    ).toList();

    return ListView.builder(
      itemCount: _filtroProductos.length,
      itemBuilder: (context, index) {
        return Card(
          child: ListTile(
            leading: CircleAvatar(
              child: Text(
                _filtroProductos[index].producto.substring(0, 2),
              ),
            ),
            title: Text(_filtroProductos[index].producto),
            subtitle: Text(_filtroProductos[index].codigo),
            trailing: Text('${_filtroProductos[index].existencia} uds.'),
          ),
        );
      },
    );
  }
}
import 'package:app_pedido/components/my_appbar.dart';
import 'package:app_pedido/components/my_button_drawer.dart';
import 'package:app_pedido/components/my_drawer.dart';
import 'package:app_pedido/delegates/buscar_existencia.dart';
import 'package:app_pedido/inherited/my_inherited.dart';
import 'package:app_pedido/models/product.dart';
import 'package:app_pedido/providers/my_get_products.dart';
import 'package:app_pedido/providers_off/my_get_product_off.dart';
import 'package:app_pedido/storage/existencia_storage.dart';
import 'package:flutter/material.dart';

class ListadoExistencias extends StatefulWidget {
  const ListadoExistencias({super.key});

  @override
  State<ListadoExistencias> createState() => _ListadoExistenciasState();
}

class _ListadoExistenciasState extends State<ListadoExistencias> {
   final GlobalKey<ScaffoldState> _scaffoldkey = GlobalKey <ScaffoldState>();
  
  late final Future<List<Producto>> listaProductos;

  final productStorage = ProductStorage();
  @override
  Widget build(BuildContext context) {
      
     if (GetInfoUser.of(context).conexion!) {
      listaProductos = obtenerDatosProductos('productos');
    } else {
      listaProductos = obtenerProductolocal();
    }


    
  return Scaffold(
      key: _scaffoldkey,
      drawer: MyDrawer(),
      appBar: MyAppBar(
        myButtonDrawer: MyButtonDrawer(
          scanffoldkey: _scaffoldkey,
        ),
      ) ,
         body: FutureBuilder(
        future: listaProductos,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return ListView(
              children: verExistencias(snapshot.data!),
            );
          } else if (snapshot.hasError) {
            return Center(
              child: const Text('No hay datos'),
            );
          }
          return Center(
            child: CircularProgressIndicator(),
          );
        },
      ),
    );
  }

  List<Widget> verExistencias(List<Producto> datos) {
    List<Widget> existencias = [];

    existencias.add(
      Card(
        child: ListTile(
          leading: const Text(
            'Lista de productos',
            style: TextStyle(
              fontSize: 20.0,
            ),
          ),
          trailing: IconButton(
              onPressed: () {
                showSearch(
                    context: context,
                    delegate: BuscarExistencia(listaProductos: datos));
              },
              icon: const Icon(Icons.search)),
        ),
      ),
    );

    for (var item in datos) {
      existencias.add(Card(
        child: ListTile(
          leading: CircleAvatar(
            child: Text(
              item.producto.substring(0, 2),
            ),
          ),
          title: Text(item.producto),
          subtitle: Text(item.codigo),
          trailing: Text('${item.existencia} uds.'),
        ),
      ));
    }

    productStorage.writerProduct(datos);

    return existencias;
  }
}
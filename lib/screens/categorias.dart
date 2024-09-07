import 'package:app_pedido/components/my_appbar.dart';
import 'package:app_pedido/components/my_button_drawer.dart';
import 'package:app_pedido/components/my_drawer.dart';
import 'package:app_pedido/delegates/search_category.dart';
import 'package:app_pedido/inherited/my_inherited.dart';
import 'package:app_pedido/models/category.dart';
import 'package:app_pedido/providers/my_get_category.dart';
import 'package:app_pedido/providers_off/my_get_category_off.dart';
import 'package:app_pedido/storage/categoria_storage.dart';
import 'package:flutter/material.dart';

class ListadoCategoria extends StatefulWidget {
  const ListadoCategoria({super.key});

  @override
  State<ListadoCategoria> createState() => _ListadoCategoriaState();
}

class _ListadoCategoriaState extends State<ListadoCategoria> {
   final GlobalKey<ScaffoldState> _scaffoldkey = GlobalKey <ScaffoldState>();

   late final Future <List<Categoria>>ListadoCategoria;

  final categoriaStorage = CategoriaStorage();

   void initState() {
    super.initState();
   // ListadoCategoria = obtenerDatos('categorias');
   }
  @override
  Widget build(BuildContext context) {

    if (GetInfoUser.of(context).conexion!){
      ListadoCategoria = obtenerDatos('categorias');

    } else {
      ListadoCategoria = obtenercategoriaslocal();
    }
    return Scaffold(
      key: _scaffoldkey,
      drawer: MyDrawer(),
      appBar: MyAppBar(
        myButtonDrawer: MyButtonDrawer(
          scanffoldkey: _scaffoldkey,
        ),
      ) ,
      body:FutureBuilder(
        future: ListadoCategoria,
         builder: (context, snapshot){
          if (snapshot.hasData){
            return ListView(
              children: vercategoria(snapshot.data!),
            );
          } else if (snapshot.hasError){
            return Center(
              child: Text('No hay datos',
              style: TextStyle(fontSize: 20.0),
              ),
            ); 
          }
           return Center(
           child:CircularProgressIndicator(),
           );
         }
         ),
    );
  }
  
  List <Widget> vercategoria(List<Categoria> datos) {
    List<Widget> categorias = [];

    categorias.add(Card(
      child: ListTile(
        title: Text('Listado de categorias',
        style: TextStyle(
          fontSize: 20.0,
        ),
        ),
        trailing: IconButton(
         onPressed: () {
          showSearch(context: context, delegate: BuscarCategoria(listaCategoria: datos));
        },
        icon: Icon(Icons.search)),
      ),
    ));

    for (var item in datos) {
      categorias.add(
        Card(
          child: ListTile(
            leading: CircleAvatar(
              child: Text(item.categoria.substring(0,2)),
            ),
            title: Text(item.categoria),
          ),
        ),
      );
      
    }
    
    categoriaStorage.writerCategoria(datos);
   
    return categorias;
  }

  
}
import 'package:app_pedido/components/my_appbar.dart';
import 'package:app_pedido/components/my_button_drawer.dart';
import 'package:app_pedido/components/my_drawer.dart';
import 'package:app_pedido/delegates/search_client.dart';
import 'package:app_pedido/inherited/my_inherited.dart';
import 'package:app_pedido/providers/my_get_client.dart';
import 'package:app_pedido/models/client.dart';
import 'package:app_pedido/providers_off/my_get_clientes_off.dart';
import 'package:app_pedido/storage/cliente_storage.dart';
import 'package:flutter/material.dart';

class listadoCliente extends StatefulWidget {
  
  const listadoCliente({
    super.key,

    });

  @override
  State<listadoCliente> createState() => _listadoClienteState();
}

class _listadoClienteState extends State<listadoCliente> {
   final GlobalKey<ScaffoldState> _scaffoldkey = GlobalKey <ScaffoldState>();
   late Future<List<Cliente>> listaClientes;

   final clienteStorage = ClienteStorage();

   @override
  void initState() {
    super.initState();

   // listaClientes = obtenerDatos('clientes');

    //debugPrint(listaClientes.toString());
  }
  @override
  Widget build(BuildContext context) {
    if (GetInfoUser.of(context).conexion!){
      listaClientes = obtenerDatos('clientes');
    } else {
      listaClientes = obtenerClienteLocal();
    }
    return Scaffold(
      key: _scaffoldkey,
      drawer: MyDrawer(),
      appBar: MyAppBar(
        myButtonDrawer: MyButtonDrawer(
          scanffoldkey: _scaffoldkey,
        ),
      ),
      body: FutureBuilder(
        future: listaClientes,
         builder: (context, snapshot) {
        if (snapshot.hasData) {
          return ListView(children: verClientes(snapshot.data!),);
          
        } else if (snapshot.hasError) {
           return Center(
            child: Text(
              'no hay  datos',
              style: TextStyle(fontSize: 20.0),
              ),
              );

        }
        return Center(child: CircularProgressIndicator(),);
      },),
    );
  }
  
  List <Widget> verClientes(List<Cliente> datos) {
    List<Widget> clientes = [];
    clientes.add(Card(
      child: ListTile(
        title: Text('Listado de Clientes',
        style: TextStyle(
          fontSize: 20.0,
        ),
        ),
        trailing: IconButton(
          onPressed: () {
          showSearch(context: context, delegate: BuscarCliente(listaClientes: datos));
        },
        icon: Icon(Icons.search)),
      ),
    ));


    for (var item in datos) {
      clientes.add(Card(
        child: ListTile(
          leading: CircleAvatar(
            child: Text(
              item.cliente.substring(0,2),
            ),
          ),
          title: Text(item.cliente),
          subtitle: Text(item.rif),
          trailing: Text(item.grupocliente),
        ),
      ),

        
     );
    }

    clienteStorage.writerClient(datos);
    return clientes;

  }
}
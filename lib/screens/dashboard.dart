import 'package:app_pedido/components/my_button_drawer.dart';
import 'package:app_pedido/components/my_drawer.dart';
import 'package:app_pedido/inherited/my_inherited.dart';
import 'package:app_pedido/models/user.dart';
import 'package:app_pedido/providers_off/my_get_user_off.dart';
import 'package:app_pedido/screens/categorias.dart';
import 'package:app_pedido/screens/clientes.dart';
import 'package:app_pedido/screens/existencias.dart';
import 'package:app_pedido/screens/historico_pedidos.dart';
import 'package:app_pedido/screens/orden_pedidos.dart';
import 'package:flutter/material.dart';
import 'package:app_pedido/components/my_appbar.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
class Dashboard extends StatefulWidget {
 

  const Dashboard({
    super.key,
  
    });

  @override
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  final GlobalKey<ScaffoldState> _scaffoldkey = GlobalKey <ScaffoldState>();
  final supabase = Supabase.instance.client;

  Future <List <Usuario>>? listaUsuarios;

  
 

  @override
  void initState() {
    super.initState();
    

  }

  @override
  Widget build(BuildContext context) {
    if(!GetInfoUser.of(context).conexion!){
      getInfoUserOffline();
    }
     return Scaffold(
      key: _scaffoldkey,
      drawer: MyDrawer(),
      appBar: MyAppBar(
        myButtonDrawer: MyButtonDrawer(
          scanffoldkey: _scaffoldkey,
        ),
      ),
      body: GridView.count(
        crossAxisCount: 2,
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 6.0, left: 3.0),
            child: Card(
              elevation: 3.0,
              child: ListTile(
                title: Text('Categoria',
                textAlign: TextAlign.center,),
                subtitle: Image.asset('assets/img/categorias.png'),
                   onTap: () {
                  Navigator.push(
                    context,
                     MaterialPageRoute(
                      builder: (context) => ListadoCategoria() ,
                      ),
                      );
                  
                 },
              ),
            ),
          ),
           Padding(
            padding: const EdgeInsets.only(top: 6.0, right: 3.0),
             child: Card(
              color: Color(0xffffffff),
              elevation: 3.0,
              child: ListTile(
                title: Text('Historia de pedidos',
                textAlign: TextAlign.center,
                ),
                 subtitle: Image.asset('assets/img/pedidos.png'),
                 onTap: () {
                  Navigator.push(
                    context,
                     MaterialPageRoute(
                      builder: (context) => HistoricoPedidos() ,
                      ),
                      );
                  
                 },
              ),
                       ),
           ),
           Padding(
             padding: const EdgeInsets.only(top: 6.0, left: 3.0),
             child: Card(
              elevation: 3.0,
              child: ListTile(
                title: Text('Cliente',
                textAlign: TextAlign.center,),
                 subtitle: Image.asset('assets/img/clientes.png'),
                 onTap: () {
                  Navigator.push(
                    context,
                     MaterialPageRoute(
                      builder: (context) => listadoCliente() ,
                      ),
                      );
                  
                 },
              ),
                       ),
           ),
           Padding(
             padding: const EdgeInsets.only(top: 6.0, right: 3.0),
             child: Card(
              elevation: 3.0,
              child: ListTile(
                title: Text('Existencia',
                textAlign: TextAlign.center,),
                 subtitle: Image.asset('assets/img/existencias.png'),
                 onTap: () {
                   Navigator.push(
                    context,
                     MaterialPageRoute(
                      builder: (context)=> ListadoExistencias(),
                      ),
                      );
                 },
              ),
               ),
           ),
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: (){
          Navigator.push(context,
           MaterialPageRoute(
            builder: (context)=> OrdenPedido(),
            ),
            );
        },
         label: Text(
          'Pedidos',
          style: TextStyle(
            color: Color(0xffffffff),
          ),
         ),
         icon: Icon(
          Icons.thumb_up_alt,
          color: Color(0xffffffff),
         ),
         backgroundColor: Color(0xffec1c24),
         ),
      );
  }
  void getInfoUserOffline () {

    listaUsuarios = obtenerUsuarios();

    listaUsuarios!.then((value) => {

      for (var item in value){

        GetInfoUser.of(context).setId(item.id),
        GetInfoUser.of(context).setFullName(item.fullNAme),
        GetInfoUser.of(context).setUserEmail(item.userEmail),


      }

    
    

    });

   
  }
}

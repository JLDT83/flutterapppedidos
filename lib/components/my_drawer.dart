import 'dart:io';

import 'package:app_pedido/components/my_user_account.dart';
import 'package:app_pedido/inherited/my_inherited.dart';
import 'package:app_pedido/screens/categorias.dart';
import 'package:app_pedido/screens/clientes.dart';
import 'package:app_pedido/screens/dashboard.dart';
import 'package:app_pedido/screens/existencias.dart';
import 'package:app_pedido/screens/historico_pedidos.dart';
import 'package:app_pedido/screens/orden_pedidos.dart';
import 'package:app_pedido/screens/ver_pedidos.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:supabase_flutter/supabase_flutter.dart';


class MyDrawer extends StatefulWidget {
 


  const MyDrawer({
    super.key,

  });

  @override
  State<MyDrawer> createState() => _MyDrawerState();
}

class _MyDrawerState extends State<MyDrawer> {
  final supabase = Supabase.instance.client;
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: [
          Expanded(child: Column(
            children: [
              MyUserAccount(
              userEmail: GetInfoUser.of(context).userEmail!,
              full_name: GetInfoUser.of(context).fullName!,
             ),

        ListTile(
                  leading: Image.asset('assets/img/dashboard.png'),
                  title: const Text('Inicio'),
                  trailing: Icon(Icons.home,color:Color(0xffec1c24),),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => Dashboard(),
                      ),
                    );
                  },
                ),
                const Divider(color: Color(0xffec1c24),),
        ListTile(
          leading: Image.asset('assets/img/categorias.png'),
          title: const Text('Categoria'),
           onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => ListadoCategoria(),
                      ),
                    );
                  },
        ),
        ListTile(
          leading: Image.asset('assets/img/pedidos.png'),
          title: const Text('historico de Pedidos'),
           onTap: () {
                  Navigator.push(
                    context,
                     MaterialPageRoute(
                      builder: (context) => HistoricoPedidos() ,
                      ),
                      );
                  
                 },
        ),

        ListTile(
          leading: Image.asset('assets/img/clientes.png'),
          title: Text('clientes'),
          onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => listadoCliente(),
                      ),
                    );
                  },
        ),
        ListTile(
          leading: Image.asset('assets/img/existencias.png'),
          title: const Text('Existencias'),
            onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => ListadoExistencias(),
                      ),
                    );
                  },
        ),
         ListTile(
          leading: Image.asset('assets/img/order.png'),
          title: const Text('Orden de Pedido'),
            onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => OrdenPedido(),
                      ),
                    );
                  },
        ),
          ListTile(
          leading: Image.asset('assets/img/carrito.png'),
          title: const Text('Carrito de Pedido'),
            onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => VerPedidos(),
                      ),
                    );
                  },
        ),

            ],
            
          ),
          ),
        const Divider(color: Color(0xffec1c24),),
        Container(
          child: Align(
            alignment: FractionalOffset.bottomCenter,
            child: Column(
              children: [
                 ListTile(
                    leading: const Icon(Icons.exit_to_app_rounded,color:Color(0xffec1c24),),
                    title:  const Text('Cerrar sesion'),
                    onTap: () {
                      logout();
                    },
                  ),
              ],
            ),
          ),
        ),
       
         ],
         ),
        
      
    );
  }

  void logout() async {
    
     await supabase.auth.signOut();

     exit(0); //para windows y  android cierra el programa
    //SystemNavigator.pop(); //para android

  }
}

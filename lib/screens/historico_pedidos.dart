import 'package:app_pedido/components/my_appbar.dart';
import 'package:app_pedido/components/my_button_drawer.dart';
import 'package:app_pedido/components/my_drawer.dart';
import 'package:flutter/material.dart';

class HistoricoPedidos extends StatefulWidget {
  const HistoricoPedidos({super.key});

  @override
  State<HistoricoPedidos> createState() => _HistoricoPedidosState();
}

class _HistoricoPedidosState extends State<HistoricoPedidos> {
   final GlobalKey<ScaffoldState> _scaffoldkey = GlobalKey <ScaffoldState>();
  @override
  Widget build(BuildContext context) {
   return Scaffold(
      key: _scaffoldkey,
      drawer: MyDrawer(),
      appBar: MyAppBar(
        myButtonDrawer: MyButtonDrawer(
          scanffoldkey: _scaffoldkey,
        ),
      ) ,
      body: Center(child: Text('Historico de Pedido'),
      ),
    );
  }
}

class _scaffoldkey {
}
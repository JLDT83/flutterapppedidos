import 'dart:async';
import 'package:app_pedido/inherited/my_inherited.dart';
import 'package:flutter/material.dart';
import 'package:app_pedido/screens/dashboard.dart';
import 'package:app_pedido/screens/login.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/services.dart';
import 'dart:developer' as developer;



class HomeScreen extends StatefulWidget {
  final String titulo;
  const HomeScreen({

    super.key,
    required this.titulo,
  });

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<ConnectivityResult> _connectionStatus = [ConnectivityResult.none];
  final Connectivity _connectivity = Connectivity();
  late StreamSubscription<List<ConnectivityResult>> _connectivitySubscription;
 
 @override
  void dispose() {
     _connectivitySubscription.cancel();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();

    initConnectivity();
     
    
    _connectivitySubscription =
        _connectivity.onConnectivityChanged.listen(_updateConnectionStatus);
  }

  Future<void> initConnectivity() async {
    late List<ConnectivityResult> result;

    try {
      result = await _connectivity.checkConnectivity();
    } on PlatformException catch (e) {
      developer.log('Couldn\'t check connectivity status', error: e);
      return;
    }

    if (!mounted) {
      return Future.value(null);
    }

    return _updateConnectionStatus(result);
  }

  Future<void> _updateConnectionStatus(List<ConnectivityResult> result) async {
    setState(() {
      _connectionStatus = result;
    });
  }

  
  @override
  Widget build(BuildContext context) {
       //bool _conexion = true;
    bool conexion = _connectionStatus[0].toString() == ConnectivityResult.ethernet.toString() || _connectionStatus[0].toString() == ConnectivityResult.vpn.toString();
    // ignore: avoid_print
    print('Conexión: $conexion');
    GetInfoUser.of(context).setConexion(conexion);
  
   //bool _conexion = _connectionStatus[0] == ConnectivityResult.ethernet || _connectionStatus[0] == ConnectivityResult.wifi;

  GetInfoUser.of(context).setConexion(conexion);
 
    return Scaffold(
  
      body: conexion
          ? Login()
          : Dashboard(),
      backgroundColor: Colors.grey[300],
    );
  }
}


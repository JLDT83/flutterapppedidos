import 'package:app_pedido/components/my_appbar.dart';
import 'package:app_pedido/components/my_button_drawer.dart';
import 'package:app_pedido/components/my_drawer.dart';
import 'package:app_pedido/inherited/my_inherited.dart';
import 'package:app_pedido/models/client.dart';
import 'package:app_pedido/models/product.dart';
//import 'package:app_pedido/models/product.dart';
import 'package:app_pedido/providers/my_get_client.dart';
import 'package:app_pedido/providers/my_get_products.dart';
import 'package:app_pedido/providers_off/my_get_clientes_off.dart';
import 'package:app_pedido/providers_off/my_get_product_off.dart';
import 'package:app_pedido/screens/ver_pedidos.dart';
import 'package:app_pedido/storage/cliente_storage.dart';
import 'package:app_pedido/storage/existencia_storage.dart';
import 'package:dropdown_button2/dropdown_button2.dart';

import 'package:flutter/material.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';



class OrdenPedido extends StatefulWidget {
  const OrdenPedido({super.key});

  @override
  State<OrdenPedido> createState() => _OrdenPedidoState();
}

class _OrdenPedidoState extends State<OrdenPedido> {
  final GlobalKey<ScaffoldState> _scaffoldkey = GlobalKey<ScaffoldState>();

var maskCantidad = MaskTextInputFormatter(
  mask: '####',
  filter:{"#": RegExp(r'0-9')},
  type: MaskAutoCompletionType.lazy
);

  late  Future<List<Cliente>> listaClientes;
  late  Future<List<Producto>> listaProductos;

  final clienteStorage = ClienteStorage();
  final productStorage = ProductStorage();

  String? selectedValueClient;
  String? selectedValueProduct;

  final textEditingControllerClient = TextEditingController();
  final textEditingControllerProduct = TextEditingController();
  final textEditingControllerCantidad = TextEditingController();

  void dispose(){
    textEditingControllerClient.dispose();
    textEditingControllerProduct.dispose();
    textEditingControllerCantidad.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {

    

if (GetInfoUser.of(context).conexion!){
  listaClientes = obtenerDatos('clientes');
  listaProductos = obtenerDatosProductos('productos');
} else {
  listaClientes = obtenerClienteLocal();
  listaProductos = obtenerProductolocal();
}

    return Scaffold(
      key: _scaffoldkey,
      drawer: MyDrawer(),
      appBar: MyAppBar(
        myButtonDrawer: MyButtonDrawer(
          scanffoldkey: _scaffoldkey,
        ),
      ),
     body: ListView(
        children: [
          Card(
            child: ListTile(
              leading: Image.asset('assets/img/order.png'),
              title: Text(
                'Realizar pedido',
                style: TextStyle(
                  fontSize: 20.0,
                ),
              ),
              subtitle: Text('Emisión del pedido'),
              trailing: IconButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => VerPedidos(),
                    ),
                  );
                },
                icon: Icon(Icons.shopping_cart_sharp),
              ),
            ),
          ),

          /* CLIENTES */
          FutureBuilder(
            future: listaClientes,
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return Container(
                  child: DropdownButtonHideUnderline(
                    child: DropdownButton2<String>(
                      isExpanded: true,
                      hint: Text(
                        'Seleccionar cliente',
                        style: TextStyle(
                          fontSize: 14,
                          color: Theme.of(context).hintColor,
                        ),
                      ),
                      items: snapshot.data! //items
                          .map((item) => DropdownMenuItem(
                                value: '${item.cliente} - ${item.id}',
                                child: Text(
                                  item.cliente,
                                  style: const TextStyle(
                                    fontSize: 14,
                                  ),
                                ),
                              ))
                          .toList(),
                      value: selectedValueClient,
                      onChanged: (value) {
                        setState(() {
                          selectedValueClient = value;
                        });
                      },
                      buttonStyleData: const ButtonStyleData(
                        padding: EdgeInsets.symmetric(horizontal: 16),
                        height: 40,
                        width: 200,
                      ),
                      dropdownStyleData: const DropdownStyleData(
                        maxHeight: 200,
                      ),
                      menuItemStyleData: const MenuItemStyleData(
                        height: 40,
                      ),
                      dropdownSearchData: DropdownSearchData(
                        searchController: textEditingControllerClient,
                        searchInnerWidgetHeight: 50,
                        searchInnerWidget: Container(
                          height: 50,
                          padding: const EdgeInsets.only(
                            top: 8,
                            bottom: 4,
                            right: 8,
                            left: 8,
                          ),
                          child: TextFormField(
                            expands: true,
                            maxLines: null,
                            controller: textEditingControllerClient,
                            decoration: InputDecoration(
                              isDense: true,
                              contentPadding: const EdgeInsets.symmetric(
                                horizontal: 10,
                                vertical: 8,
                              ),
                              hintText: 'Buscar un cliente...',
                              hintStyle: const TextStyle(fontSize: 12),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(8),
                              ),
                            ),
                          ),
                        ),
                        searchMatchFn: (item, searchValue) {
                          return item.value.toString().contains(searchValue);
                        },
                      ),
                      //This to clear the search value when you close the menu
                      onMenuStateChange: (isOpen) {
                        if (!isOpen) {
                          textEditingControllerClient.clear();
                        }
                      },
                    ),
                  ),
                );
              } else if (snapshot.hasError) {
                return Center(
                  child: Text('No hay datos de clientes...'),
                );
              }

              return Center(
                child: CircularProgressIndicator(),
              );
            },
          ),
          FutureBuilder(
            future: listaProductos,
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return Container(
                  child: DropdownButtonHideUnderline(
                    child: DropdownButton2<String>(
                      isExpanded: true,
                      hint: Text(
                        'Seleccionar producto',
                        style: TextStyle(
                          fontSize: 14,
                          color: Theme.of(context).hintColor,
                        ),
                      ),
                      items: snapshot.data! //items
                          .map((item) => DropdownMenuItem(
                                value: '${item.producto} - ${item.id}',
                                child: Text(
                                  item.producto,
                                  style: const TextStyle(
                                    fontSize: 14,
                                  ),
                                ),
                              ))
                          .toList(),
                      value: selectedValueProduct,
                      onChanged: (value) {
                        setState(() {
                          selectedValueClient = value;
                        });
                      },
                      buttonStyleData: const ButtonStyleData(
                        padding: EdgeInsets.symmetric(horizontal: 16),
                        height: 40,
                        width: 200,
                      ),
                      dropdownStyleData: const DropdownStyleData(
                        maxHeight: 200,
                      ),
                      menuItemStyleData: const MenuItemStyleData(
                        height: 40,
                      ),
                      dropdownSearchData: DropdownSearchData(
                        searchController: textEditingControllerProduct,
                        searchInnerWidgetHeight: 50,
                        searchInnerWidget: Container(
                          height: 50,
                          padding: const EdgeInsets.only(
                            top: 8,
                            bottom: 4,
                            right: 8,
                            left: 8,
                          ),
                          child: TextFormField(
                            expands: true,
                            maxLines: null,
                            controller: textEditingControllerProduct,
                            decoration: InputDecoration(
                              isDense: true,
                              contentPadding: const EdgeInsets.symmetric(
                                horizontal: 10,
                                vertical: 8,
                              ),
                              hintText: 'Buscar un cliente...',
                              hintStyle: const TextStyle(fontSize: 12),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(8),
                              ),
                            ),
                          ),
                        ),
                        searchMatchFn: (item, searchValue) {
                          return item.value.toString().contains(searchValue);
                        },
                      ),
                      //This to clear the search value when you close the menu
                      onMenuStateChange: (isOpen) {
                        if (!isOpen) {
                          textEditingControllerClient.clear();
                        }
                      },
                    ),
                  ),
                );
              } else if (snapshot.hasError) {
                return Center(
                  child: Text('No hay datos de clientes...'),
                );
              }

              return Center(
                child: CircularProgressIndicator(),
              );
            },
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 6.0),
              child: Column(
                children: [
              
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                  Text('Precio:'),
                  Text('Existencia:'),
              ],
              ),
                  
                 
                  
                  
                ],
              ),
            ),
          ),
           Expanded(
             child: Padding(
               padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 6.0),
               child: Column(
                children: [
                         
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                  TextFormField(
                    controller: textEditingControllerCantidad,
                    inputFormatters: [maskCantidad],
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration( hintText: 'Cantidad'),
                  ),
                  Text('Sub-Total:'),
               ],
               ),
                  
                 
                  
                  
                ],
                         ),
             ),
           )
        ],
      ),
    );
  }
}
// ignore_for_file: public_member_api_docs, sort_constructors_first
class Producto {
    final String id;
    final String codigo;
    final String producto;
    final String idcategoria;
    final String existencia;
  Producto({
    required this.id,
    required this.codigo,
    required this.producto,
    required this.idcategoria,
    required this.existencia,
  });

  
   Map toJson() => {
    'id': id,
    'codigo': codigo,
    'producto': producto,
    'idcategoria': idcategoria,
    'existencia': existencia,
    
  };

}

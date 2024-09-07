// ignore_for_file: public_member_api_docs, sort_constructors_first
class Precio {
  final String id;
  final String codigo;
  final String precio;
  final String idproducto;
  Precio({
    required this.id,
    required this.codigo,
    required this.precio,
    required this.idproducto,
  });

   Map toJson() => {
    'id': id,
    'codigo': codigo,
    'precio': precio,
    'idproducto': idproducto,
    
  };
}

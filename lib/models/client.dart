// ignore_for_file: public_member_api_docs, sort_constructors_first
class Cliente {
  final String id;
  final String cliente;
  final String rif;
  final String grupocliente;
  Cliente({
    required this.id,
    required this.cliente,
    required this.rif,
    required this.grupocliente,
  });

   Map toJson() => {
    'id': id,
    'cliente': cliente,
    'rif': rif,
    'grupo_cliente': grupocliente,
  };
  
}

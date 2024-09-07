// ignore_for_file: public_member_api_docs, sort_constructors_first
class Categoria {
  final  String id;
   final  String categoria;
  
  Categoria({
    required this.id,
    required this.categoria,
  });


  Map toJson() => {
    'id': id,
    'categoria': categoria,
  };

}

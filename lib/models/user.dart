class Usuario {
  final String id;
  final String fullNAme;
  final String userEmail;
 
  Usuario({
    required this.id,
    required this.fullNAme,
    required this.userEmail,

  });
  

  Map toJson() => {
    'id': id,
    'full_name': fullNAme,
    'email': userEmail,
  };
}

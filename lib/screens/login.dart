import 'package:app_pedido/inherited/my_inherited.dart';
import 'package:app_pedido/storage/user_storage.dart';
import 'package:flutter/material.dart';
import 'package:app_pedido/components/my_appbar.dart';
import 'package:app_pedido/models/profile.dart';
import 'package:app_pedido/screens/dashboard.dart';
import 'package:app_pedido/models/auth.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final supabase = Supabase.instance.client;
  late bool passwordVisible;
  late Future<Auth> loginUser;

  final userStorage = UserStorage();

 final  emailUser = TextEditingController();
 final passwordUser = TextEditingController();

 @override
  void dispose() {
     emailUser.dispose();
     passwordUser.dispose();
    super.dispose();
  }


 void toogle (){
  setState(() {
    passwordVisible = !passwordVisible;
  });
 }

 @override
  void initState() {
    super.initState();
    passwordVisible = true;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyAppBar(),
      body:cuerpo(),
    ); 
  }

  Widget cuerpo() {
    return Center(
    child:  Column(
      mainAxisAlignment:MainAxisAlignment.center ,
      children: [
        titulo(),
        SizedBox(height: 22.0,),
        email(),
        clave(),
        SizedBox(
          height: 22.0,
          ),
        entrar(),
      ],
    ),
  );
  }

  Widget titulo() {
   return Text('Inicio de Session', 
   style: TextStyle(
    fontSize: 18.0, 
    fontWeight: FontWeight.bold,
   ),
   );
    } 

  Widget email() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical:1.0 ),
      child: TextField(
        controller: emailUser,
        decoration: InputDecoration(
          hintText: 'Escribe tu  correo',
        ),
        autocorrect: true,
        style: TextStyle(fontSize: 18.0),
        ),
    );
  }

   Widget clave() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical:1.0 ),
      child: TextField(
        controller: passwordUser,
        decoration: InputDecoration(
          hintText: 'Escribe tu contaseña',
          suffixIcon: IconButton(
            onPressed: () {
              toogle();
            
          },icon:
          Icon(passwordVisible ? Icons.visibility : Icons.visibility_off),
          color: Theme.of(context).primaryColor,
        ),
        ),
        obscureText: passwordVisible,
        style: TextStyle(fontSize: 18.0),
        ),
    );
  }
     Widget entrar() {
      return ElevatedButton.icon(
        onPressed:(){
        loginUser =  authUser();
        loginUser.then((value) => {
          value.accessToken.isNotEmpty 
          ? goDashboard(value.id, value.accessToken, value.tokenType, value.userEmail)
          :msgErrorLogin()
        });

        },
       icon: Icon(Icons.login_rounded),
        label: Text('Entrar', style: TextStyle(fontSize: 18.0),),
        );
     }

     Future<Auth> authUser() async {
      try {
      final  response =  await supabase.auth.signInWithPassword(
        email:emailUser.text, 
        password: passwordUser.text,
        );

        final session = response.session!;
        final  user =response.user!;

        return Auth(
          id: user.id,
          accessToken: session.accessToken,
           tokenType: session.tokenType,
           userEmail:user.email.toString(),
           );

      } catch (ex){
        return const Auth(
          id: '',
          accessToken: '', 
          tokenType: '',
          userEmail:'',
          );
      }

     }

     Future <Profile> obtenerPerfil(String id) async {
      final response = await supabase.from('profiles').select('*').eq('id', id);
      return Profile(fullName: response[0]['full_name']);
      
     }

    void goDashboard (String id, accessToken, String tokenType, String userEmail) {
      obtenerPerfil(id).then(
        (perfil){
          GetInfoUser.of(context).setId(id);
          GetInfoUser.of(context).setAccessToken(accessToken);
          GetInfoUser.of(context).setTokenType(tokenType);
          GetInfoUser.of(context).setUserEmail(userEmail);
          GetInfoUser.of(context).setFullName(perfil.fullName);
        
          userStorage.writerUser(id, perfil.fullName, userEmail);

       Navigator.push(
        context,
        MaterialPageRoute(
          builder:  (context) => Dashboard(),
        ),
      );

        }
      );
     
     }

     void msgErrorLogin() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Aviso importante'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text('Credenciales no registradas'),
          ],
        ),
        actions: [
          TextButton.icon(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: Icon(Icons.check_circle),
            label: Text('Aceptar'),
          ),
        ],
      ),
    );
  }

}
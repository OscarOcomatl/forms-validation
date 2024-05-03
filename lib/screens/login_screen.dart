import 'package:flutter/material.dart';
// import 'package:flutter/widgets.dart';
import 'package:productos_app/widgets/widgets.dart';
import 'package:productos_app/ui/input_decorations.dart';

class LoginScreen extends StatelessWidget {
   
  const LoginScreen({Key? key}) : super(key: key);
  
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      body: AuthBrackground(
        // child: Container(width: double.infinity, height: 200, color: Colors.red),
        child: SingleChildScrollView(
          child: Column(
            children: [
              const SizedBox( height: 250), // Para agregar una separacion
              CardContainer(
                child: Column(
                  children: [
                    const SizedBox( height: 10),
                    Text('Login', style: Theme.of(context).textTheme.headlineMedium,),
                    const SizedBox( height: 20),
                    _LoginForm()
                  ],
                ),
              ),
              const SizedBox(height: 50),
              Text('Crear una nueva cuenta', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),),
              SizedBox(height: 50,)
            ],
          ),
        ),
      ) // Este es el background morado
    );
  }
}

class _LoginForm extends StatelessWidget {
  const _LoginForm({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Form(
        //TODO: Mantener la referencia al KEY
        child: Column(
          children: [
            TextFormField(
              autocorrect: false,
              keyboardType: TextInputType.emailAddress,
              decoration: InputDecorations.authInputDecoration(
                hintText: 'alguien@gmail.com',
                labelText: 'Correo electronico',
                prefixIcon: Icons.alternate_email_rounded
                ),
            ),
            const SizedBox(height: 30,),
            TextFormField(
              autocorrect: false,
              obscureText: true,
              keyboardType: TextInputType.emailAddress,
              decoration: InputDecorations.authInputDecoration(
                hintText: '*******',
                labelText: 'Contraseña',
                prefixIcon: Icons.lock_rounded
              ),
            ),
            
            const SizedBox(height: 30,),
            MaterialButton(
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
              disabledColor: Colors.grey,
              elevation: 0,
              color:Colors.deepPurple,
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 80, vertical: 15),
                child: Text(
                  'Ingresar',
                  style: TextStyle(color: Colors.white),
                ),
              ),
              onPressed: (){
                //T
              }
            )
          ],
        ),
      ),
    );
  }
}
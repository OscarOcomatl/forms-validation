import 'package:flutter/material.dart';
import 'package:productos_app/providers/login_form_provider.dart';
import 'package:productos_app/services/services.dart';
// import 'package:flutter/widgets.dart';
import 'package:productos_app/widgets/widgets.dart';
import 'package:productos_app/ui/input_decorations.dart';
import 'package:provider/provider.dart';

class RegisterScreen extends StatelessWidget {
   
  const RegisterScreen({Key? key}) : super(key: key);
  
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
                    Text('Crear cuenta', style: Theme.of(context).textTheme.headlineMedium,),
                    const SizedBox( height: 20),
                    ChangeNotifierProvider(
                      create: ( _ ) => LoginFormProvider(),
                      child: _LoginForm(),
                    ),
                    // _LoginForm()
                  ],
                ),
              ),
              const SizedBox(height: 50),
              TextButton(
                onPressed: () => Navigator.pushReplacementNamed(context, 'register'),
                style: ButtonStyle(
                  overlayColor: MaterialStateProperty.all(Colors.indigo.withOpacity(0.1)),
                  shape: MaterialStateProperty.all(const StadiumBorder())
                ),
                child: Text('¿Ya tienes una cuenta?', style: TextStyle(fontSize: 18, color: Colors.indigo.withOpacity(0.9)),)
              ),
              const SizedBox(height: 50,)
            ],
          ),
        ),
      ) // Este es el background morado
    );
  }
}

class _LoginForm extends StatelessWidget {
  //  _LoginForm({super.key});


  @override
  Widget build(BuildContext context) {
    final loginForm = Provider.of<LoginFormProvider>(context);
    return Container(
      child: Form(
        //TODO: Mantener la referencia al KEY
        key: loginForm.formKey,
        autovalidateMode: AutovalidateMode.onUserInteraction,
        child: Column(
          children: [
            TextFormField(
              autocorrect: false,
              keyboardType: TextInputType.emailAddress,
              decoration: InputDecorations.authInputDecoration(
                // String pattern = r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
                hintText: 'alguien@gmail.com',
                labelText: 'Correo electronico',
                prefixIcon: Icons.alternate_email_rounded
                ),
                onChanged: (value) => loginForm.email = value,
                validator: (value) {
                String pattern = r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
                RegExp regExp =  RegExp(pattern);
                return regExp.hasMatch(value ?? '')
                  ? null
                  : 'El valor ingresado no luce como un correo';
                },
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
              onChanged: (value) => loginForm.password = value,
              validator: (value) {
                  return (value != null && value.length >= 6) 
                  ? null
                  : 'La contraseña debe ser de 6 caracteres}';
              },
            ),
            
            const SizedBox(height: 30,),
            MaterialButton(
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
              disabledColor: Colors.grey,
              elevation: 0,
              color:Colors.deepPurple,
              onPressed: loginForm.isLoading ? null : () async {

                FocusScope.of(context).unfocus();
                final authService = Provider.of<AuthService>(context, listen: false);

                if(!loginForm.isValidForm()) return;
                loginForm.isLoading = true;

                //TODO: Validar si el login es correcto
                final String? errorMessage = await authService.createUser(loginForm.email, loginForm.password);
                if(errorMessage == null){
                  Navigator.pushReplacementNamed(context, 'home');
                }else{
                  // TODO: Mostrar error en pantalla
                  print(errorMessage);
                  loginForm.isLoading = false;
                }
                // Future.delayed(const Duration(seconds: 2));
              },
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 79, vertical: 15),
                  child: Wrap(
                    children: [
                      Text(
                      loginForm.isLoading
                      ? 'Espere'
                      : 'Ingresar',
                      style: const TextStyle(color: Colors.white,fontSize: 14),
                    ),
                    ]
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
import 'package:examen_final/provider/provider.dart';
import 'package:examen_final/services/auth_service.dart';
import 'package:examen_final/ui/input_decorations.dart';
import 'package:examen_final/widget/auth_background.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../widget/card_container.dart';

class RegisterUserScreen extends StatelessWidget{
  const RegisterUserScreen ({super.key});

  @override
  Widget build(BuildContext context){
    return Scaffold(
      body: AuthBackground(
        child: SingleChildScrollView(
          child: Column(
            children: [
              const SizedBox(
                height: 150
              ),
              CardContainer(
                child: Column(
                  children: [
                    const SizedBox(height: 10),
                    Text(
                      'Registrar una cuenta',
                    ),
                    const SizedBox(height: 30),
                    ChangeNotifierProvider(
                      create: (_) => LoginFormProvider(),
                      child: RegisterForm(),
                    ),
                    const SizedBox(height: 50),
                    TextButton(
                      onPressed: ()=>Navigator.pushReplacementNamed(context, 'add_user'),
                      style: ButtonStyle(
                        overlayColor: MaterialStateProperty.all(
                          Colors.indigo.withOpacity(0.1)),
                        shape: MaterialStateProperty.all(StadiumBorder())
                      ),
                      child: const Text('Ya tienes cuenta? autentificate'),
                  )
              ])),
            ],
          ),
        ),
      ),
    );
  }
}

class RegisterForm extends StatelessWidget{
  const RegisterForm({super.key});

  @override
  Widget build(BuildContext context) {
    final LoginForm = Provider.of<LoginFormProvider>(context);
      return Container(
        child: Form(
          key: LoginForm.formkey,
          autovalidateMode: AutovalidateMode.onUserInteraction,
          child: Column(
            children: [
              TextFormField(
                autocorrect: false,
                keyboardType: TextInputType.text,
                decoration: InputDecorations.authInputDecoration(
                  hinText: 'Ingresa su correo',
                  labelText: 'Email',
                  prefixIcon: Icons.people,
                ),
                onChanged: (value) => LoginForm.email = value,
                validator: (value){
                  return (value != null && value.length >= 4)
                    ? null
                    :'El usuario no puede estar vacio';
                },
             ),
            const SizedBox(height: 30),
            TextFormField(
              autocorrect: false,
              obscureText: true,
              keyboardType: TextInputType.text,
              decoration: InputDecorations.authInputDecoration(
              hinText: '**********',
              labelText: 'Password',
              prefixIcon: Icons.lock_outline,
              ),
              onChanged: (value) => LoginForm.password = value,
              validator: (value){
                return (value != null && value.length >= 4)
                  ? null
                  : 'La contraseña no puede estar vacia';
              },
          ),
          const SizedBox(height: 30),
          MaterialButton(
            shape: RoundedRectangleBorder(  
              borderRadius: BorderRadius.circular(10),
            ),
            disabledColor: Colors.grey,
            color: Colors.orange,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 80, vertical: 10),
              child: Text(
                'Registrar',
                style: const TextStyle(color: Colors.white),
              ),
            ),
            elevation: 0,
              onPressed: LoginForm.isLoading
                ?null
                :() async {
                    FocusScope.of(context).unfocus();
                    final authService =
                        Provider.of<AuthService>(context, listen: false);
                    if (!LoginForm.isValiForm()) return;
                      LoginForm.isLoading = true;
                    final String? errorMessage = await authService.create_user(
                        LoginForm.email, LoginForm.password);
                    if(errorMessage == null){
                      Navigator.pushNamed(context, 'login');
                    }else{
                      print(errorMessage);
                    }
                  },
          )
        ]),
      ),
    );
  }
}
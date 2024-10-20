import 'package:flutter/material.dart';
import 'package:examen_final/provider/login_form_provider.dart';
import 'package:provider/provider.dart';
import '../ui/input_decorations.dart';
import '../widget/widgets.dart';
import 'package:examen_final/services/auth_service.dart';


class LoginScreen extends StatelessWidget {
  const LoginScreen ({super.key});
  @override
  Widget build(BuildContext context){
    return Scaffold(
      body: AuthBackground(
        child: SingleChildScrollView(
          child: Column(
            children: [
              const SizedBox(height: 150),
              CardContainer(
                child: Column(
                  children: [
                    const SizedBox(height: 10),
                    Text('Login'),
                    const SizedBox(height: 30),
                    ChangeNotifierProvider(
                      create: (_) => LoginFormProvider(),
                      child: LoginFrom(),
                    ),
                    const SizedBox(height: 30),
                    TextButton(
                      onPressed: ()=>Navigator.pushReplacementNamed(context, 'add_user'),
                      style: ButtonStyle(
                        overlayColor: MaterialStateProperty.all(
                          Colors.indigo.withOpacity(0.1)),
                        shape: MaterialStateProperty.all(StadiumBorder()),

                      ),
                      child: const Text('No tienes contraseña? creala'))
                  ],
                ))
            ]
          )
        )
      ),
    );
  }
}

class LoginFrom extends StatelessWidget{
  const LoginFrom({super.key});

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
                  : 'El usuario no puede estar vacio';
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
                  'Ingresar',
                  style: const TextStyle(color: Colors.white),
                ),
              ),
              elevation: 0,
              onPressed: LoginForm.isLoading
                ?null
                : () async {
                  FocusScope.of(context).unfocus();
                  final authService = 
                    Provider.of<AuthService>(context, listen: false);
                  if (!LoginForm.isValiForm()) return;
                  LoginForm.isLoading = true;
                  final String? errorMessage = await authService.login(
                    LoginForm.email, LoginForm.password);
                  if(errorMessage == null){
                    Navigator.pushNamed(context, 'list');
                  }else{
                    print(errorMessage);
                  }
                  LoginForm.isLoading = false;
                                  
                },
            )
          ]
        ),
      ),
    );
  }
}


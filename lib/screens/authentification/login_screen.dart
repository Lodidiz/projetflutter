//import 'dart:js';
//import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:projet/bloc/auth_bloc.dart';
import 'package:projet/screens/home_screen.dart';

//import 'package:projet/screens/home_screen.dart'
import 'register_screen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  bool _isValidEmail(String email) {
    final RegExp emailRegExp = RegExp(
      r'^[\w-]+(\.[\w-]+)*@([A-Za-z0-9-]+\.)+[A-Za-z]{2,6}$',
    );
    return emailRegExp.hasMatch(email);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF1A2025),
      body: SafeArea(
        child: Stack(
          children: <Widget>[
            SvgPicture.asset(
              'res/lunacy/Bg.svg',
              fit: BoxFit.cover,
              height: double.infinity,
              width: double.infinity,
              alignment: Alignment.center,
            ),
            Center(
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(32),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    SizedBox(height: MediaQuery.of(context).size.height * 0.1),
                    const Text(
                      'Bienvenue !',
                      style: TextStyle(
                        fontFamily: 'GoogleSansBold',
                        fontSize: 30,
                        color: Colors.white,
                      ),
                    ),
                    const SizedBox(height: 16),
                    const Text(
                      'Veuillez vous connecter ou\n'
                      'créer un nouveau compte pour\n'
                      "utiliser l'application.",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontFamily: 'Proxima',
                        fontWeight: FontWeight.w500,
                        fontSize: 15,
                        color: Colors.white,
                      ),
                    ),
                    const SizedBox(height: 32),
                    TextField(
                      controller: _emailController,
                      keyboardType: TextInputType.emailAddress,
                      textAlign: TextAlign.center,
                      decoration: InputDecoration(
                        filled: true,
                        fillColor: const Color(0xFF1E262C),
                        labelText: 'E-mail',
                        labelStyle: const TextStyle(
                          fontFamily: 'Proxima',
                          fontSize: 15,
                          color: Colors.white,
                        ),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(3),
                        ),
                      ),
                      style: const TextStyle(
                        color: Colors.white,
                      ),
                    ),
                    const SizedBox(height: 16),
                    TextField(
                      controller: _passwordController,
                      obscureText: true,
                      textAlign: TextAlign.center,
                      decoration: InputDecoration(
                        filled: true,
                        fillColor: const Color(0xFF1E262C),
                        labelText: 'Mot de passe',
                        labelStyle: const TextStyle(
                          fontFamily: 'Proxima',
                          fontSize: 15,
                          color: Colors.white,
                        ),

                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(2),
                        ),
                      ),
                      style: const TextStyle(
                        color: Colors.white,
                      ),
                    ),
                    const SizedBox(height: 70),
                    Container(
                      height: 46,
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: () {
                          String email = _emailController.text.trim();
                          String password = _passwordController.text.trim();

                          // Récupérer le bloc de l'authentification
                          AuthBloc authBloc =
                              BlocProvider.of<AuthBloc>(context);

                          // Envoyer un événement de connexion au bloc
                          authBloc.add(SignInEvent(email, password));
                        },
                        child: Text(
                          'Se connecter',
                          style: TextStyle(
                            fontFamily: 'Proxima',
                            fontSize: 15,
                            color: Colors.white,
                          ),
                        ),
                        style: ElevatedButton.styleFrom(
                          primary: const Color(0xFF636AF6),
                          padding: const EdgeInsets.symmetric(vertical: 12),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(2),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 16),
                    Container(
                      height: 46,
                      width: double.infinity,
                      child: OutlinedButton(
                        onPressed: () {
                          // Naviguer vers la page RegisterScreen
                          Navigator.push(
                              context,
                              MaterialPageRoute<void>(
                                  builder: (BuildContext context) =>
                                      BlocProvider<AuthBloc>.value(
                                          value: BlocProvider.of<AuthBloc>(
                                              context),
                                          child: RegisterScreen())));
                        },
                        child: const Text(
                          'Créer un nouveau compte',
                          style: TextStyle(
                            fontFamily: 'Proxima',
                            fontSize: 15,
                            color: Colors.white,
                          ),
                        ),
                        style: OutlinedButton.styleFrom(
                          padding: const EdgeInsets.symmetric(vertical: 12),
                          side: const BorderSide(color: Color(0xFF636AF6)),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(2),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            BlocListener<AuthBloc, AuthState>(
              listener: (BuildContext context, AuthState state) {
                if (state is AuthSignInSuccess) {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute<void>(
                      builder: (BuildContext context) => const HomePage(),
                    ),
                  );
                } else if (state is ErrorState) {
                  // Afficher un message d'erreur
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text(state.message)),
                  );
                }
              },
              child: BlocBuilder<AuthBloc, AuthState>(
                builder: (BuildContext context, AuthState state) {
                  // Afficher un indicateur de chargement si l'état est LoadingState
                  if (state is LoadingState) {
                    return const Center(child: CircularProgressIndicator());
                  } else {
                    return Container(); // Retourner un conteneur vide pour les autres états
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

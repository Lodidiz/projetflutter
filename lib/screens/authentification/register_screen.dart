import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:projet/bloc/auth_bloc.dart';
import 'package:projet/screens/authentification//login_screen.dart';

class RegisterScreen extends StatefulWidget {
  @override
  _RegisterScreenState createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController();

  @override
  void dispose() {
    _usernameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
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
            BlocListener<AuthBloc, AuthState>(
              listener: (BuildContext context, AuthState state) {
                if (state is AuthSignUpSuccess) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('Inscription réussie!')),
                  );
                  Navigator.of(context).pushReplacement(
                    MaterialPageRoute<LoginScreen>(
                        builder: (BuildContext context) => LoginScreen()),
                  );
                } else if (state is ErrorState) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text(state.message)),
                  );
                }
              },
              child: BlocBuilder<AuthBloc, AuthState>(
                builder: (BuildContext context, AuthState state) {
                  return Center(
                    child: SingleChildScrollView(
                      padding: EdgeInsets.all(32),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          SizedBox(
                              height: MediaQuery.of(context).size.height * 0.1),
                          const Text(
                            'Inscription',
                            style: TextStyle(
                              fontFamily: 'GoogleSansBold',
                              fontSize: 30,
                              color: Colors.white,
                            ),
                          ),
                          const SizedBox(height: 16),
                          const Text(
                            'Veuillez saisir ces différentes informations,\n'
                            'afin que vos listes soient sauvegardées.',
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
                            controller: _usernameController,
                            keyboardType: TextInputType.name,
                            textAlign: TextAlign.center,
                            decoration: InputDecoration(
                              filled: true,
                              fillColor: Color(0xFF1E262C),
                              labelText: 'Nom d\'utilisateur',
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
                          const SizedBox(height: 16),
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
                                borderRadius: BorderRadius.circular(2),
                              ),
                            ),
                            style: const TextStyle(
                              color: Colors.white,
                            ),
                          ),
                          SizedBox(height: 16),
                          TextField(
                            controller: _passwordController,
                            keyboardType: TextInputType.visiblePassword,
                            textAlign: TextAlign.center,
                            obscureText: true,
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
                          const SizedBox(height: 16),
                          TextField(
                            controller: _confirmPasswordController,
                            keyboardType: TextInputType.visiblePassword,
                            textAlign: TextAlign.center,
                            obscureText: true,
                            decoration: InputDecoration(
                              filled: true,
                              fillColor: Color(0xFF1E262C),
                              labelText: 'Confirmez le mot de passe',
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
                          const SizedBox(height: 32),
                          Container(
                            height: 46,
                            width: double.infinity,
                            child: ElevatedButton(
                              onPressed: () {
                                if (_usernameController.text.isNotEmpty &&
                                    _emailController.text.isNotEmpty &&
                                    _passwordController.text.isNotEmpty &&
                                    _confirmPasswordController
                                        .text.isNotEmpty) {
                                  if (_passwordController.text ==
                                      _confirmPasswordController.text) {
                                    BlocProvider.of<AuthBloc>(context).add(
                                      SignUpEvent(
                                        _usernameController.text,
                                        _emailController.text,
                                        _passwordController.text,
                                      ),
                                    );
                                  } else {
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      const SnackBar(
                                          content: Text(
                                              'Les mots de passe ne correspondent pas.')),
                                    );
                                  }
                                } else {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    const SnackBar(
                                        content: Text(
                                            'Veuillez remplir tous les champs.')),
                                  );
                                }
                              },
                              child: Text(
                                'Inscription',
                                style: TextStyle(
                                  fontFamily: 'GoogleSansBold',
                                  fontSize: 15,
                                  color: Colors.white,
                                ),
                              ),
                              style: ElevatedButton.styleFrom(
                                primary: Color(0xFF636AF6),
                                padding: EdgeInsets.symmetric(vertical: 16),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(2),
                                ),
                                minimumSize: Size(
                                  MediaQuery.of(context).size.width - 64,
                                  48,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

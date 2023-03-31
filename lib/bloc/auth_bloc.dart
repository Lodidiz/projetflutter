import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

// Événements
abstract class AuthEvent {}

class SignInEvent extends AuthEvent {
  final String email;
  final String password;

  SignInEvent(this.email, this.password);
}

class SignUpEvent extends AuthEvent {
  final String username;
  final String email;
  final String password;

  SignUpEvent(this.username, this.email, this.password);
}

// États
abstract class AuthState {}

class InitialState extends AuthState {}

class LoadingState extends AuthState {}

class AuthSignInSuccess extends AuthState {
  final User user;

  AuthSignInSuccess(this.user);
}

class AuthSignUpSuccess extends AuthState {
  final User user;

  AuthSignUpSuccess(this.user);
}

class ErrorState extends AuthState {
  final String message;

  ErrorState(this.message);
}

// BLoC
class AuthBloc extends Bloc<AuthEvent, AuthState> {
  AuthBloc() : super(InitialState()) {
    on<SignInEvent>(_onSignInEvent);
    on<SignUpEvent>(_onSignUpEvent);
  }

  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  Future<void> _onSignInEvent(
      SignInEvent event, Emitter<AuthState> emit) async {
    emit(LoadingState());
    try {
      UserCredential userCredential =
          await _firebaseAuth.signInWithEmailAndPassword(
        email: event.email,
        password: event.password,
      );
      User? user = userCredential.user;
      emit(AuthSignInSuccess(user!));
    } on FirebaseAuthException catch (e) {
      emit(ErrorState(e.message ?? 'Erreur inconnue'));
    }
  }

  Future<void> _onSignUpEvent(
      SignUpEvent event, Emitter<AuthState> emit) async {
    emit(LoadingState());
    try {
      UserCredential userCredential =
          await _firebaseAuth.createUserWithEmailAndPassword(
        email: event.email,
        password: event.password,
      );
      User? user = userCredential.user;


      await FirebaseFirestore.instance
          .collection('users')
          .doc(user?.uid)
          .set(<String, dynamic>{
        'username': event.username,
        'email': event.email,
      });

      emit(AuthSignUpSuccess(user!));
    } on FirebaseAuthException catch (e) {
      emit(ErrorState(e.message ?? 'Erreur inconnue'));
    }
  }
}

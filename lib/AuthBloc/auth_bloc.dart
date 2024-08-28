import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'auth_event.dart';
import 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  AuthBloc() : super(AuthInitial()) {
    on<AuthSignInEvent>(_Signin);
    on<AuthSignOutEvent>(_Signout);
  }

  FutureOr<void> _Signin(AuthSignInEvent event, Emitter<AuthState> emit) async {
    emit(AuthLoading());
    try {
      await _firebaseAuth
          .signInWithEmailAndPassword(
        email: event.email,
        password: event.password,
      )
          .then((_) {
        emit(AuthAuthenticated());
      });
    } catch (e) {
      emit(AuthError(e.toString()));
    }
  }

  FutureOr<void> _Signout(
      AuthSignOutEvent event, Emitter<AuthState> emit) async {
    emit(AuthLoading());
    await _firebaseAuth.signOut().then((value) {
      emit(AuthUnauthenticated());
    });
  }
}

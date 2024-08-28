import 'package:crash_firebase/imageurl.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'AuthBloc/auth_bloc.dart';
import 'AuthBloc/auth_event.dart';
import 'AuthBloc/auth_state.dart';

class LoginPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Login')),
      body: LoginForm(),
    );
  }
}

class LoginForm extends StatelessWidget {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  Future<void> _logEvent() async {
    await FirebaseAnalytics.instance.logEvent(
      name: 'test_event',
    );
    FirebaseAnalytics.instance.setCurrentScreen(screenName: "LOgin");
  }

  @override
  Widget build(BuildContext context) {
    _logEvent();
    return BlocConsumer<AuthBloc, AuthState>(
      listener: (context, state) {
        if (state is AuthError) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(state.message)),
          );
        } else if (state is AuthAuthenticated) {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) => ImagePage(),
            ),
          );
        }
      },
      builder: (context, state) {
        return Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextField(
                controller: emailController,
                decoration: InputDecoration(labelText: 'Email'),
                keyboardType: TextInputType.emailAddress,
              ),
              TextField(
                controller: passwordController,
                decoration: InputDecoration(labelText: 'Password'),
                obscureText: true,
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  final email = emailController.text;
                  final password = passwordController.text;
                  context
                      .read<AuthBloc>()
                      .add(AuthSignInEvent(email: email, password: password));
                },
                child: Text('Sign In'),
              ),
              if (state is AuthLoading) CircularProgressIndicator(),
            ],
          ),
        );
      },
    );
  }
}

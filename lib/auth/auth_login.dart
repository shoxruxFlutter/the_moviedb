import 'package:flutter/material.dart';
import 'package:the_moviedb/theme/app_button_style.dart';

class AuthLogin extends StatefulWidget {
  const AuthLogin({super.key});

  @override
  State<AuthLogin> createState() => _AuthLoginState();
}

class _AuthLoginState extends State<AuthLogin> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Login to your account'),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15),
        child: ListView(
          children: const [
            AuthField(),
            InfoField(),
          ],
        ),
      ),
    );
  }
}

class AuthField extends StatefulWidget {
  const AuthField({super.key});

  @override
  State<AuthField> createState() => _AuthFieldState();
}

class _AuthFieldState extends State<AuthField> {
  final _loginController = TextEditingController(text: 'admin');
  final _passwordController = TextEditingController(text: 'admin');
  String? errorText;
  void _auth() {
    final login = _loginController.text;
    final password = _passwordController.text;
    if (login == 'admin' && password == 'admin') {
      errorText = null;
      Navigator.of(context).pushReplacementNamed('/main_screen');
    } else {
      errorText = 'Не верный логин или пароль';
    }
    setState(() {});
  }

  void _resetPassword() {}

  @override
  Widget build(BuildContext context) {
    const textStyleDecoration = InputDecoration(
        contentPadding: EdgeInsets.all(12),
        isCollapsed: true,
        border: OutlineInputBorder());

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (errorText != null) ...[
          const SizedBox(height: 20),
          Text(
            errorText!,
            style: const TextStyle(fontSize: 17, color: Colors.red),
          ),
        ],
        const SizedBox(height: 20),
        const Text(
          'Username',
          style: TextStyle(fontSize: 16),
        ),
        const SizedBox(height: 5),
        TextField(
          controller: _loginController,
          decoration: textStyleDecoration,
        ),
        const SizedBox(height: 20),
        const Text('Password'),
        const SizedBox(height: 5),
        TextField(
          controller: _passwordController,
          obscureText: true,
          decoration: textStyleDecoration,
        ),
        const SizedBox(height: 20),
        Row(
          children: [
            ElevatedButton(
              onPressed: _auth,
              child: const Text('Login'),
            ),
            const SizedBox(width: 10),
            TextButton(
              onPressed: _resetPassword,
              style: AppButtonStyle.linkButton,
              child: const Text('Reset password'),
            )
          ],
        )
      ],
    );
  }
}

class InfoField extends StatelessWidget {
  const InfoField({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 20),
        const Text(
          'In order to use the editing and rating capabilities of TMDB, as well as get personal recommendations you will need to login to your account. If you do not have an account, registering for an account is free and simple.',
          style: TextStyle(fontSize: 16),
        ),
        TextButton(
          onPressed: () {},
          style: AppButtonStyle.linkButton,
          child: const Text('Register'),
        ),
        const SizedBox(height: 16),
        const Text(
          'If you signed up but didn`t get your verification email.',
          style: TextStyle(fontSize: 16),
        ),
        TextButton(
          onPressed: () {},
          style: AppButtonStyle.linkButton,
          child: const Text('Verify email'),
        ),
      ],
    );
  }
}

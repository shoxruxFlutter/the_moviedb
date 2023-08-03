import 'package:flutter/material.dart';
import 'package:the_moviedb/library/widgets/inherited/provider.dart';
import 'package:the_moviedb/ui/theme/app_button_style.dart';
import 'package:the_moviedb/ui/widgets/auth/auth_model.dart';

class AuthWidget extends StatefulWidget {
  const AuthWidget({super.key});

  @override
  State<AuthWidget> createState() => _AuthWidgetState();
}

class _AuthWidgetState extends State<AuthWidget> {
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
            _FormWidget(),
            _HeaderWidget(),
          ],
        ),
      ),
    );
  }
}

class _HeaderWidget extends StatelessWidget {
  const _HeaderWidget();

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

class _FormWidget extends StatelessWidget {
  const _FormWidget();

  @override
  Widget build(BuildContext context) {
    final model = NotifierProvider.read<AuthModel>(context);
    const textStyle = TextStyle(
      fontSize: 16,
      color: Color(0xFF212529),
    );
    const textFieldDecorator = InputDecoration(
      border: OutlineInputBorder(),
      contentPadding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
      isCollapsed: true,
      fillColor: Colors.red,
      focusColor: Colors.red,
      hoverColor: Colors.red,
    );

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 20),
        const _ErrorMessageWidget(),
        const Text(
          'Username',
          style: textStyle,
        ),
        const SizedBox(height: 5),
        TextField(
          controller: model?.loginTextController,
          decoration: textFieldDecorator,
        ),
        const SizedBox(height: 20),
        const Text(
          'Password',
          style: textStyle,
        ),
        const SizedBox(height: 5),
        TextField(
          controller: model?.passwordTextController,
          obscureText: true,
          decoration: textFieldDecorator,
        ),
        const SizedBox(height: 20),
        Row(
          children: [
            const _AuthButtonWidget(),
            const SizedBox(width: 10),
            TextButton(
              onPressed: () {},
              style: AppButtonStyle.linkButton,
              child: const Text('Reset password'),
            )
          ],
        )
      ],
    );
  }
}

class _AuthButtonWidget extends StatelessWidget {
  const _AuthButtonWidget();

  @override
  Widget build(BuildContext context) {
    final model = NotifierProvider.watch<AuthModel>(context);
    const color = Color(0xFF01B4E4);
    final onPressed =
        model?.canStartAuth == true ? () => model?.auth(context) : null;
    final child = model?.isAuthProgress == true
        ? const SizedBox(
            height: 15,
            width: 15,
            child: CircularProgressIndicator(strokeWidth: 2),
          )
        : const Text('Login');
    return ElevatedButton(
      onPressed: onPressed,
      style: ButtonStyle(
        backgroundColor: MaterialStateProperty.all(color),
        foregroundColor: MaterialStateProperty.all(Colors.white),
        textStyle: MaterialStateProperty.all(
          const TextStyle(fontSize: 16, fontWeight: FontWeight.w700),
        ),
        padding: MaterialStateProperty.all(
          const EdgeInsets.symmetric(
            horizontal: 15,
            vertical: 8,
          ),
        ),
      ),
      child: child,
    );
  }
}

class _ErrorMessageWidget extends StatelessWidget {
  const _ErrorMessageWidget();

  @override
  Widget build(BuildContext context) {
    final errorMessage =
        NotifierProvider.watch<AuthModel>(context)?.errorMessage;
    if (errorMessage == null) return const SizedBox.shrink();

    return Padding(
      padding: const EdgeInsets.only(bottom: 20),
      child: Text(
        errorMessage,
        style: const TextStyle(
          fontSize: 17,
          color: Colors.red,
        ),
      ),
    );
  }
}

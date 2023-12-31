import 'package:flutter/material.dart';
import 'package:flutterfire_ui/auth.dart';

class SignInPage extends StatelessWidget {
  const SignInPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SignInScreen(
      providerConfigs: const [
        EmailProviderConfiguration(),
        // GoogleProviderConfiguration(),
      ],
      headerBuilder: (context, constraints, shrinkOffset) {
        return const Padding(
          padding: EdgeInsets.all(20),
          child: Text("Geo Fish"),
        );
      },
      subtitleBuilder: (context, action) {
        return Padding(
          padding: const EdgeInsets.symmetric(vertical: 8.0),
          child: action == AuthAction.signIn
              ? const Text('Welcome to Geo Fish, please sign in!')
              : const Text('Welcome to Geo Fish, please sign up!'),
        );
      },
      footerBuilder: (context, action) {
        return const Padding(
          padding: EdgeInsets.only(top: 16),
          child: Text(
            'By signing in, you agree to our terms and conditions.',
            style: TextStyle(color: Colors.grey),
          ),
        );
      },
      sideBuilder: (context, shrinkOffset) {
        return Padding(
          padding: const EdgeInsets.all(20),
          child: AspectRatio(
            aspectRatio: 1,
            child: Image.asset('flutterfire_300x.png'),
          ),
        );
      },
    ));
  }
}

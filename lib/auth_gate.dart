import 'package:complete/model/counter_model.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutterfire_ui/auth.dart';
import 'package:provider/provider.dart';

import 'home.dart';
import 'model/user_model.dart';

const CLIENT_ID =
    '174830733343-3rqgqikb4u957johlg07ai5e0o3d80h7.apps.googleusercontent.com';

class AuthGate extends StatelessWidget {
  const AuthGate({super.key});

  @override
  Widget build(BuildContext context) {
    UserModel user = Provider.of<UserModel>(context);
    return StreamBuilder<User?>(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return SignInScreen(
              providerConfigs: const [
                EmailProviderConfiguration(),
                GoogleProviderConfiguration(
                  clientId: CLIENT_ID,
                )
              ],
              headerBuilder: (context, constraints, shrinkOffset) {
                return Padding(
                  padding: const EdgeInsets.all(20),
                  child: AspectRatio(
                    aspectRatio: 1,
                    child: Image.asset('flutterfire_300x.png'),
                  ),
                );
              },
              subtitleBuilder: (context, action) {
                return Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8.0),
                  child: action == AuthAction.signIn
                      ? const Text('Welcome to FlutterFire, please sign in!')
                      : const Text('Welcome to Flutterfire, please sign up!'),
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
              //TODO: To Continute with Side Builder
              //https://firebase.google.com/codelabs/firebase-auth-in-flutter-apps#4
              //5 Sign-In screen section of this codelab
              sideBuilder: (context, shrinkOffset) {
                return Padding(
                  padding: const EdgeInsets.all(20),
                  child: AspectRatio(
                    aspectRatio: 1,
                    child: Image.asset('flutterfire_300x.png'),
                  ),
                );
              },
            );
          }
          User? auth = snapshot.data;
          user.setUser(auth);

          print('AuthGate --------- increment counter ' +
              context.read<Counter>().count.toString());
          //context.read<Counter>().increment();

          print('AuthGate --------- increment counter ' +
              context.read<Counter>().count.toString());

          print('-------------------------------${auth!.displayName}');
          print('-------------------------------${auth.email}');

          return const HomeScreen();
        });
  }
}

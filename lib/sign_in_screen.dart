import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:http/http.dart' as http;
import 'package:firebase_auth/firebase_auth.dart';
import 'package:side_hustle_week_one/home_screen.dart';
import 'package:flutter_signin_button/flutter_signin_button.dart';

class SignInScreen extends StatefulWidget {
  const SignInScreen({Key? key}) : super(key: key);

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {

  GoogleSignInAccount? _currentUser;

  @override
  void initState() {
    googleSignIn.onCurrentUserChanged.listen((account) {
      setState(() {
        _currentUser == account;
      });
    });
    googleSignIn.signInSilently();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Login",
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            padding: const EdgeInsets.only(left: 10, right: 10),
            child: MaterialButton(
              color: Colors.white,
              elevation: 2,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Container(
                    alignment: Alignment.center,
                    height: 50.0,
                    width: 30.0,
                    decoration: const BoxDecoration(
                      image: DecorationImage(
                        image: AssetImage('images/google_icon.png'),
                      ),
                      shape: BoxShape.circle,
                    ),
                  ),
                  const SizedBox(
                    width: 20,
                  ),
                  const Text("Sign In with Google",
                    style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.bold
                    ),
                  )
                ],
              ),
              onPressed: () {
                signup(context);
              },
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          Container(
            padding: const EdgeInsets.only(left: 10, right: 10),
            child: MaterialButton(
              elevation: 2,
              color: Colors.blue,
              onPressed: () {
                signInWithFacebook();
              },
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  SignInButton(
                    Buttons.Facebook,
                    onPressed: () {
                      signInWithFacebook();
                    },
                  ),
               ]
              )
            ),
          ),
        ],
      ),
    );
  }

  void signInWithFacebook() async {
    try {
      final LoginResult result = await FacebookAuth.instance.login(
          permissions: (['email', 'public_profile']));
      final token = result.accessToken!.token;
      print(
          'Facebook token userID : ${result.accessToken!.grantedPermissions}');
      final graphResponse = await http.get(
          Uri.parse('https://graph.facebook.com/'
              'v2.12/me?fields=name,first_name,last_name,email&access_token=${token}'));

      final profile = jsonDecode(graphResponse.body);
      print("Profile is equal to $profile");
      try {
        final AuthCredential facebookCredential = FacebookAuthProvider
            .credential(result.accessToken!.token);
        final userCredential = await FirebaseAuth.instance.signInWithCredential(
            facebookCredential);
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const HomePage()),
        );
      } catch (e) {
        final snackBar = SnackBar(
          margin: const EdgeInsets.all(20),
          behavior: SnackBarBehavior.floating,
          content: Text(e.toString()),
          backgroundColor: (Colors.redAccent),
          action: SnackBarAction(
            label: 'dismiss',
            onPressed: () {},
          ),
        );
        ScaffoldMessenger.of(context).showSnackBar(snackBar);
      }
    } catch (e) {
      print("error occurred");
      print(e.toString());
    }
  }
}

  final GoogleSignIn googleSignIn = GoogleSignIn();


  Future<void> signup(BuildContext context) async {
    final FirebaseAuth auth = FirebaseAuth.instance;

    final GoogleSignInAccount? googleSignInAccount = await googleSignIn
        .signIn();
    if (googleSignInAccount != null) {
      final GoogleSignInAuthentication googleSignInAuthentication =
      await googleSignInAccount.authentication;
      final AuthCredential authCredential = GoogleAuthProvider.credential(
          idToken: googleSignInAuthentication.idToken,
          accessToken: googleSignInAuthentication.accessToken);

      // Getting users credential
      UserCredential result = await auth.signInWithCredential(authCredential);

      if (result != null) {
        Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (context) => const HomePage()));
      } // if result not null we simply call the MaterialpageRoute,
      // for go to the HomePage screen
    }
  }
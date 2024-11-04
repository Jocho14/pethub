import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:pethub/providers/auth/auth_provider.dart';
import 'package:pethub/styles/variables.dart';
import 'package:sign_in_button/sign_in_button.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Transform.translate(
                offset: Offset(0, -28),
                child: Image.asset(
                  'images/login_1.png',
                  height: 200,
                ),
              ),
            ),
            SizedBox(height: 20),
            Text("Login",
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
            SizedBox(height: 8),
            Text("Please sign in to continue.", style: TextStyle(fontSize: 16)),
            SizedBox(height: 40),
            Text("Email", style: TextStyle(fontSize: 16)),
            TextField(
              controller: _emailController,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                hintText: 'Enter your email',
              ),
              keyboardType: TextInputType.emailAddress,
            ),
            SizedBox(height: 16),
            Text("Password", style: TextStyle(fontSize: 16)),
            TextField(
              controller: _passwordController,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                hintText: 'Enter your password',
              ),
              obscureText: true,
            ),
            SizedBox(height: 24),
            Center(
              child: ElevatedButton(
                onPressed: () async {
                  String email = _emailController.text;
                  String password = _passwordController.text;
                  await Provider.of<AuthProvider>(context, listen: false)
                      .signInWithEmail(email, password);
                },
                child: Text(
                  'Login',
                  style: TextStyle(
                    color: AppColors.black,
                    fontSize: AppFonts.sizeLarge,
                  ),
                ),
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.accent,
                  padding: EdgeInsets.symmetric(horizontal: 50, vertical: 15),
                ),
              ),
            ),
            SizedBox(height: 32),
            Center(
              child: ClipRRect(
                borderRadius: BorderRadius.circular(30.0),
                child: SignInButton(
                  Buttons.google,
                  onPressed: () async {
                    await Provider.of<AuthProvider>(context, listen: false)
                        .signInWithGoogle();
                  },
                  text: "Sign in with Google",
                ),
              ),
            ),
            Spacer(),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text("Don't have an account? "),
                TextButton(
                  onPressed: () {},
                  child: Text(
                    "Sign Up",
                    style: TextStyle(
                      color: AppColors.accentDark,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

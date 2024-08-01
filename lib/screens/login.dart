import 'package:cms_customer/screens/register.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/login/login_bloc.dart';
import '../bloc/login/login_event.dart';
import '../bloc/login/login_state.dart';
import 'home_screen.dart';

class LoginScreen extends StatelessWidget {
  final TextEditingController mobileController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final double screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: const Color(0xFF22538D), // Corrected color format
      body: BlocProvider(
        create: (context) => LoginBloc(),
        child: Padding(
          padding: const EdgeInsets.only(top: 70),
          child: Column(
            children: [
              Align(
                alignment: Alignment.topLeft,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Text(
                    'Welcome Back !',
                    style: TextStyle(
                      fontSize: 30,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
              SizedBox(height: 20),
              Expanded(
                child: Align(
                  alignment: Alignment.bottomCenter,
                  child: Container(
                    width: double.infinity,
                    height: screenHeight * 0.80, // Adjust height based on screen height
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(40),
                        topRight: Radius.circular(40),
                      ),
                    ),
                    child: SingleChildScrollView(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          SizedBox(height: screenHeight * 0.10),
                          Text('Login', style: TextStyle(fontSize: 24,)),
                          SizedBox(
                            child: Column(
                              children: [
                                SizedBox(height: screenHeight * 0.10),
                                Padding(
                                  padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                                  child: TextField(
                                    controller: mobileController,
                                    decoration: InputDecoration(
                                      labelText: 'Mobile',
                                      border: OutlineInputBorder(),
                                      prefixIcon: Icon(Icons.phone_android,color: Color(0xFF22538D),),
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                                  child: TextField(
                                    controller: passwordController,
                                    decoration: InputDecoration(
                                      labelText: 'Password',
                                      border: OutlineInputBorder(),
                                      prefixIcon: Icon(Icons.phonelink_lock,color: Color(0xFF22538D),),
                                    ),
                                    obscureText: true,
                                  ),
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text('Forget my password?'),
                                    TextButton(
                                      onPressed: () {
                                        // Navigate to registration screen
                                      },
                                      child: Text('Click Here', style: TextStyle(color: Colors.blue)),
                                    ),
                                  ],
                                ),
                                 SizedBox(height: screenHeight * 0.10),
                                BlocConsumer<LoginBloc, LoginState>(
                                  listener: (context, state) {
                                    if (state is LoginFailure) {
                                      ScaffoldMessenger.of(context).showSnackBar(
                                        SnackBar(
                                          content: Text(state.error),
                                          backgroundColor: Colors.red,
                                        ),
                                      );
                                    } else if (state is LoginSuccess) {
                                      Navigator.of(context).pushReplacement(
                                        MaterialPageRoute(
                                          builder: (context) => HomeScreen(
                                             welcomeMessage: 'Welcome back to CMS, where your convenience is our commitment!',
                                          ),
                                        ),
                                      );
                                    }
                                  },
                                  builder: (context, state) {
                                    if (state is LoginLoading) {
                                      return CircularProgressIndicator();
                                    }

                                    return Column(
                                      children: [
                                        Padding(
                                          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                                          child: SizedBox(
                                            width: double.infinity,
                                            height: 50,
                                            child: MaterialButton(
                                              color: Color(0xFF22538D),
                                              onPressed: () {
                                                BlocProvider.of<LoginBloc>(context).add(
                                                  LoginButtonPressed(
                                                    mobile: mobileController.text,
                                                    password: passwordController.text,
                                                  ),
                                                );
                                              },
                                              child: Text('LOGIN', style: TextStyle(color: Colors.white, fontSize: 18)),
                                            ),
                                          ),
                                        ),

                                        Row(
                                          mainAxisAlignment: MainAxisAlignment.center,
                                          children: [
                                            Text('Don\'t have an account?'),
                                            TextButton(
                                              onPressed: () {
                                                Navigator.push(context, MaterialPageRoute(builder: (context) => RegisterScreen()));
                                              },
                                              child: Text('Register Here', style: TextStyle(color: Colors.blue)),
                                            ),
                                          ],
                                        ),
                                      ],
                                    );
                                  },
                                ),
                              ],
                            ),
                          ),

                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
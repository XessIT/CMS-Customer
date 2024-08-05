import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import '../bloc/register/register_event.dart';
import '../bloc/register/register_bloc.dart';
import '../bloc/register/register_state.dart';
import '../location.dart';
import 'home_screen.dart';

class RegisterScreen extends StatefulWidget {

  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final TextEditingController firstNameController = TextEditingController();

  final TextEditingController lastNameController = TextEditingController();

  final TextEditingController addressController = TextEditingController();

  final TextEditingController mobileController = TextEditingController();

  final TextEditingController otpController = TextEditingController();

  final TextEditingController passwordController = TextEditingController();

  final TextEditingController confirmPasswordController = TextEditingController();

  bool isLoading = false;

  bool _obscureText = true;

  bool isVerified = false;

  void _verifyOTP() {
    setState(() {
      isLoading = true;
      isVerified = false;
    });

    // Simulate OTP verification process
    Timer(const Duration(seconds: 2), () {
      setState(() {
        isLoading = false;
        isVerified = otpController.text == "123456"; // Replace this with your OTP verification logic
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    final double screenHeight = MediaQuery.of(context).size.height;
    // Future<void> _pickLocation() async {
    //   LatLng? location = await Navigator.push(
    //     context,
    //     MaterialPageRoute(builder: (context) => LocationPicker()),
    //   );
    //   if (location != null) {
    //     // Use a geocoding package to convert the location to an address
    //     // For simplicity, we're just setting the coordinates as the address
    //     addressController.text = '${location.latitude}, ${location.longitude}';
    //   }
    // }

    return Scaffold(
      backgroundColor: const Color(0xFF22538D), // Corrected color format
      body: BlocProvider(
        create: (context) => RegisterBloc(),
        child: Padding(
          padding: const EdgeInsets.only(top: 70),
          child: Column(
            children: [
            const Align(
                alignment: Alignment.topLeft,
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20),
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
              const SizedBox(height: 20),
              Expanded(
                child: Align(
                  alignment: Alignment.bottomCenter,
                  child: Container(
                    width: double.infinity,
                    height: screenHeight * 0.80, // Adjust height based on screen height
                    decoration: const BoxDecoration(
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
                          SizedBox(height: screenHeight * 0.05),
                          const Text('Sign Up', style: TextStyle(fontSize: 24,)),

                          SizedBox(
                            child: Column(
                              children: [
                                SizedBox(height: screenHeight * 0.05),
                                Padding(
                                  padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                                  child: TextField(
                                    controller: firstNameController,
                                    textCapitalization: TextCapitalization.words ,
                                    decoration: const InputDecoration(
                                      labelText: 'First Name',
                                      border: OutlineInputBorder(),
                                      prefixIcon: Icon(Icons.person,color: Color(0xFF22538D),),
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                                  child: TextField(
                                    controller: lastNameController,
                                    textCapitalization: TextCapitalization.words ,
                                    decoration: const InputDecoration(
                                      labelText: 'Last Name',
                                      border: OutlineInputBorder(),
                                      prefixIcon: Icon(Icons.person,color: Color(0xFF22538D),),
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                                  child: TextField(
                                    controller: addressController,
                                    maxLength: 200,
                                    //maxLines: 3,
                                    decoration: const InputDecoration(
                                      labelText: 'Address',
                                      border: OutlineInputBorder(),
                                      prefixIcon: Icon(Icons.location_on,color: Color(0xFF22538D),),
                                      // suffixIcon: IconButton(
                                      //   icon: Icon(Icons.map, color: Color(0xFF22538D)),
                                      //   onPressed: _pickLocation,
                                      // ),
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                                  child: TextField(
                                    controller: mobileController,
                                    inputFormatters: [
                                      LengthLimitingTextInputFormatter(10)
                                    ],
                                    keyboardType: TextInputType.phone,
                                    decoration: InputDecoration(
                                      labelText: 'Mobile Number',
                                      border: const OutlineInputBorder(),
                                      prefixText: '+91 ',
                                      prefixIcon: const Icon(Icons.phone_android,color: Color(0xFF22538D),),
                                      suffixIcon: mobileController.text.length == 10
                                          ? TextButton(
                                        child: const Text('Send OTP', style: TextStyle(color: Color(0xFF22538D))),
                                        onPressed: () {

                                        },
                                      ) : null,
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                                  child: TextField(
                                    controller: otpController,
                                    inputFormatters: [LengthLimitingTextInputFormatter(6)],
                                    keyboardType: TextInputType.phone,
                                    decoration: InputDecoration(
                                      labelText: 'OTP',
                                      border: const OutlineInputBorder(),
                                      prefixIcon: const Icon(
                                        Icons.password,
                                        color: Color(0xFF22538D),
                                      ),
                                      suffixIcon: otpController.text.length == 6
                                          ? isLoading
                                              ? Container(
                                                  padding: const EdgeInsets.all(10),
                                          child: const CircularProgressIndicator())
                                              : Icon(
                                            isVerified ? Icons.verified_user : Icons.cancel,
                                            color: isVerified ? Colors.green : Colors.red,
                                          )
                                          : null,
                                    ),
                                    onChanged: (value) {
                                      if (value.length == 6) {
                                        _verifyOTP();
                                      }
                                    },
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                                  child: TextField(
                                    controller: passwordController,
                                    inputFormatters: [
                                      FilteringTextInputFormatter.allow(RegExp(r'[a-zA-Z0-9]')),
                                      LengthLimitingTextInputFormatter(20)
                                    ],
                                    decoration: InputDecoration(
                                      labelText: 'Password',
                                      border: const OutlineInputBorder(),
                                      prefixIcon: const Icon(Icons.phonelink_lock,color: Color(0xFF22538D),),
                                      suffixIcon: IconButton(
                                        icon: const Icon(Icons.remove_red_eye, color: Color(0xFF22538D)),
                                        onPressed: () {
                                          setState(() {
                                            _obscureText = !_obscureText;
                                          });
                                        },
                                      )
                                    ),
                                    obscureText: true,
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                                  child: TextField(
                                    controller: confirmPasswordController,
                                    inputFormatters: [
                                      FilteringTextInputFormatter.allow(RegExp(r'[a-zA-Z0-9]')),
                                      LengthLimitingTextInputFormatter(20)
                                    ],
                                    decoration: InputDecoration(
                                        labelText: 'Confirm Password',
                                        border: const OutlineInputBorder(),
                                        prefixIcon: const Icon(Icons.phonelink_lock,color: Color(0xFF22538D),),
                                        suffixIcon: IconButton(
                                          icon: const Icon(Icons.remove_red_eye, color: Color(0xFF22538D)),
                                          onPressed: () {
                                            setState(() {
                                              _obscureText = !_obscureText;
                                            });
                                          },
                                        )
                                    ),
                                    obscureText: true,
                                  ),
                                ),
                                SizedBox(height: screenHeight * 0.05),
                                BlocConsumer<RegisterBloc, RegisterState>(
                                  listener: (context, state) {
                                    if (state is RegisterFailure) {
                                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(state.error)));
                                    } else if (state is RegisterSuccess) {
                                      // Navigate to home screen
                                      Navigator.of(context).pushReplacement(MaterialPageRoute(
                                        builder: (context) => HomeScreen(welcomeMessage: 'Welcome to CMS, where your convenience is our commitment!'),
                                      ));
                                    }
                                  },
                                  builder: (context, state) {
                                    if (state is RegisterLoading) {
                                      return const CircularProgressIndicator();
                                    }

                                    return Column(
                                      children: [
                                        const Padding(
                                          padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                                          child: Text(
                                            "15 days free trial",
                                            style: TextStyle(color: Colors.green, fontSize: 16),
                                          ),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                                          child: SizedBox(
                                            width: double.infinity,
                                            height: 50,
                                            child: MaterialButton(
                                              color: const Color(0xFF22538D),
                                              onPressed: () {
                                                BlocProvider.of<RegisterBloc>(context).add(
                                                  RegisterButtonPressed(
                                                    firstName: firstNameController.text,
                                                    lastName: lastNameController.text,
                                                    address: addressController.text,
                                                    mobile: mobileController.text,
                                                    otp: otpController.text,
                                                    password: passwordController.text,
                                                  ),
                                                );
                                              },
                                              child: const Text('REGISTER', style: TextStyle(color: Colors.white, fontSize: 18)),
                                            ),
                                          ),
                                        ),
                                      ],
                                    );
                                  },
                                )

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

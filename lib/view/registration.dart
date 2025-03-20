import 'package:airport_search_project/view/sorting_page/page/sort.dart';
import 'package:flutter/material.dart';

class RegistrationForm extends StatefulWidget {
  const RegistrationForm({super.key});

  @override
  State<RegistrationForm> createState() => _RegistrationFormState();
}

class _RegistrationFormState extends State<RegistrationForm> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _isPasswordVisible = false; // Track password visibility

  String? _validateName(String? value) {
    if (value == null || value.isEmpty) return 'Name is required';
    return null;
  }

 String? _validateEmail(String? value) {
  if (value == null || value.trim().isEmpty) {
    return 'Email is required';
  }

  final emailRegex = RegExp(
    r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$',
  );

  if (!emailRegex.hasMatch(value.trim())) {
    return 'Enter a valid email address';
  }

  return null;
}


  String? _validatePassword(String? value) {
    if (value == null || value.isEmpty) return 'Password is required';
    if (value.length < 6) return 'Password must be at least 6 characters';
    return null;
  }

  void _submitForm() {
    if (_formKey.currentState!.validate()) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Registration Successful!')),
      );

      _nameController.clear();
      _emailController.clear();
      _passwordController.clear();

      Future.delayed(const Duration(seconds: 2), () {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => AirportListPage()),
        );
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.white,
      ),
      body: Center(
        child: Container(
          width: screenWidth * 0.8,
          padding: EdgeInsets.all(screenWidth * 0.04),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(10),
            boxShadow: [
              BoxShadow(
                color: Colors.grey,
                spreadRadius: 2,
                blurRadius: 5,
                offset: const Offset(0, 3),
              ),
            ],
          ),
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                SizedBox(height: screenHeight * 0.02),
                Center(
                  child: Text(
                    "Registration",
                    style: TextStyle(
                      fontSize: screenWidth * 0.07,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                      letterSpacing: 1.5,
                    ),
                  ),
                ),
                SizedBox(height: screenHeight * 0.01),
                TextFormField(
                  controller: _nameController,
                  decoration: const InputDecoration(
                    labelText: 'Name',
                    hintText: 'Enter your name',
                    floatingLabelBehavior: FloatingLabelBehavior.never,
                  ),
                  validator: _validateName,
                ),
                SizedBox(height: screenHeight * 0.02),
                TextFormField(
                  controller: _emailController,
                  decoration: const InputDecoration(
                    labelText: 'Email',
                    hintText: 'Enter your email',
                    floatingLabelBehavior: FloatingLabelBehavior.never,
                  ),
                  validator: _validateEmail,
                ),
                SizedBox(height: screenHeight * 0.02),
                TextFormField(
                  controller: _passwordController,
                  decoration: InputDecoration(
                    labelText: 'Password',
                    hintText: 'Enter your password',
                    floatingLabelBehavior: FloatingLabelBehavior.never,
                    suffixIcon: IconButton(
                      icon: Icon(
                        _isPasswordVisible
                            ? Icons.visibility
                            : Icons.visibility_off,
                      ),
                      onPressed: () {
                        setState(() {
                          _isPasswordVisible = !_isPasswordVisible;
                        });
                      },
                    ),
                  ),
                  obscureText: !_isPasswordVisible,
                  validator: _validatePassword,
                ),
                SizedBox(height: screenHeight * 0.04),
                ElevatedButton(
                  onPressed: _submitForm,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color.fromARGB(255, 238, 241, 241),
                    padding: EdgeInsets.symmetric(
                        horizontal: screenWidth * 0.1,
                        vertical: screenHeight * 0.02),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    elevation: 5,
                    shadowColor: Colors.grey,
                  ),
                  child: Text(
                    'Register',
                    style: TextStyle(
                      fontSize: screenWidth * 0.05,
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 1.2,
                    ),
                  ),
                ),
                SizedBox(height: screenHeight * 0.04),
              ],
            ),
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }
}

// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:learning_app/controllers/controllers.dart';

class SignupPage extends StatefulWidget {
  @override
  _SignupPageState createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {
  final _formKey = GlobalKey<FormState>();
  final _firstNameController = TextEditingController();
  final _lastNameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();
  final _phoneController = TextEditingController();

  bool _isChecked = false;
  DateTime _selectedDate = DateTime.now();
  String _selectedSexe = 'Male';
  String _errorMessage = '';
  bool _isLoading = false;

  void _showDialogWithAnimation() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Row(
          children: [
            Text("Account Created Successfully"),
            // SizedBox(width: 10),
            Icon(
              Icons.check_circle_outline,
              color: Color(0xFF00846c),
              size: 30,
            ),
          ],
        ),
        actions: [
          Container(
            width: double.infinity,
            margin: EdgeInsets.symmetric(horizontal: 90),
            child: ElevatedButton(
              onPressed: () {
                Navigator.of(context).pushNamed('/login');
              },
              child: Text('Back to Login'),
            ),
          ),
        ],
      ),
    );
  }

  void _signup() async {
    if (_formKey.currentState!.validate()) {
      if (_isChecked) {
        setState(() {
          _isLoading = true;
        });
        setState(() {
          _errorMessage = '';
        });
        try {
          final data = await signupAPI({
            "firstName": _firstNameController.text,
            "lastName": _lastNameController.text,
            "email": _emailController.text,
            "password": _passwordController.text,
            "phone": _phoneController.text,
            "birthday": _selectedDate.toString(),
            "sexe": _selectedSexe == "Male" ? "H" : "F"
          });
          _showDialogWithAnimation();
          // Call your sign-up API here
          // ...
        } catch (e) {
          setState(() {
            _errorMessage = 'Failed to sign up. Please try again.';
          });
        } finally {
          setState(() {
            _isLoading = false;
          });
        }
      } else {
        setState(() {
          _errorMessage = 'Please accept the terms and conditions';
        });
      }
    }
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: _selectedDate,
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
    );
    if (picked != null && picked != _selectedDate) {
      setState(() {
        _selectedDate = picked;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(height: 23.0),
              Text(
                'Sign up',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 23.0),
              Row(
                children: [
                  Expanded(
                    child: TextFormField(
                      controller: _firstNameController,
                      decoration: InputDecoration(
                        labelText: 'First name',
                      ),
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Please enter your first name';
                        }
                        return null;
                      },
                    ),
                  ),
                  SizedBox(width: 16.0),
                  Expanded(
                    child: TextFormField(
                      controller: _lastNameController,
                      decoration: InputDecoration(
                        labelText: 'Last name',
                      ),
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Please enter your last name';
                        }
                        return null;
                      },
                    ),
                  ),
                ],
              ),
              SizedBox(height: 16.0),
              Row(
                children: [
                  Expanded(
                    child: GestureDetector(
                      onTap: () => _selectDate(context),
                      child: AbsorbPointer(
                        child: TextFormField(
                          decoration: InputDecoration(
                            labelText: 'Birthday',
                          ),
                          controller: TextEditingController(
                            text:
                                DateFormat('dd/MM/yyyy').format(_selectedDate),
                          ),
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'Please select your birthday';
                            }
                            return null;
                          },
                        ),
                      ),
                    ),
                  ),
                  SizedBox(width: 16.0),
                  Expanded(
                    child: TextFormField(
                      controller: _phoneController,
                      decoration: InputDecoration(
                        labelText: 'Phone',
                      ),
                      validator: (value) {
                        if (value!.isEmpty && double.tryParse(value) != null) {
                          return 'Please enter a valide phone';
                        }
                        return null;
                      },
                    ),
                  ),
                ],
              ),
              SizedBox(height: 16.0),
              DropdownButtonFormField<String>(
                value: _selectedSexe,
                decoration: InputDecoration(
                  labelText: 'Sexe',
                ),
                items: <String>['Male', 'Female']
                    .map<DropdownMenuItem<String>>((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                  );
                }).toList(),
                onChanged: (value) {
                  setState(() {
                    _selectedSexe = value!;
                  });
                },
              ),
              SizedBox(height: 16.0),
              TextFormField(
                controller: _emailController,
                keyboardType: TextInputType.emailAddress,
                decoration: InputDecoration(
                  labelText: 'Email',
                ),
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Please enter your email';
                  }
                  return null;
                },
              ),
              SizedBox(height: 16.0),
              TextFormField(
                controller: _passwordController,
                obscureText: true,
                decoration: InputDecoration(
                  labelText: 'Password',
                ),
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Please enter your password';
                  }
                  return null;
                },
              ),
              SizedBox(height: 16.0),
              TextFormField(
                controller: _confirmPasswordController,
                obscureText: true,
                decoration: InputDecoration(
                  labelText: 'Confirm password',
                ),
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Please confirm your password';
                  }
                  if (value != _passwordController.text) {
                    return 'Passwords do not match';
                  }
                  return null;
                },
              ),
              SizedBox(height: 10.0),
              CheckboxListTile(
                contentPadding: EdgeInsets.all(0),
                title: Text('I accept the terms and conditions'),
                value: _isChecked,
                controlAffinity: ListTileControlAffinity.leading,
                onChanged: (bool? value) {
                  setState(() {
                    _isChecked = value!;
                  });
                },
              ),
              _isLoading
                  ? CircularProgressIndicator()
                  : Container(
                      width: double.infinity,
                      margin: EdgeInsets.symmetric(horizontal: 16),
                      child: ElevatedButton(
                        onPressed: _signup,
                        child: Text('Sign up'),
                      ),
                    ),
              SizedBox(height: 5.0),
              Text(
                _errorMessage,
                style: TextStyle(
                  color: Colors.red,
                ),
              ),
              SizedBox(height: 10.0),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Already have an account? ',
                    style: TextStyle(
                      color: Colors.grey[600],
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      // Navigate to the sign-up page
                      Navigator.of(context).pushNamed('/login');
                      print("signup");
                    },
                    child: Text(
                      'Login',
                      style: TextStyle(
                        color: Colors.blue,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

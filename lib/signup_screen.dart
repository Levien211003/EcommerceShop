import 'package:flutter/material.dart';
import 'data/AuthServices.dart';
import 'signin_screen.dart';

class SignUpScreen extends StatefulWidget {
  @override
  _SignUpScreenState createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final _fullNameController = TextEditingController();
  final _phoneNumberController = TextEditingController();
  final _emailController = TextEditingController();
  final _usernameController = TextEditingController();
  final _passwordController = TextEditingController();
  final AuthService _authService = AuthService();
  bool _isLoading = false;

  // Error messages for validation
  String? _fullNameError;
  String? _phoneNumberError;
  String? _emailError;
  String? _usernameError;
  String? _passwordError;

  bool _hasInteractedFullName = false;
  bool _hasInteractedPhoneNumber = false;
  bool _hasInteractedEmail = false;
  bool _hasInteractedUsername = false;
  bool _hasInteractedPassword = false;

  Future<void> _handleSignUp() async {
    setState(() {
      _isLoading = true;
      _fullNameError = null;
      _phoneNumberError = null;
      _emailError = null;
      _usernameError = null;
      _passwordError = null;
    });

    String fullName = _fullNameController.text.trim();
    String phoneNumber = _phoneNumberController.text.trim();
    String email = _emailController.text.trim();
    String username = _usernameController.text.trim();
    String password = _passwordController.text.trim();

    bool isValid = true;

    // Full Name Validation
    if (fullName.isEmpty) {
      _fullNameError = 'Full Name is required.';
      isValid = false;
    }

    // Phone Number Validation
    if (phoneNumber.isEmpty) {
      _phoneNumberError = 'Phone Number is required.';
      isValid = false;
    } else if (!RegExp(r'^0\d{9}$').hasMatch(phoneNumber)) {
      _phoneNumberError = 'Phone Number must be 10 digits and start with 0.';
      isValid = false;
    }

    // Email Validation
    if (email.isEmpty) {
      _emailError = 'Email is required.';
      isValid = false;
    } else if (!RegExp(r'^[\w-]+@gmail\.com$').hasMatch(email)) {
      _emailError = 'Email must be a valid @gmail.com address.';
      isValid = false;
    }

    // Username Validation
    if (username.isEmpty) {
      _usernameError = 'Username is required.';
      isValid = false;
    }

    // Password Validation
    if (password.isEmpty) {
      _passwordError = 'Password is required.';
      isValid = false;
    } else if (!RegExp(r'^(?=.*[A-Z])(?=.*[@$!%*?&])[A-Za-z\d@$!%*?&]{6,}$').hasMatch(password)) {
      _passwordError = 'Password must contain an uppercase letter and a special character.';
      isValid = false;
    }

    setState(() {
      _isLoading = false;
    });

    if (!isValid) return;

    String result = await _authService.register(
      username: username,
      email: email,
      password: password,
      fullName: fullName,
      phoneNumber: phoneNumber,
    );

    if (result == 'Đăng ký thành công') {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => SignInScreen()),
      );
    } else {
      _showErrorDialog(result);
    }
  }

  void _showErrorDialog(String message) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Error'),
        content: Text(message),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: Text('OK'),
          ),
        ],
      ),
    );
  }

  Widget _buildTextField({
    required TextEditingController controller,
    required String label,
    required String? errorText,
    required bool hasInteracted,
    required Function(String) onChanged,
      bool obscureText = false, // Thêm tham số này

  }) {
    return TextField(
      controller: controller,
      onChanged: (value) {
        setState(() {
          onChanged(value);
        });
      },
          obscureText: obscureText, // Thêm thuộc tính này để ẩn ký tự

      decoration: InputDecoration(
        labelText: label,
        errorText: errorText,
        suffixIcon: Icon(
          errorText != null
              ? Icons.cancel
              : (controller.text.isNotEmpty
                  ? Icons.check_circle_outline
                  : Icons.circle_outlined),
          color: errorText != null
              ? Colors.red
              : (controller.text.isNotEmpty
                  ? Colors.green
                  : Colors.grey),
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
            
                SizedBox(height: 16.0),
                Text(
                  'Đăng Ký',
                  style: TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 32.0),
                _buildTextField(
                  controller: _fullNameController,
                  label: 'Full Name',
                  errorText: _fullNameError,
                  hasInteracted: _hasInteractedFullName,
                  onChanged: (value) {
                    _hasInteractedFullName = true;
                    if (value.isEmpty) {
                      _fullNameError = 'Full Name không được bỏ trống.';
                    } else {
                      _fullNameError = null;
                    }
                  },
                ),
                SizedBox(height: 16.0),
                _buildTextField(
                  controller: _phoneNumberController,
                  label: 'Số Điện Thoại',
                  errorText: _phoneNumberError,
                  hasInteracted: _hasInteractedPhoneNumber,
                  onChanged: (value) {
                    _hasInteractedPhoneNumber = true;
                    if (value.isEmpty) {
                      _phoneNumberError = 'Số Điện Thoại không được bỏ trống.';
                    } else if (!RegExp(r'^0\d{9}$').hasMatch(value)) {
                      _phoneNumberError =
                          'Số Điện Thoại không hợp lệ.';
                    } else {
                      _phoneNumberError = null;
                    }
                  },
                ),
                SizedBox(height: 16.0),
                _buildTextField(
                  controller: _emailController,
                  label: 'Email',
                  errorText: _emailError,
                  hasInteracted: _hasInteractedEmail,
                  onChanged: (value) {
                    _hasInteractedEmail = true;
                    if (value.isEmpty) {
                      _emailError = 'Email không được bỏ trống.';
                    } else if (!RegExp(r'^[\w-]+@gmail\.com$')
                        .hasMatch(value)) {
                      _emailError = 'Email phải có @gmail.com.';
                    } else {
                      _emailError = null;
                    }
                  },
                ),
                SizedBox(height: 16.0),
                _buildTextField(
                  controller: _usernameController,
                  label: 'Tài Khoản',
                  errorText: _usernameError,
                  hasInteracted: _hasInteractedUsername,
                  onChanged: (value) {
                    _hasInteractedUsername = true;
                    if (value.isEmpty) {
                      _usernameError = 'Tài Khoản không được bỏ trống.';
                    } else {
                      _usernameError = null;
                    }
                  },
                ),
                SizedBox(height: 16.0),
                _buildTextField(
                  controller: _passwordController,
                  label: 'Password',
                  errorText: _passwordError,
                  hasInteracted: _hasInteractedPassword,
                  onChanged: (value) {
                    _hasInteractedPassword = true;
                    if (value.isEmpty) {
                      _passwordError = 'Password không được bỏ trống.';
                    } else if (!RegExp(r'^(?=.*[A-Z])(?=.*[@$!%*?&])[A-Za-z\d@$!%*?&]{6,}$').hasMatch(value)) {
                      _passwordError = 'Mật Khẩu phải có từ in hoa và kí tự đặc biệt.';
                    } else {
                      _passwordError = null;
                    }
                  },
                    obscureText: true, // Đảm bảo ẩn ký tự

                ),
             
                SizedBox(height: 16.0),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => SignInScreen()),
                        );
                      },
                     child: Row(
  children: [
    Text(
      "Already have an account?",
      style: TextStyle(
        color: Colors.pink, 
      ),
    ),
    SizedBox(width: 4.0),
    Icon(
      Icons.arrow_forward,
      color: Colors.red,
    ),
  ],
),

                    ),
                  ],
                ),
                SizedBox(height: 32.0),
                SizedBox(
                  width: double.infinity,
                  height: 50.0,
                  child: ElevatedButton(
                    onPressed: _isLoading ? null : _handleSignUp,
                    child: _isLoading
                        ? CircularProgressIndicator(
                      color: Colors.white,
                    )
                        : Text('ĐĂNG KÝ'),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.red,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                  ),
                ),
                SizedBox(height:32.0),
                Center(
                  child: Column(
                    children: [
                      Text('Hoặc đăng nhập bằng tài khoản xã hội'),
                      SizedBox(height: 16.0),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          GestureDetector(
                            onTap: () {
                              // Xử lý đăng nhập bằng Google
                            },
                            child: Image.asset(
                              'assets/google.png',
                              width: 50,
                              height: 50,
                            ),
                          ),
                          SizedBox(width: 32.0),
                          GestureDetector(
                            onTap: () {
                              // Xử lý đăng nhập bằng Facebook
                            },
                            child: Image.asset(
                              'assets/facebook.png',
                              width: 50,
                              height: 50,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

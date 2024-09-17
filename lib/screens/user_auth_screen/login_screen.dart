import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:sihalal_ecommerce_app/screens/user_auth_screen/widgets/form_widgets.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: HexColor('fefffe'),
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        backgroundColor: HexColor('fefffe'),
      ),
      body: Column(
        children: [
          Text(
            'Masuk Sekarang',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: HexColor('#3f44a6'),
            ),
          ),
          const SizedBox(height: 5),
          Text(
            'Mohon masuk ke dalam akun anda',
            style: TextStyle(
              fontSize: 12,
              color: Colors.black.withOpacity(0.8),
              fontWeight: FontWeight.w500,
            ),
          ),
          const SizedBox(height: 30),
          const EmailLoginForm(),
          const SizedBox(height: 10),
          const PasswordLoginForm(),
          const SizedBox(height: 40),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 40),
            child: ElevatedButton(
              onPressed: () {},
              style: ElevatedButton.styleFrom(
                foregroundColor: Colors.white,
                backgroundColor: HexColor('#3f44a6'),
                elevation: 0, // Menghilangkan shadow
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                minimumSize: const Size(
                  double.infinity,
                  40,
                ),
              ),
              child: const Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: 24.0,
                  vertical: 12.0,
                ),
                child: Text('Masuk'),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

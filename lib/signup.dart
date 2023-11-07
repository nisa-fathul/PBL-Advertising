import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'dashboard.dart';
import 'login.dart';

void main() {
  runApp(const Signup());
}

class Signup extends StatelessWidget {
  const Signup({Key? key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: SignUpPage(),
    );
  }
}

class SignUpPage extends StatelessWidget {
  const SignUpPage({Key? key});

  @override
  Widget build(BuildContext context) {
    TextEditingController _fullNameController = TextEditingController();
    TextEditingController _emailController = TextEditingController();
    TextEditingController _passwordController = TextEditingController();

    void _signUp(String fullName, String email, String password) async {
      try {
        UserCredential userCredential =
            await FirebaseAuth.instance.createUserWithEmailAndPassword(
          email: email,
          password: password,
        );

        User user = userCredential.user!;

        // Simpan informasi tambahan ke Firestore
        await FirebaseFirestore.instance.collection('users').doc(user.uid).set({
          'email': email,
          'fullName': fullName,
        });

        // Navigasi ke halaman beranda setelah pendaftaran berhasil
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => DashboardPage(),
          ),
        );
      } catch (e) {
        print('Error signing up: $e');
        // Tangani error pendaftaran di sini
      }
    }

    return Scaffold(
      backgroundColor: const Color(0xFFDCE9FA),
      body: Center(
        child: Container(
          margin: const EdgeInsets.symmetric(horizontal: 32),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                "Create an Account",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontFamily: 'DM Sans',
                  fontSize: 30,
                  color: Color(0xff0D0140),
                ),
              ),
              const SizedBox(
                height: 11,
              ),
              const Text(
                "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor",
                style: TextStyle(
                  fontFamily: 'DM Sans',
                  fontSize: 12,
                  color: Color(0xff524B6B),
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(
                height: 64,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  const Text(
                    "Full Name",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontFamily: 'DM Sans',
                      fontSize: 12,
                      color: Color(0xff0D0140),
                    ),
                  ),
                  const SizedBox(height: 10),
                  Container(
                    width: double.infinity,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: Colors.white,
                    ),
                    child: TextField(
                      controller: _fullNameController,
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        hintText: "Nama Anda",
                        hintStyle: TextStyle(
                          fontFamily: 'DM Sans',
                          fontSize: 12,
                          color: const Color(0xffff0d0140).withOpacity(0.6),
                        ),
                        contentPadding: const EdgeInsets.symmetric(
                          horizontal: 16,
                          vertical: 17,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 15),
                  const Text(
                    "Email",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontFamily: 'DM Sans',
                      fontSize: 12,
                      color: Color(0xff0D0140),
                    ),
                  ),
                  const SizedBox(height: 10),
                  Container(
                    width: double.infinity,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: Colors.white,
                    ),
                    child: TextField(
                      controller: _emailController,
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        hintText: "Email Anda",
                        hintStyle: TextStyle(
                          fontFamily: 'DM Sans',
                          fontSize: 12,
                          color: const Color(0xffff0d0140).withOpacity(0.6),
                        ),
                        contentPadding: const EdgeInsets.symmetric(
                          horizontal: 16,
                          vertical: 17,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 15),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      const Text(
                        "Password",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontFamily: 'DM Sans',
                          fontSize: 12,
                          color: Color(0xff0D0140),
                        ),
                      ),
                      const SizedBox(height: 10),
                      Container(
                        width: double.infinity,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: Colors.white,
                        ),
                        child: TextField(
                          controller: _passwordController,
                          obscureText: true,
                          decoration: InputDecoration(
                            border: InputBorder.none,
                            hintText: "Password Anda",
                            hintStyle: TextStyle(
                              fontFamily: 'DM Sans',
                              fontSize: 12,
                              color: const Color(0xffff0d0140).withOpacity(0.6),
                            ),
                            contentPadding: const EdgeInsets.symmetric(
                              horizontal: 16,
                              vertical: 17,
                            ),
                          ),
                        ),
                      ),
                    ],
                  )
                ],
              ),
              const SizedBox(
                height: 20,
              ),
              Row(
                children: [
                  Row(
                    children: [
                      Checkbox(
                        value: false,
                        onChanged: (bool? value) {
                          // Tambahkan logika yang ingin Anda jalankan ketika checkbox berubah
                        },
                        activeColor: const Color(0xff130160),
                        checkColor: const Color(0xFF5972A5),
                      ),
                      const SizedBox(width: 5),
                      const Text(
                        "Remember me",
                        style: TextStyle(
                          fontFamily: 'DM Sans',
                          fontSize: 12,
                          color: Color(0xFF5972A5),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(width: 93),
                  const Text(
                    "Forgot Password ?",
                    style: TextStyle(
                      fontFamily: 'DM Sans',
                      fontSize: 12,
                      color: Color(0xff0D0140),
                    ),
                  )
                ],
              ),
              const SizedBox(
                height: 32,
              ),
              Container(
                width: double.infinity,
                height: 50,
                margin: const EdgeInsets.symmetric(horizontal: 20),
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xff130160),
                  ),
                  onPressed: () {
                    String fullName = _fullNameController.text;
                    String email = _emailController.text;
                    String password = _passwordController.text;
                    _signUp(fullName, email, password);
                  },
                  child: const Text(
                    "SIGN UP",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontFamily: 'DM Sans',
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
              Container(
                width: double.infinity,
                height: 50,
                margin:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 19),
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xffE6E1FF),
                  ),
                  onPressed: () {},
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.network(
                        "https://static-00.iconduck.com/assets.00/google-icon-2048x2048-czn3g8x8.png",
                        height: 20,
                      ),
                      const SizedBox(
                        width: 12,
                      ),
                      const Text(
                        "SIGN IN WITH GOOGLE",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontFamily: 'DM Sans',
                          color: Color(0xff0D0140),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    "You already have an account? ",
                    style: TextStyle(
                      fontFamily: 'DM Sans',
                      color: Color(0xff524B6B),
                      fontSize: 12,
                    ),
                  ),
                  InkWell(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const LoginPage(),
                        ),
                      );
                    },
                    child: const Text(
                      "Login",
                      style: TextStyle(
                        fontFamily: 'DM Sans',
                        color: Color(0xffFF9228),
                        fontSize: 12,
                      ),
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}

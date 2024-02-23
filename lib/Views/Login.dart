import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:miel/Views/Homepage.dart';

class LoginPage extends StatelessWidget {
  final String appVersion; // Añade esto

  LoginPage({Key? key, this.appVersion = "1.2.0"}) : super(key: key); // Asume una versión predeterminada

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(),
      body: _buildBody(context),
    );
  }

  AppBar _buildAppBar() {
    return AppBar(
      automaticallyImplyLeading: false,
      centerTitle: true,
      title: Text(
        'Bee Login',
        style: TextStyle(
          fontWeight: FontWeight.bold,
          color: Colors.black,
        ),
      ),
      backgroundColor: Color(0xFFFFF5EB),
    );
  }

   Widget _buildBody(BuildContext context) {
    return Container(
      color: Color(0xFFFFF5EB),
      child: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                _buildLoginForm(context),
                // Añade la versión aquí, al final del formulario de inicio de sesión
                Padding(
                  padding: const EdgeInsets.only(top: 20), 
                  child: Text(
                    'Versión $appVersion', 
                    // Muestra la versión
                    style: TextStyle(color: Colors.grey),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Column _buildLoginForm(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        _buildLogo(),
        SizedBox(height: 20),
        _buildTextField(context, 'Usuario', Icons.person),
        SizedBox(height: 20),
        _buildTextField(context, 'Contraseña', Icons.lock, isPassword: true),
        SizedBox(height: 20),
        _buildLoginButton(context),
      ],
    );
  }

  Container _buildLogo() {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        shape: BoxShape.circle,
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            spreadRadius: 2,
            blurRadius: 5,
            offset: Offset(0, 3),
          ),
        ],
      ),
      padding: EdgeInsets.all(20),
      child: SvgPicture.asset(
        'assets/Abejas.svg',
        height: 80,
        width: 80,
        color: Colors.black,
      ),
    );
  }

  Container _buildTextField(BuildContext context, String label, IconData icon, {bool isPassword = false}) {
    return Container(
      width: MediaQuery.of(context).size.width * 0.7,
      child: TextField(
        decoration: InputDecoration(
          labelText: label,
          prefixIcon: Icon(icon),
          fillColor: Colors.white,
          filled: true,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(20),
          ),
        ),
        obscureText: isPassword,
      ),
    );
  }

  ElevatedButton _buildLoginButton(BuildContext context) {
    return ElevatedButton(
      onPressed: () {
        Navigator.push(context, MaterialPageRoute(builder: (context) => Homepage()));
      },
      style: ElevatedButton.styleFrom(
        foregroundColor: Colors.white, backgroundColor: Colors.black,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        padding: EdgeInsets.symmetric(horizontal: 40, vertical: 15),
      ),
      child: Text('Iniciar Sesión'),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:miel/Views/Homepage.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:animate_do/animate_do.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool _rememberUser = false;
  bool _showPassword = false;

  @override
  void initState() {
    super.initState();
    _loadRememberedUser();
  }

  Future<void> _loadRememberedUser() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      _rememberUser = prefs.getBool('rememberUser') ?? false;
      if (_rememberUser) {
        _emailController.text = prefs.getString('userEmail') ?? '';
        _passwordController.text = prefs.getString('userPassword') ?? '';
      }
    });
  }

Future<void> _saveRememberedUser() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  if (_rememberUser) {
    prefs.setBool('rememberUser', true);
    prefs.setString('userEmail', _emailController.text);
    prefs.setString('userPassword', _passwordController.text);
  } else {
    prefs.remove('rememberUser');
    prefs.remove('userEmail');
    prefs.remove('userPassword');
  }
}


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFFFF5EB),
      body: Center(
        child: _buildBody(context),
      ),
    );
  }

  Widget _buildBody(BuildContext context) {
    return FadeIn(
      duration: Duration(milliseconds: 500),
      child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(height: 50),
            _buildLogo(),
            SizedBox(height: 40),
            _buildAnimatedTextField(context, 'Usuario', Icons.person, _emailController),
            SizedBox(height: 20),
            _buildAnimatedTextField(context, 'Contraseña', Icons.lock, _passwordController, isPassword: true),
            SizedBox(height: 20),
            _buildAnimatedLoginButton(context),
            SizedBox(height: 5),
            _buildAnimatedRememberUserCheckbox(),
          ],
        ),
      ),
    );
  }

  Widget _buildLogo() {
    return BounceInDown(
      child: Container(
        width: MediaQuery.of(context).size.width * 0.5,
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
      ),
    );
  }

  Widget _buildAnimatedTextField(BuildContext context, String label, IconData icon, TextEditingController controller, {bool isPassword = false}) {
    return SlideInLeft(
      child: Container(
        width: MediaQuery.of(context).size.width * 0.7,
        child: TextField(
          controller: controller,
          decoration: InputDecoration(
            labelText: label,
            prefixIcon: Icon(icon),
            suffixIcon: isPassword
                ? IconButton(
                    onPressed: () {
                      setState(() {
                        _showPassword = !_showPassword;
                      });
                    },
                    icon: Icon(_showPassword ? Icons.visibility_off : Icons.visibility),
                  )
                : null,
            fillColor: Colors.white,
            filled: true,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(20),
            ),
          ),
          obscureText: isPassword && !_showPassword,
        ),
      ),
    );
  }

  Widget _buildAnimatedLoginButton(BuildContext context) {
    return SlideInLeft(
      child: Container(
        width: MediaQuery.of(context).size.width * 0.7,
        child: ElevatedButton(
          onPressed: () {
            _signInWithEmailAndPassword(context);
          },
          style: ElevatedButton.styleFrom(
            foregroundColor: Colors.black,
            backgroundColor: Colors.white,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
            ),
            padding: EdgeInsets.symmetric(vertical: 15),
          ),
          child: Text(
            'Iniciar Sesión',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildAnimatedRememberUserCheckbox() {
    return SlideInLeft(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Checkbox(
            value: _rememberUser,
            onChanged: (value) {
              setState(() {
                _rememberUser = value ?? false;
              });
            },
          ),
          Text(
            'Recordar usuario',
            style: TextStyle(fontSize: 16),
          ),
        ],
      ),
    );
  }

  void _signInWithEmailAndPassword(BuildContext context) async {
    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: _emailController.text,
        password: _passwordController.text,
      );
      await _saveRememberedUser();
      Navigator.push(context, MaterialPageRoute(builder: (context) => Homepage()));
    } catch (e) {
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: Text('Error de inicio de sesión'),
          content: Text('Correo electrónico o contraseña incorrectos.'),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: Text('Cerrar'),
            ),
          ],
        ),
      );
    }
  }
}

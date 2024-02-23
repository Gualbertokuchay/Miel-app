import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:miel/Views/Widget/Miel.dart';
import 'package:miel/Views/Widget/carrito.dart';
import 'package:miel/Views/Widget/cera.dart';

class Homepage extends StatefulWidget {
  const Homepage({Key? key}) : super(key: key);

  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  int _selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text(
          _getAppBarTitle(),
          style: TextStyle(
            color: Colors.black,
            fontSize: 24.0,
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: Colors.white,
        elevation: 0,
        centerTitle: true,
      ),
      body: _getBody(_selectedIndex),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
        items: [
          BottomNavigationBarItem(
            icon: SvgPicture.asset(
              'assets/miel.svg',
              height: 30,
              width: 30,
              color: _selectedIndex == 0 ? Colors.black : Colors.grey,
            ),
            label: 'Miel',
          ),
          BottomNavigationBarItem(
            icon: SvgPicture.asset(
              'assets/AbejaCera.svg',
              height: 30,
              width: 30,
              color: _selectedIndex == 2 ? Colors.black : Colors.grey,
            ),
            label: 'Cera',
          ),
        ],
        backgroundColor: Colors.transparent,
        selectedItemColor: Colors.black,
        unselectedItemColor: Colors.grey,
        elevation: 0,
      ),
      floatingActionButton: _getFAB(),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

// redirecciones de iconos
  Widget _getBody(int index) {
    switch (index) {
      case 0:
        return MielPage();
      case 1:
        return CerapagaPage();
      default:
        return Container();
    }
  }

  Widget _getFAB() {
    return FloatingActionButton(
      onPressed: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => ShoppingCartPage()),
        );
      },
      child: SvgPicture.asset(
        'assets/carrito.svg',
        height: 36,
        width: 36,
        color: Colors.black,
      ),
      backgroundColor: Colors.white,
    );
  }

  String _getAppBarTitle() {
    if (_selectedIndex == 0) {
      return 'Miel App';
    } else if (_selectedIndex == 1) {
      return 'Cera App';
    } else {
      return 'Carrito de compras';
    }
  }
}

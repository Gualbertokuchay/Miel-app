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

  final List<Widget> _pages = [
    MielPage(),
    Cerapage()
  ];

  final List<BottomNavigationBarItem> _navItems = [
    BottomNavigationBarItem(
      icon: SvgPicture.asset('assets/miel.svg', height: 30, width: 30),
      label: 'Miel',
    ),
    BottomNavigationBarItem(
      icon: SvgPicture.asset('assets/AbejaCera.svg', height: 30, width: 30),
      label: 'Cera',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text(
          _getAppBarTitle(),
          style: const TextStyle(
            color: Colors.black,
            fontSize: 24.0,
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: Colors.white,
        elevation: 0,
        centerTitle: true,
      ),
      body: _pages.elementAt(_selectedIndex),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
        items: _navItems.map((item) => BottomNavigationBarItem(
          icon: item.icon,
          label: item.label,
        )).toList(),
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

  Widget _getFAB() => FloatingActionButton(
    onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (_) => ShoppingCartPage())),
    child: SvgPicture.asset('assets/carrito.svg', height: 36, width: 36, color: Colors.black),
    backgroundColor: Colors.white,
  );

  String _getAppBarTitle() => _selectedIndex == 0 ? 'Miel App' : 'Cera App';
}

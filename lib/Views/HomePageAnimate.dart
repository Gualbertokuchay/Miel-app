import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:animate_do/animate_do.dart';
import 'package:miel/main.dart';

class HomepageAnimate extends StatefulWidget {
  const HomepageAnimate({Key? key}) : super(key: key);

  @override
  State<HomepageAnimate> createState() => _HomepageAnimateState();
}

class _HomepageAnimateState extends State<HomepageAnimate> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFFFF5EB),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          SizedBox(height: 50),
          FadeIn(
            duration: Duration(milliseconds: 1500),
            child: SvgPicture.asset(
              'assets/abejaMovimiento.svg',
              width: 250,
              height: 250,
            ),
          ),
          FadeInUp(
            duration: Duration(milliseconds: 1000),
            delay: Duration(milliseconds: 500),
            child: Container(
              padding:
                  EdgeInsets.only(bottom: 20, left: 20, top: 20, right: 20),
              width: double.infinity,
              decoration: BoxDecoration(
                color:  Colors.white,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(30),
                  topRight: Radius.circular(30),
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Discover the sweetness \nof organic honey.",
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.w600,
                      color: Colors.black,
                    ),
                  ),
                  SizedBox(height: 15),
                  Text(
                    "Straight from the hive",
                    style: TextStyle(
                      fontSize: 15,
                      color: Colors.grey.shade600,
                    ),
                  ),
                  SizedBox(height: 20),
                  Align(
                    alignment: Alignment.bottomRight,
                    child: TextButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => LoginPage()),
                        );
                      },
                      child: Text(
                        "Explore now...",
                        style: TextStyle(color: Colors.black, fontSize: 16),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

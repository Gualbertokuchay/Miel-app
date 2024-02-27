import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:animate_do/animate_do.dart';
import 'package:miel/Views/Login.dart';

class HomepageAnimate extends StatefulWidget {
  final String appVersion;

  const HomepageAnimate({Key? key, required this.appVersion}) : super(key: key);

  @override
  State<HomepageAnimate> createState() => _HomepageAnimateState();
}

class _HomepageAnimateState extends State<HomepageAnimate> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFFFF5EB),
      body: SafeArea(
        child: Stack(
          children: <Widget>[
            Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: <Widget>[
                _buildBottomContent(context),
              ],
            ),
            Center(
              child: _buildAnimatedLogo(),
            ),
            _buildVersionText(),
          ],
        ),
      ),
    );
  }

  Widget _buildBottomContent(BuildContext context) {
    return FadeInUpBig(
      duration: Duration(milliseconds: 1000),
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 20, horizontal: 20),
        width: double.infinity,
        decoration: BoxDecoration(
          color: Color(0xFFFFF5EB),
          borderRadius: BorderRadius.vertical(top: Radius.circular(30)),
        ),
        child: _buildBottomSectionContent(context),
      ),
    );
  }

  Widget _buildBottomSectionContent(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        _buildTitleText(),
        SizedBox(height: 15),
        _buildSubtitleText(),
        SizedBox(height: 20),
        _buildExploreNowButton(context),
      ],
    );
  }

  Widget _buildAnimatedLogo() {
    return ElasticInDown(
      duration: Duration(milliseconds: 1500),
      child: SvgPicture.asset(
        'assets/abejaMovimiento.svg',
        width: 250,
        height: 250,
      ),
    );
  }

  Widget _buildTitleText() {
    return Text(
      "Discover the sweetness \nof organic honey.",
      style: TextStyle(fontSize: 24, fontWeight: FontWeight.w600, color: Colors.black),
    );
  }

  Widget _buildSubtitleText() {
    return Text(
      "Straight from the hive",
      style: TextStyle(fontSize: 15, color: Colors.grey.shade600),
    );
  }

  Widget _buildExploreNowButton(BuildContext context) {
    return Align(
      alignment: Alignment.bottomRight,
      child: TextButton(
        onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (context) => LoginPage())),
        child: Text("Explore now...", style: TextStyle(color: Colors.black, fontSize: 16)),
      ),
    );
  }

  Widget _buildVersionText() {
    return Positioned(
      left: 16,
      bottom: 16,
      child: FadeIn(
        duration: Duration(milliseconds: 2000),
        child: Text(
          'Versión ${widget.appVersion}', // Usa la propiedad appVersion aquí
          style: TextStyle(
            fontSize: 12,
            color: Colors.grey,
          ),
        ),
      ),
    );
  }
}

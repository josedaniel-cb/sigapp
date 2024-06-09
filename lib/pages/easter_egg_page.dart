import 'package:flutter/material.dart';

class EasterEggPage extends StatelessWidget{
  final double fontSize = 10;

  const EasterEggPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: _buildBody(),
      )
    );
  }

  Widget _buildBody(){
    return Container(
      color: Colors.white,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: <Widget>[
          Row(
            children: <Widget>[
              Expanded(
                child: Text(
                  '\teaster_egg',
                  // '\t🎁 easter_egg',
                  textAlign: TextAlign.left,
                  style: TextStyle(
                    fontSize: fontSize,
                    color: Colors.black38,              
                  ),
                ),
              ),
            ],
          ),
          Expanded(
            child: Center(
              child: Container(
                margin: const EdgeInsets.all(20),
                child: Image.asset('assets/images/custom_epii_logo.png'),
              ),
            ),
          ),
          Container(
            margin: const EdgeInsets.fromLTRB(10, 0, 10, 10),
            child: Text(
              'Logo E.P.I. Informática\nby josedaniel-cb\n(no oficial)',
              style: TextStyle(
                fontSize: fontSize,
                color: Colors.black38,              
              ),
              textAlign: TextAlign.right,
            ),
          )
        ],
      ),
    );
  }


}
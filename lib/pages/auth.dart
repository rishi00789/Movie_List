import 'package:flutter/material.dart';

import 'package:flutter_movie_app/pages/home_page.dart';

class auth extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Stack(
          children: <Widget>[
            Padding(
              padding:
                  const EdgeInsets.symmetric(vertical: 250, horizontal: 40),
              child: Container(
                width: 318,
                height: 400,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  boxShadow: [
                    BoxShadow(
                      color: Color(0xff000000),
                      blurRadius: 4,
                      offset: Offset(0, 4),
                    ),
                  ],
                  color: Color(0xff092E34),
                ),
              ),
            ),
            Padding(
              padding:
                  const EdgeInsets.symmetric(vertical: 280.0, horizontal: 66),
              child: RichText(
                  text: TextSpan(
                text: 'Welcome  to Movie List',
                style: TextStyle(
                    fontSize: 24.0,
                    fontWeight: FontWeight.w400,
                    color: Colors.white),
              )),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 390, left: 115),
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  primary: Colors.blueGrey, // background
                  onPrimary: Colors.white, // foreground
                ),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => CrudApp()),
                  );
                },
                child: Text('Get Started',
                    style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w400,
                        color: Colors.white)),
              ),
            ),
          ],
        ),
      ),
    );
  }
}


import 'package:flutter/material.dart';

class AppBarBackButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: const Icon(
        Icons.arrow_back,
        color: Colors.white,
        size: 25,
      ),
      onPressed: () => Navigator.of(context).pop(),
    );
  }
}

class AppBarBackButtonCross extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: Container(
        child: Icon(
          Icons.clear,
          color: Colors.white,
          size: 25,
        ),
      ),
      onPressed: () => Navigator.of(context).pop(),
    );
  }
}

class AppBarBackButtonPaymentPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: Container(
        child: Icon(
          Icons.arrow_back_sharp,
          color: Colors.white,
          size: 25,
        ),
      ),
      onPressed: () async {

        Navigator.of(context).pop();

        // Cancel Authorized Payment here.
      },
    );
  }
}

class AppBarBackButtonIOS extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: Container(
        child: Icon(Icons.arrow_back_ios, color: Colors.white),
      ),
      onPressed: () => Navigator.of(context).pop(),
    );
  }
}

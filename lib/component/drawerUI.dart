import 'package:flutter/material.dart';

class MainDrawer extends StatelessWidget {
  static const MainDrawer _drawer = MainDrawer._internal();

  factory MainDrawer() {
    return _drawer;
  }

  const MainDrawer._internal();

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: buildDrawer(context),
    );
  }

  Widget buildDrawer(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Expanded(
          child: ListView(
            shrinkWrap: true,
            children: <Widget>[
              Container(
                width: double.infinity,
                height: 150,
                alignment: Alignment.center,

              ),
              const SizedBox(height: 5),
              ListTile(
                  title: const Text(
                    'BOOKING HISTORY',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  leading: const Icon(
                    Icons.directions_car,
                    color: Colors.black,
                  ),
                  onTap: () {
                    Navigator.popAndPushNamed(context, '/login');
                  }),
              ListTile(
                  title: const Text(
                    'PROMO CODE',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  leading: const Icon(
                    Icons.pageview_rounded,
                    color: Colors.black,
                  ),
                  onTap: () {
                    Navigator.popAndPushNamed(context, '/promo_code');
                  }),
              ListTile(
                  title: const Text(
                    'LOG OUT',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  leading: const Icon(
                    Icons.all_out,
                    color: Colors.black,
                  ),
                  onTap: () async {
                    //islogin false
                    Navigator.of(context).pushNamedAndRemoveUntil(
                        '/', (Route<dynamic> route) => false);
                  }),
            ],
          ),
        ),

      ],
    );
  }



}

import 'package:flutter/material.dart';
import 'package:swe/controller/accountController.dart';
import 'package:swe/pages/historyPage.dart';
import 'package:swe/pages/settingsPage.dart';
import '../pages/homePage.dart';
import '../pages/debtPage.dart';
import '../pages/plannedPaymentPage.dart';
import '../pages/statPage.dart';

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
                    'Home',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  leading: const Icon(
                    Icons.home,
                    color: Colors.black,
                  ),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => HomePage()),
                    );                  }),
              ListTile(
                  title: const Text(
                    'HISTORY',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  leading: const Icon(
                    Icons.history,
                    color: Colors.black,
                  ),
                  // onTap: () {
                  //   Navigator.popAndPushNamed(context, '/login');
                  // }\
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => HistoryPage()),
                    );                  }
                ),
              ListTile(
                  title: const Text(
                    'Statistics',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  leading: const Icon(
                    Icons.bar_chart,
                    color: Colors.black,
                  ),
                  // onTap: () {
                  //   Navigator.popAndPushNamed(context, '/promo_code');
                  // }
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => StatisticsPage()),
                    );                  }
                  ),
              ListTile(
                  title: const Text(
                    'Debts',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  leading: const Icon(
                    Icons.money,
                    color: Colors.black,
                  ),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => DebtsPage()),
                    );                  }
                  ),
              ListTile(
                  title: const Text(
                    'Planned Payment',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  leading: const Icon(
                    Icons.access_time,
                    color: Colors.black,
                  ),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => PlannedPaymentPage()),
                    );                  }
              ),
              ListTile(
                  title: const Text(
                    'Settings',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  leading: const Icon(
                    Icons.settings,
                    color: Colors.black,
                  ),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => SettingsPage()),
                    );                  }
              ),

            ],
          ),
        ),




      ],
    );
  }





}

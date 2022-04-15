

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:settings_ui/settings_ui.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../Misc/colors.dart';
import '../component/buttons/appBarBackButton.dart';



class SettingsPage extends StatefulWidget {
  @override
  _SettingsPageState createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  bool isAllowPass;
  GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    refreshNotes();
  }

  Future refreshNotes() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    isAllowPass = sharedPreferences.getBool("isPass");

  }


  @override
  void dispose() {
    super.dispose();
  }

  void refreshUI() {
    if (mounted) {
      setState(() {
        _scaffoldKey = GlobalKey<ScaffoldState>();
      });
    }
  }
  int activeDay = 3;
  @override
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        leading: AppBarBackButton(),
        elevation: 1,
        centerTitle: true,
        title:  const Text(

          'Settings',
          style: TextStyle(color: Colors.white),
        ),
      ),
      backgroundColor: white.withOpacity(0.95),

      body: getBody(),


    );
  }

  Widget getBody() {
    return SettingsList(
      sections: [
        SettingsSection(
          title: Text('Common'),
          tiles: <SettingsTile>[
            SettingsTile.navigation(
              leading: Icon(Icons.language),
              title: Text('Language'),
              value: Text('English'),
            ),
            SettingsTile.switchTile(
              onToggle: (value) {
                isAllowPass = !value;

              },

              initialValue: isAllowPass,
              leading: Icon(Icons.format_paint),
              title: const Text('Enable Password'),
            ),
          ],
        ),
      ],
    );
  }




}

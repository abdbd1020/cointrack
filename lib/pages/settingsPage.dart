import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../Misc/colors.dart';
import '../component/buttons/appBarBackButton.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({Key key}) : super(key: key);

  @override
  _SettingsPageState createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  TextEditingController passwordController = TextEditingController();
  bool isAllowPass = false;
  bool isLoading;
  GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    passwordController.text = "";
    super.initState();
    refreshNotes();
  }

  Future refreshNotes() async {
    setState(() => isLoading = true);




    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    isAllowPass = sharedPreferences.getBool("isPass");
    setState(() => isLoading = false);
  }

  @override
  void dispose() {
    super.dispose();
  }

  Future<void> refreshUI() async {
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
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back,
            color: Colors.white,
            size: 25,
          ),
          onPressed: () {
            backPage();
          },
        ),
        elevation: 1,
        centerTitle: true,
        title: const Text(
          'Settings',
          style: TextStyle(color: Colors.white),
        ),
      ),
      backgroundColor: white.withOpacity(0.95),
      body: getBody(),
    );
  }

  Widget getBody() {
    return Column(
      children: [
        const SizedBox(height: 10,),
        Container(
          margin: EdgeInsets.all(10.0),
          width: double.infinity,
          height: 80.0,
          decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10.0),
              border: Border.all(color: Colors.black26)

          ),
          child: Row(
            children: [
              const SizedBox(width: 18,),
              const Text(
                "Add Password",
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                    color: Color(0xff67727d)),
              ),
              const Spacer(),
              Switch(
                value: isAllowPass,
                onChanged: (value) {
                  doChange(value);
                  setState(() {
                    isAllowPass = value;
                  });
                },
                activeTrackColor: Colors.lightGreenAccent,
                activeColor: Colors.green,
              ),

              const SizedBox(width: 20,),
            ],
          ),
        ),
        Container(
          height: 80,
          margin: EdgeInsets.all(10.0),
          width: double.infinity,
          decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10.0),
              border: Border.all(color: Colors.black26)

          ),
          child: Column(
            children: [
              Container(
                padding: EdgeInsets.fromLTRB(18, 10, 0, 0),
                alignment: Alignment.centerLeft,


                child: const Text(
                  "Password",
                  style: TextStyle(
                      fontWeight: FontWeight.w500,
                      fontSize: 16,
                      color: Colors.black),
                ),
              ),
              TextField(
                controller: passwordController,
                enabled: isAllowPass?true:false,
                obscureText: true,
                enableSuggestions: false,
                autocorrect: false,
                cursorColor: black,
                style: const TextStyle(
                    fontSize: 17,

                    color: black),
                decoration: const InputDecoration(
                  contentPadding: EdgeInsets.fromLTRB(18, 0, 0, 0),
                    hintText: "Enter Password",
                  border: InputBorder.none,
                  focusedBorder: InputBorder.none,
                  enabledBorder: InputBorder.none,
                  errorBorder: InputBorder.none,
                  disabledBorder: InputBorder.none,),
              ),
            ],
          ),
        ),

        const SizedBox(
          height: 10,
        ),
      ],
    );
  }

  Future<void> doChange(bool value) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('isPass', value);
  }

  Future<void> backPage() async {
    print(passwordController.text);
    if(isAllowPass){
      if(passwordController.text==""){
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text("Please set a password"),
          duration: Duration(milliseconds: 500),
        ));
        return;
      }
      else if(passwordController.text.length<5){
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text("Password is too short"),
          duration: Duration(milliseconds: 500),
        ));
        return;
      }
      else{
        final prefs = await SharedPreferences.getInstance();
        await prefs.setString('Password', passwordController.text);
      }

    }




    Navigator.of(context).pop();
  }
}

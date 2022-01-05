import 'package:buttons_tabbar/buttons_tabbar.dart';
import 'package:cupertione_flutter/scrren/register_page/sing_in_page.dart';
import 'package:cupertione_flutter/scrren/register_page/sing_up_page.dart';
import 'package:cupertione_flutter/scrren/register_page/sing_up_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({Key? key}) : super(key: key);

  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  Object groupValu = 0;
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Container(
            height: size.height,
            width: size.width,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _backButton(context),
                _switchToPage(),
                if (groupValu == 0) ...[
                  const SingUpPage()
                ] else ...[
                  const SingInPage()
                ]
              ],
            ),
          ),
        ),
      ),
    );
  }

  CupertinoPageScaffold _switchToPage() {
    return CupertinoPageScaffold(
      child: Container(
        alignment: Alignment.center,
        child: CupertinoSlidingSegmentedControl(
            groupValue: groupValu,
            children: {
              0: buildSegment('Sing Up'),
              1: buildSegment('Sing In'),
            },
            onValueChanged: (groupValue) {
              setState(() {
                groupValu = groupValue!;
              });
            }),
      ),
    );
  }

  IconButton _backButton(BuildContext context) {
    return IconButton(
      onPressed: () {
        Navigator.pop(context);
      },
      icon: const Icon(Icons.arrow_back_ios),
    );
  }

  Widget buildSegment(String text) {
    return Container(
      alignment: Alignment.center,
      width: 120,
      height: 40,
      child: Text(
        text,
        style: TextStyle(fontSize: 20),
      ),
    );
  }
}

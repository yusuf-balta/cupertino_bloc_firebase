import 'package:cupertione_flutter/scrren/register_page/register_page.dart';
import 'package:cupertione_flutter/utils/buttons.dart';
import 'package:cupertione_flutter/utils/router.dart';
import 'package:flutter/material.dart';

class LandingPage extends StatelessWidget {
  const LandingPage({Key? key}) : super(key: key);
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return SafeArea(
      child: Scaffold(
        body: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            _logo(size),
            const SizedBox(
              height: 10,
            ),
            _decs(),
            const SizedBox(
              height: 10,
            ),
            _socialAccounts(),
            Buttons.elevatedButton(
                size: size,
                onPressed: () {
                  Routter.push(RegisterPage(), context);
                },
                text: 'Continue')
          ],
        ),
      ),
    );
  }

  Row _socialAccounts() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        Image.asset('assets/facebook.jpg'),
        Image.asset('assets/instagram.png'),
        Image.asset('assets/linkedin.png'),
        Image.asset('assets/twitter.png'),
      ],
    );
  }

  Padding _decs() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Center(
        child: Image.asset('assets/desc.png'),
      ),
    );
  }

  Center _logo(Size size) {
    return Center(
      child: ClipRRect(
        borderRadius: BorderRadius.circular(size.width * 0.25),
        child: Image.asset(
          'assets/logo.jpg',
          height: size.width * 0.5,
          width: size.width * 0.5,
        ),
      ),
    );
  }
}

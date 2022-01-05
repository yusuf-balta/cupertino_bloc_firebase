import 'package:cupertione_flutter/scrren/home_page/home_page.dart/home_page.dart';
import 'package:cupertione_flutter/scrren/login_page/login_page_service/login_page_service.dart';
import 'package:cupertione_flutter/utils/buttons.dart';
import 'package:cupertione_flutter/utils/router.dart';
import 'package:flutter/material.dart';

class SingInPage extends StatefulWidget {
  const SingInPage({Key? key}) : super(key: key);

  @override
  State<SingInPage> createState() => _SingInPageState();
}

class _SingInPageState extends State<SingInPage> {
  LoginPageService loginPageService = LoginPageService();
  GlobalKey<FormState> _signUpFormKey = GlobalKey<FormState>();
  late TextEditingController? txtEmailAdressSingInController;
  late TextEditingController? txtPasswordSingInController;

  late String? _mailAdress;
  late String? _password;
  bool isVisibilityPassword = false;

  @override
  void initState() {
    super.initState();
    txtEmailAdressSingInController = TextEditingController();
    txtPasswordSingInController = TextEditingController();
    _mailAdress = "";
    _password = "";
  }

  @override
  void dispose() {
    txtEmailAdressSingInController!.dispose();
    txtPasswordSingInController!.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Form(
      key: _signUpFormKey,
      child: Column(
        children: [
          _txtFormField('Email', txtEmailAdressSingInController!, _mailAdress!),
          _txtFormField(
              'Create Password', txtPasswordSingInController!, _password!),
          _forgotPassword(),
          SizedBox(
            height: size.height * 0.3,
          ),
          Buttons.elevatedButton(
              isOpact: !validate([
                txtPasswordSingInController!,
                txtEmailAdressSingInController!
              ]),
              onPressed: validate([
                txtPasswordSingInController!,
                txtEmailAdressSingInController!
              ])
                  ? () async {
                      if (_signUpFormKey.currentState!.validate()) {
                        await loginPageService.loginUser(
                            email: txtEmailAdressSingInController!.text.trim(),
                            password: txtPasswordSingInController!.text.trim());
                        Navigator.pop(context);
                        Routter.pushReplacement(HomePage(), context);
                      }
                    }
                  : null,
              text: 'Continue',
              size: size)
        ],
      ),
    );
  }

  bool validate(List<TextEditingController> controls) {
    bool result = true;
    controls.forEach((element) {
      if (element.text == "") {
        result = false;
      }
    });
    return result;
  }

  GestureDetector _forgotPassword() {
    return GestureDetector(
      onTap: () {},
      child: Text(
        'Forgot password?',
        style: TextStyle(
            color: Colors.grey[600], decoration: TextDecoration.underline),
      ),
    );
  }

  Widget _txtFormField(
    String labelText,
    TextEditingController controller,
    String value,
  ) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 8.0),
            child: Text(
              labelText,
              style: TextStyle(fontWeight: FontWeight.w400),
            ),
          ),
          SizedBox(
            height: 10,
          ),
          TextFormField(
            controller: controller,
            decoration: InputDecoration(
              border:
                  OutlineInputBorder(borderRadius: BorderRadius.circular(18)),
            ),
            validator: (value) {
              if (value!.isEmpty) {
                return 'boş olamaz';
              } else {
                return null;
              }
            },
            onSaved: (valu) => setState(() {
              value = valu!;
            }),
            onChanged: (valu) => setState(() {
              value = valu;
            }),
          )
        ],
      ),
    );
  }
}

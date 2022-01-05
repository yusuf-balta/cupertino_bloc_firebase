import 'package:cupertione_flutter/scrren/login_page/login_page.dart';
import 'package:cupertione_flutter/utils/buttons.dart';
import 'package:cupertione_flutter/utils/router.dart';
import 'package:flutter/material.dart';

class SingUpPage extends StatefulWidget {
  const SingUpPage({Key? key}) : super(key: key);

  @override
  State<SingUpPage> createState() => _SingUpPageState();
}

class _SingUpPageState extends State<SingUpPage> {
  GlobalKey<FormState> _signUpFormKey = GlobalKey<FormState>();
  late TextEditingController? txtEmailAdressSingUpController;
  late TextEditingController? txtPasswordSingUpController;
  late TextEditingController? reTxtPasswordSingUpController;

  late String? _mailAdress;
  late String? _password;
  late String? _rePassword;
  bool isVisibilityPassword = false;

  @override
  void initState() {
    super.initState();
    txtEmailAdressSingUpController = TextEditingController();
    txtPasswordSingUpController = TextEditingController();
    reTxtPasswordSingUpController = TextEditingController();
    _mailAdress = "";
    _password = "";
    _rePassword = '';
  }

  @override
  void dispose() {
    txtEmailAdressSingUpController!.dispose();
    txtPasswordSingUpController!.dispose();
    reTxtPasswordSingUpController!.dispose();
    super.dispose();
  }

  final termsOfUse = Text(
    'terms of use',
    style: TextStyle(color: Colors.red),
  );
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Form(
      key: _signUpFormKey,
      child: Column(
        children: [
          _txtFormField(
              'Email', txtEmailAdressSingUpController!, _mailAdress!, false),
          _txtFormField('Create Password', txtPasswordSingUpController!,
              _password!, true),
          _txtFormField('Re-Write Password', reTxtPasswordSingUpController!,
              _rePassword!, true),
          _txtLorem(),
          SizedBox(
            height: size.height * 0.07,
          ),
          Buttons.elevatedButton(
              isOpact: !validate([
                txtPasswordSingUpController!,
                reTxtPasswordSingUpController!,
                txtEmailAdressSingUpController!
              ]),
              onPressed: validate([
                txtPasswordSingUpController!,
                reTxtPasswordSingUpController!,
                txtEmailAdressSingUpController!
              ])
                  ? () {
                      if (_signUpFormKey.currentState!.validate()) {
                        Routter.push(
                            LoginPage(
                                mail:
                                    txtEmailAdressSingUpController!.text.trim(),
                                password:
                                    txtPasswordSingUpController!.text.trim()),
                            context);
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

  Padding _txtLorem() {
    return Padding(
      padding: const EdgeInsets.only(top: 50, left: 50.0, right: 50),
      child: Text(
          'Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry'),
    );
  }

  Widget _txtFormField(
    String labelText,
    TextEditingController controller,
    String value,
    bool isPassword,
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
            obscureText: isPassword ? !isVisibilityPassword : false,
            controller: controller,
            decoration: InputDecoration(
              suffixIcon: isPassword
                  ? IconButton(
                      onPressed: () {
                        setState(() {
                          isVisibilityPassword = !isVisibilityPassword;
                        });
                      },
                      icon: Icon(
                        isVisibilityPassword
                            ? Icons.visibility
                            : Icons.visibility_off,
                        color: isVisibilityPassword
                            ? Theme.of(context).primaryColor
                            : Colors.grey,
                      ),
                    )
                  : null,
              border:
                  OutlineInputBorder(borderRadius: BorderRadius.circular(18)),
            ),
            validator: (value) {
              if (isPassword) {
                if (value!.length < 6) {
                  return '6 karakterden büyük olmalı';
                } else if (txtPasswordSingUpController!.text !=
                    reTxtPasswordSingUpController!.text) {
                  return ' Şifreler uyuşmalı';
                } else {
                  return null;
                }
              } else {
                if (value!.isEmpty) {
                  return 'boş olamaz';
                } else {
                  return null;
                }
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

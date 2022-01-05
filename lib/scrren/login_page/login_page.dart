import 'package:cupertione_flutter/model/person_model.dart';
import 'package:cupertione_flutter/scrren/home_page/home_page.dart/home_page.dart';
import 'package:cupertione_flutter/scrren/login_page/login_page_bloc/login_page_bloc.dart';
import 'package:cupertione_flutter/scrren/login_page/login_page_bloc/login_page_state.dart';
import 'package:cupertione_flutter/utils/buttons.dart';
import 'package:cupertione_flutter/utils/dialogs.dart';
import 'package:cupertione_flutter/utils/router.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import 'login_page_bloc/login_page_event.dart';

class LoginPage extends StatefulWidget {
  LoginPage({Key? key, required this.mail, required this.password})
      : super(key: key);
  String mail;
  String password;
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final List<String> ages = [
    '1',
    '2',
    '3',
    '4',
    '5',
    '6',
    '7',
    '8',
    '9',
    '10',
    '11',
    '12',
    '13',
    '14',
    '15',
    '16',
    '17',
    '18',
    '19'
  ];
  final List<String> lengths = [
    '155',
    '160',
    '165',
    '170',
    '175',
    '180',
    '190',
    '195',
    '200',
  ];
  final List<String> weights = [
    '70',
    '75',
    '80',
    '85',
    '90',
    '95',
    '100',
    '105',
    '110',
    '120',
    '180',
    '190',
    '195',
    '200',
  ];
  late final LoginPageBloc loginPageBloc;
  GlobalKey<FormState> _txtNameFormKey = GlobalKey<FormState>();
  late TextEditingController? txtNameController;
  bool isDialogActive = false;
  bool isMale = false;
  bool isFemale = false;
  late final PersonModel personModel;
  late final PageController _controller;
  @override
  void initState() {
    super.initState();
    personModel = PersonModel();
    personModel.mail = widget.mail;
    personModel.password = widget.password;
    txtNameController = TextEditingController();
    loginPageBloc = LoginPageBloc();

    _controller = PageController();
  }

  @override
  void dispose() {
    loginPageBloc.close();
    txtNameController!.dispose();
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return BlocListener(
      listener: (context, state) {
        if (state is LoadingLoginState) {
          isDialogActive = true;
          showDialog(
              context: context,
              builder: (context) => Dialogs.loadingDialog(size));
        } else if (state is CreateSuccsesLoginPageState) {
          if (isDialogActive) {
            Navigator.pop(context);
            showDialog(
                context: context,
                builder: (context) => Dialogs.sucssesDialog(
                    content: Text('Kayıt Gerçekleşti'),
                    context: context,
                    onPressed: () {
                      Navigator.pop(context);
                      Navigator.pop(context);
                      Navigator.pop(context);
                      Routter.pushReplacement(HomePage(), context);
                    }));
          }
        }
      },
      bloc: loginPageBloc,
      child: SafeArea(
        child: Scaffold(
          body: SingleChildScrollView(
            child: Column(
              children: [
                SizedBox(
                  height: size.height * 0.9,
                  child: PageView(
                    controller: _controller,
                    children: [
                      _body2(context, size),
                      _body1(context, size),
                      _body3(context, size),
                      _body4(context, size),
                      _body5(context, size)
                    ],
                  ),
                ),
                SmoothPageIndicator(
                  controller: _controller,
                  count: 5,
                  effect: WormEffect(
                    dotColor: Colors.grey[300]!,
                    activeDotColor: Colors.grey[600]!,
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget txtUserName() {
    return Padding(
      padding: const EdgeInsets.all(12.0),
      child: TextFormField(
        controller: txtNameController,
        decoration: InputDecoration(
          hintText: 'Your name',
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
        ),
        validator: (value) {
          if (value!.isEmpty) {
            return 'boş olamaz';
          } else {
            return null;
          }
        },
        onSaved: (value) => setState(() {
          personModel.name = value;
        }),
        onChanged: (value) => setState(() {
          personModel.name = value;
        }),
      ),
    );
  }

  _body5(BuildContext context, Size size) {
    return _body(
        context: context,
        size: size,
        body: Center(
          child: SizedBox(
            height: size.height * 0.5,
            child: CupertinoPicker(
              itemExtent: 64,
              children: weights
                  .map((e) => Center(
                        child: Text(
                          '$e kg',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                      ))
                  .toList(),
              onSelectedItemChanged: (index) {
                personModel.weight = weights[index];
              },
            ),
          ),
        ),
        text: 'How much is your weight?',
        onPressed: () {
          if (personModel.weight != null) {
            loginPageBloc
                .add(CreateUserLoginPageEvent(personModel: personModel));
          }
        });
  }

  Column _body4(BuildContext context, Size size) {
    return _body(
        context: context,
        size: size,
        body: Center(
          child: SizedBox(
            height: size.height * 0.5,
            child: CupertinoPicker(
              itemExtent: 64,
              children: lengths
                  .map((e) => Center(
                        child: Text(
                          '$e cm',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                      ))
                  .toList(),
              onSelectedItemChanged: (index) {
                personModel.length = lengths[index];
              },
            ),
          ),
        ),
        text: 'How much is your length?',
        onPressed: () {
          if (personModel.length != null) {
            _controller.nextPage(
                duration: Duration(milliseconds: 400), curve: Curves.linear);
          }
        });
  }

  Column _body3(BuildContext context, Size size) {
    return _body(
        context: context,
        size: size,
        body: Center(
          child: SizedBox(
            height: size.height * 0.5,
            child: CupertinoPicker(
              itemExtent: 64,
              children: ages
                  .map((e) => Center(
                        child: Text(
                          e,
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                      ))
                  .toList(),
              onSelectedItemChanged: (index) {
                personModel.age = ages[index];
              },
            ),
          ),
        ),
        text: 'How old are you ?',
        onPressed: () {
          if (personModel.age != null) {
            _controller.nextPage(
                duration: Duration(milliseconds: 400), curve: Curves.linear);
          }
        });
  }

  Column _body1(BuildContext context, Size size) {
    return _body(
        context: context,
        size: size,
        body: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Container(
              decoration: BoxDecoration(boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.5),
                  blurRadius: 10,
                ),
              ], borderRadius: BorderRadius.circular(20), color: Colors.white),
              height: 100,
              width: 100,
              child: IconButton(
                  onPressed: () {
                    setState(() {
                      isMale = true;
                      isFemale = false;
                    });
                  },
                  icon: Icon(
                    Icons.male,
                    size: 80,
                    color: isMale ? Colors.blueGrey[700] : Colors.grey,
                  )),
            ),
            Container(
              decoration: BoxDecoration(boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.5),
                  blurRadius: 10,
                ),
              ], borderRadius: BorderRadius.circular(20), color: Colors.white),
              height: 100,
              width: 100,
              child: IconButton(
                  onPressed: () {
                    setState(() {
                      isMale = false;
                      isFemale = true;
                    });
                  },
                  icon: Icon(
                    Icons.female,
                    size: 80,
                    color: isFemale ? Colors.red : Colors.grey,
                  )),
            )
          ],
        ),
        text: 'What is your sex?',
        onPressed: () {
          if (isFemale == true && isMale == false) {
            personModel.sex = 'Female';
          } else if (isFemale == false && isMale == true) {
            personModel.sex = 'Male';
          } else {}
          if (personModel.sex != null) {
            _controller.nextPage(
                duration: Duration(milliseconds: 400), curve: Curves.linear);
          }
        });
  }

  Column _body2(BuildContext context, Size size) {
    return _body(
      context: context,
      size: size,
      body: Form(key: _txtNameFormKey, child: txtUserName()),
      text: 'Your Name',
      onPressed: () {
        if (_txtNameFormKey.currentState!.validate()) {
          _controller.nextPage(
              duration: Duration(milliseconds: 400), curve: Curves.linear);
        }
      },
    );
  }

  Column _body(
      {required BuildContext context,
      required Size size,
      required Widget body,
      required String text,
      required Function() onPressed}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        IconButton(
            onPressed: () {
              _controller.previousPage(
                  duration: Duration(milliseconds: 400), curve: Curves.easeIn);
            },
            icon: Icon(Icons.arrow_back_ios)),
        Spacer(
          flex: 2,
        ),
        Center(
          child: Text(
            text,
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
        ),
        SizedBox(
          height: size.height * 0.1,
        ),
        Spacer(
          flex: 2,
        ),
        body,
        Spacer(
          flex: 2,
        ),
        Center(
          child: Buttons.elevatedButton(
              size: size, onPressed: onPressed, text: 'Next'),
        ),
        Spacer(
          flex: 1,
        ),
      ],
    );
  }
}

import 'package:cupertione_flutter/model/person_model.dart';
import 'package:cupertione_flutter/scrren/home_page/home_page_bloc/home_page_bloc.dart';
import 'package:cupertione_flutter/scrren/home_page/home_page_bloc/home_page_event.dart';
import 'package:cupertione_flutter/scrren/home_page/home_page_bloc/home_page_state.dart';
import 'package:cupertione_flutter/scrren/landing_page/landing_page.dart';
import 'package:cupertione_flutter/utils/router.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  bool isLoading = true;
  late final HomePageBloc homePageBloc;
  late final PersonModel personModel;
  @override
  void initState() {
    super.initState();
    homePageBloc = HomePageBloc();
    homePageBloc.add(InitialHomePageEvent());
  }

  @override
  void dispose() {
    homePageBloc.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener(
      listener: (context, state) {
        if (state is LogoutUserSuccses) {
          Routter.pushReplacement(LandingPage(), context);
        } else if (state is SuccsesHomePageState) {
          setState(() {
            personModel = state.personModel;
            isLoading = false;
          });
        }
      },
      bloc: homePageBloc,
      child: Scaffold(
        appBar: AppBar(
          actions: [
            IconButton(
                onPressed: () {
                  homePageBloc.add(LogOutHomePageEvent());
                },
                icon: Icon(Icons.logout))
          ],
        ),
        body: isLoading
            ? Center(
                child: CircularProgressIndicator(),
              )
            : Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Text('mail = ${personModel.mail!}'),
                    Text('name = ${personModel.name!}'),
                    Text('age = ${personModel.age!}'),
                    Text('weight = ${personModel.weight!}'),
                    Text('lengt = ${personModel.length!}'),
                    Text('sex = ${personModel.sex!}'),
                  ],
                ),
              ),
      ),
    );
  }
}

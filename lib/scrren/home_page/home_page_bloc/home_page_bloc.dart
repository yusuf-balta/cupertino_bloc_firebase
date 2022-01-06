import 'package:cupertione_flutter/model/person_model.dart';
import 'package:cupertione_flutter/scrren/home_page/home_page_bloc/home_page_event.dart';
import 'package:cupertione_flutter/scrren/home_page/home_page_bloc/home_page_state.dart';
import 'package:cupertione_flutter/scrren/home_page/home_page_service/home_page_service.dart';
import 'package:cupertione_flutter/scrren/login_page/login_page.dart';
import 'package:cupertione_flutter/scrren/login_page/login_page_service/login_page_service.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomePageBloc extends Bloc<HomePageEvent, HomePageState> {
  HomePageService homePageService = HomePageService();
  HomePageBloc() : super(InitialHomePageState()) {
    on(homePageEventControl);
  }
  Future<void> homePageEventControl(
      HomePageEvent event, Emitter<HomePageState> emit) async {
    if (event is InitialHomePageEvent) {
      late PersonModel personModel;
      try {
        final result = await homePageService.get();
        personModel =
            PersonModel.fromMap(result.snapshot.value as Map<dynamic, dynamic>);
        print(personModel);
        emit(SuccsesHomePageState(personModel: personModel));
      } catch (e) {
        print(e);
      }
    } else if (event is LogOutHomePageEvent) {
      try {
        await homePageService.logoutUser();
        emit(LogoutUserSuccses());
      } catch (e) {}
    }
  }
}

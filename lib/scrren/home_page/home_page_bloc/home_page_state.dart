import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

import 'package:cupertione_flutter/model/person_model.dart';

abstract class HomePageState extends Equatable {
  List<Object?> get props => [UniqueKey()];
}

class InitialHomePageState extends HomePageState {}

class LogoutUserSuccses extends HomePageState {}

class SuccsesHomePageState extends HomePageState {
  PersonModel personModel;
  SuccsesHomePageState({
    required this.personModel,
  });
}

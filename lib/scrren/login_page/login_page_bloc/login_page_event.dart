import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

import 'package:cupertione_flutter/model/person_model.dart';

abstract class LoginPageEvent extends Equatable {
  @override
  List<Object?> get props => [UniqueKey()];
}

class InitialLoginEvent extends LoginPageEvent {}

class LoadLoginEvent extends LoginPageEvent {}

class CreateUserLoginPageEvent extends LoginPageEvent {
  PersonModel personModel;
  CreateUserLoginPageEvent({
    required this.personModel,
  });
  @override
  List<Object?> get props => [UniqueKey(), personModel];
}

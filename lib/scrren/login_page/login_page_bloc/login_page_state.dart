import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

abstract class LoginPageState extends Equatable {
  List<Object?> get props => [UniqueKey()];
}

class InitialLoginState extends LoginPageState {}

class SplashLoadingLoginState extends LoginPageState {}

class SplashLoadedLoginState extends LoginPageState {}

class LoadingLoginState extends LoginPageState {}

class CreateSuccsesLoginPageState extends LoginPageState {}

class ErrorLoginState extends LoginPageState {}

class FailedLoginState extends LoginPageState {}

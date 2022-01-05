import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

abstract class HomePageEvent extends Equatable {
  @override
  List<Object?> get props => [UniqueKey()];
}

class LogOutHomePageEvent extends HomePageEvent {}

class InitialHomePageEvent extends HomePageEvent {}

part of 'dashboard_bloc.dart';

@immutable
abstract class DashboardState {}

class DashboardInitial extends DashboardState {}

class SuccesGetDashboard extends DashboardState{}

class FailedGetDashboard extends DashboardState{}
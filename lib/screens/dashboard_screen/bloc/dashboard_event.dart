part of 'dashboard_bloc.dart';

@immutable
abstract class DashboardEvent {}

class GetDashboardEvent extends DashboardEvent{
  @override
  String toString() => 'GetDashboardEvent';
}

class LoadMoreEvent extends DashboardEvent{
  @override
  String toString() => 'LoadMoreEvent';
}

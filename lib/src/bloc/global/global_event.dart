part of 'global_bloc.dart';

sealed class GlobalEvent extends Equatable {
  const GlobalEvent();

  @override
  List<Object> get props => [];
}

class ChangeNewCurrency extends GlobalEvent {
  final int newCurrency;

  const ChangeNewCurrency(this.newCurrency);
}

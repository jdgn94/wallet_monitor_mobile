part of 'global_bloc.dart';

sealed class GlobalState extends Equatable {
  final int? newCurrency;

  const GlobalState(this.newCurrency);

  @override
  List<Object> get props => [];
}

final class GlobalInitial extends GlobalState {
  const GlobalInitial(super.newCurrency);
}

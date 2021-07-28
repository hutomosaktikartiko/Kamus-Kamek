part of 'country_cubit.dart';

abstract class CountryState extends Equatable {
  const CountryState();

  @override
  List<Object?> get props => [];
}

class CountryInitial extends CountryState {}

class CountryLoaded extends CountryState {
  final List<CountryModel> countrys;

  CountryLoaded(this.countrys);

  @override
  List<Object?> get props => [countrys];
}

class CountryLoadingFailed extends CountryState {
  final String message;

  CountryLoadingFailed(this.message);

  @override
  List<Object?> get props => [message];
}

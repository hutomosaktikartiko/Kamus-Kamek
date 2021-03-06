part of 'country_cubit.dart';

abstract class CountryState extends Equatable {
  const CountryState();

  @override
  List<Object?> get props => [];
}

class CountryInitial extends CountryState {}

class CountryLoaded extends CountryState {
  final List<CountryModel> listCountries;

  CountryLoaded(this.listCountries);

  @override
  List<Object?> get props => [listCountries];
}

class CountryLoadingFailed extends CountryState {
  final String message;

  CountryLoadingFailed(this.message);

  @override
  List<Object?> get props => [message];
}
part of 'language_cubit.dart';

abstract class LanguageState extends Equatable {
  const LanguageState();

  @override
  List<Object?> get props => [];
}

class LanguageInitial extends LanguageState {}

class LanguageLoaded extends LanguageState {
  final List<CountryModel> listCountries;

  LanguageLoaded(this.listCountries);

  @override
  List<Object?> get props => [listCountries];
}

class LanguageLoadingFailed extends LanguageState {
  final String message;

  LanguageLoadingFailed(this.message);

  @override
  List<Object?> get props => [message];
}


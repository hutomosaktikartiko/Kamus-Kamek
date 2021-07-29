import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:kamus_kamek/models/api_return_value.dart';
import 'package:kamus_kamek/models/country_model.dart';
import 'package:kamus_kamek/services/country_services.dart';

part 'country_state.dart';

class CountryCubit extends Cubit<CountryState> {
  CountryCubit() : super(CountryInitial());

  void getCountry() {
    ApiReturnValue<List<CountryModel>> result =
         CountryServices.getCountry();

    if (result.value != null) {
      result.value!.sort((a, b) => a.country!.compareTo(b.country!));
      emit(CountryLoaded(result.value!));
    } else {
      emit(CountryLoadingFailed(result.message!));
    }
  }
}

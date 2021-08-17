import 'package:bloc/bloc.dart';
import 'package:kamus_kamek/models/api_return_value.dart';
import 'package:kamus_kamek/models/country_model.dart';
import 'package:kamus_kamek/services/country_services.dart';
import 'package:equatable/equatable.dart';

part 'country_state.dart';

class CountryCubit extends Cubit<CountryState> {
  CountryCubit() : super(CountryInitial());

  Future<void> getCountries() async {
    ApiReturnValue<List<CountryModel>> results = await CountryServices.getCountries();

    if (results.value != null) {
      emit(CountryLoaded(results.value!));
    } else {
      emit(CountryLoadingFailed(results.message!));
    }
  }
}

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:kamus_kamek/models/api_return_value.dart';
import 'package:kamus_kamek/models/country_model.dart';
import 'package:kamus_kamek/services/country_services.dart';

part 'country_state.dart';

class CountryCubit extends Cubit<CountryState> {
  CountryCubit() : super(CountryInitial());

  Future<void> getCountry() async {
    ApiReturnValue<List<CountryModel>> result =
        await CountryServices.getCountry();

    if (result.value != null) {
      emit(CountryLoaded(result.value!));
    } else {
      emit(CountryLoadingFailed(result.message!));
    }
  }
}

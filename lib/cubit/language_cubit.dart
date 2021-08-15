import 'package:bloc/bloc.dart';
import 'package:kamus_kamek/models/api_return_value.dart';
import 'package:kamus_kamek/models/country_model.dart';
import 'package:equatable/equatable.dart';
import 'package:kamus_kamek/services/country_services.dart';

part 'language_state.dart';

class LanguageCubit extends Cubit<LanguageState> {
  LanguageCubit() : super(LanguageInitial());

  Future<void> getLanguages() async {
    ApiReturnValue<List<CountryModel>> result =
        await CountryServices.getLanguages();

    if (result.value != null) {
      emit(LanguageLoaded(result.value!));
    } else {
      emit(LanguageLoadingFailed(result.message!));
    }
  }
}

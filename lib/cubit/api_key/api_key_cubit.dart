import 'package:bloc/bloc.dart';
import 'package:kamus_kamek/models/api_key_model.dart';
import 'package:equatable/equatable.dart';
import 'package:kamus_kamek/models/api_return_value.dart';
import 'package:kamus_kamek/services/api_key_services.dart';

part 'api_key_state.dart';

class APIKeyCubit extends Cubit<APIKeyState> {
  APIKeyCubit() : super(APIKeyInitial());

  Future<void> getAPIKeys () async {
    ApiReturnValue<List<APIKeyModel>> results = await APIKeyServices.getAPIKeys();

    if (results.value != null) {
      emit(APIKeyLoaded(results.value!));
    } else {
      emit(APIKeyLoadingFailed(results.message!));
    }
  }
}

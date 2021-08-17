part of 'api_key_cubit.dart';

abstract class APIKeyState extends Equatable {
  const APIKeyState();

  @override
  List<Object?> get props => [];
}

class APIKeyInitial extends APIKeyState {}

class APIKeyLoaded extends APIKeyState {
  final List<APIKeyModel> listAPIKeys;

  APIKeyLoaded(this.listAPIKeys);

  @override
  List<Object?> get props => [listAPIKeys];
}

class APIKeyLoadingFailed extends APIKeyState {
  final String message;

  APIKeyLoadingFailed(this.message);

  @override
  List<Object?> get props => [message];
}



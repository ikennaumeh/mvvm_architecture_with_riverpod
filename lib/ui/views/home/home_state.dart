import 'package:mvvm_riverpod/ui/views/home/home_view_model.dart';

class HomeState {
  final UiState uiState;
  final List<String> houndList;
  final String? errorMessage;

  HomeState({required this.uiState, required this.houndList, this.errorMessage});

  HomeState.initial(): this(uiState: UiState.idle, houndList: const [], errorMessage: null);

  HomeState copyWith(
      {UiState? uiState, List<String>? houndList, String? errorMessage}){
    return HomeState(
      uiState: uiState ?? this.uiState,
      houndList: houndList ?? this.houndList,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }
}

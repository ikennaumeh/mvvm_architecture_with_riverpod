import 'dart:async';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mvvm_riverpod/services/animal_service.dart';
import 'package:mvvm_riverpod/ui/views/home/home_state.dart';

final homeViewModelProvider =
    NotifierProvider.autoDispose<HomeViewModel, HomeState>(
      () => HomeViewModel(),
    );

class HomeViewModel extends AutoDisposeNotifier<HomeState> {
  HomeViewModel() : super();

  @override
  HomeState build() => HomeState.initial();

  Future<void> fetchHoundDogs() async {
    state = state.copyWith(uiState: UiState.loading);

    final response = await ref.read(animalServiceProvider).fetchHoundsList();
    response.fold(
      (error) {
        state = state.copyWith(
          uiState: UiState.error,
          errorMessage: error.toString(),
        );
      },
      (data) {
        state = state.copyWith(uiState: UiState.success, houndList: data);
      },
    );
  }
}

enum UiState { idle, loading, success, error }

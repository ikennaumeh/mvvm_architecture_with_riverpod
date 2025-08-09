import 'dart:async';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mvvm_riverpod/services/animal_service.dart';
import 'package:mvvm_riverpod/ui/views/home/home_state.dart';

final homeViewModelProvider = AutoDisposeAsyncNotifierProvider<HomeViewModel, HomeState>(HomeViewModel.new);

class HomeViewModel extends AutoDisposeAsyncNotifier<HomeState> {

  @override
  FutureOr<HomeState> build() async {
    final animalService = ref.read(animalServiceProvider);
    final list = await animalService.fetchHoundsList();

    return HomeState(houndList: list);
  }

  Future<void> fetchHoundDogs() async {
    state = AsyncLoading();

    state = await AsyncValue.guard(() async {
      final animalService = ref.read(animalServiceProvider);
      final list = await animalService.fetchHoundsList();

      return HomeState(houndList: list);
    });
  }

}

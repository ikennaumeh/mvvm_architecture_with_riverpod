class HomeState {
  final List<String> houndList;

  HomeState({this.houndList = const []});

  HomeState copyWith(List<String>? houndList){
    return HomeState(
      houndList: houndList ?? this.houndList
    );
  }
}

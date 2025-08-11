import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mvvm_riverpod/ui/views/home/home_view_model.dart';

class HomeView extends ConsumerStatefulWidget {
  const HomeView({super.key});

  @override
  ConsumerState<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends ConsumerState<HomeView> {

  @override
  void initState() {
    super.initState();

    WidgetsFlutterBinding.ensureInitialized().addPostFrameCallback((_){
      ref.read(homeViewModelProvider.notifier).fetchHoundDogs();
    });
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(homeViewModelProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Home'),
        centerTitle: true,
      ),
      body: switch(state.uiState){
        UiState.loading => Container(
          height: double.maxFinite,
          width: double.maxFinite,
          color: Colors.grey.shade50,
          child: Center(
            child: CircularProgressIndicator.adaptive(),
          ),
        ),
       UiState.success => state.houndList.isEmpty ?
       Center(child: const Text("No dogs found")) :
       Center(
         child: Column(
           mainAxisAlignment: MainAxisAlignment.center,
           children: state.houndList.map((e){
             return ListTile(
               title: Text(e),
             );
           }).toList(),
         ),
       ),
      UiState.error =>
          Container(
            height: double.maxFinite,
            width: double.maxFinite,
            color: Colors.grey.shade50,
            child: Center(child: Text(state.errorMessage ?? "")),
          ),
        _ => Text("The end")
      },
    );
  }
}


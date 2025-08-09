import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mvvm_riverpod/ui/views/home/home_view_model.dart';

class HomeView extends ConsumerWidget{
  const HomeView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(homeViewModelProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Home'),
        centerTitle: true,
      ),
      body: state.when(
          data: (data){
            final houndList = data.houndList;

            if(houndList.isEmpty){
              return const Text("No dogs found");
            }

            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: houndList.map((e){
                  return ListTile(
                    title: Text(e),
                  );
                }).toList(),
              ),
            );
          },
          error: (error, _){
            return Container(
              height: double.maxFinite,
              width: double.maxFinite,
              color: Colors.grey.shade50,
              child: Center(child: const Text("Error")),
            );
          },
          loading: (){
            return Container(
              height: double.maxFinite,
              width: double.maxFinite,
              color: Colors.grey.shade50,
              child: Center(
                child: CircularProgressIndicator.adaptive(),
              ),
            );
          },
      ),
    );
  }

}
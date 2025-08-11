import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mvvm_riverpod/core/either.dart';
import 'package:mvvm_riverpod/services/network_service.dart';
import 'package:mvvm_riverpod/ui/enums/request.dart';

final animalServiceProvider = Provider<AnimalService>((ref) => AnimalService(
  networkService: ref.watch(networkServiceProvider),
));

class AnimalService {
  final NetworkService networkService;

  AnimalService({required this.networkService});

  Future<Either<Exception, List<String>>> fetchHoundsList() async {

    try{
      final response = await networkService.request(
        "/breeds/list/all",
        request: Request.get,
      );
      return Right(List<String>.from(response['message']['hound']));
    } catch (e){
      return Left(Exception(e));
    }
  }
}
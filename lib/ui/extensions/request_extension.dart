import 'package:mvvm_riverpod/ui/enums/request.dart';

extension RequestExtension on Request {
  String get method {
    switch (this) {
      case Request.get:
        return "GET";
      case Request.post:
        return "POST";
    }
  }
}
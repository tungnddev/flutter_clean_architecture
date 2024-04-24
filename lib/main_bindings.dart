import 'package:get/get.dart';
import 'package:flutter_clean_architecture/data/data_binding.dart';

class MainBindings extends Bindings {
  @override
  Future dependencies() async {
    await DataBinding().dependencies();
  }
}
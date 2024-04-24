import 'package:flutter_clean_architecture/data/bindings/auth_binding.dart';
import 'package:flutter_clean_architecture/data/bindings/local_service_binding.dart';
import 'package:flutter_clean_architecture/data/bindings/product_binding.dart';
import 'package:flutter_clean_architecture/data/bindings/remote_service_binding.dart';
import 'package:get/get.dart';

class DataBinding extends Bindings {
  @override
  Future dependencies() async {
    RemoveServiceBinding().dependencies();
    LocalServiceBinding().dependencies();
    AuthBinding().dependencies();
    ProductBinding().dependencies();
  }
}

import 'package:get/get.dart';

class HomeScreenController extends GetxController
{

  final searchQuery=''.obs;

  void setData(String input) {
    searchQuery.value=input;
  }

}
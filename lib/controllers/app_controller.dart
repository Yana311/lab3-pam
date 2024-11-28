import 'dart:convert';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:wine_shop/models/wine_model.dart';
import 'package:wine_shop/models/wine_by_model.dart'; // Asigură-te că importul este corect

class AppController extends GetxController {
  RxList<WineModel> wineList = <WineModel>[].obs;
  RxList<WinesByModel> winesByList = <WinesByModel>[].obs; // Lista pentru `wines_by`

  @override
  void onInit() {
    super.onInit();
    loadWinesFromJson();
  }

  Future<void> loadWinesFromJson() async {
    try {
      final String response = await rootBundle.loadString('assets/v3.json');
      final Map<String, dynamic> jsonData = json.decode(response);

      // Încarcă datele pentru `carousel`
      final List<dynamic> carouselData = jsonData['carousel'];
      wineList.value = carouselData.map((wine) => WineModel.fromJson(wine)).toList();

      // Încarcă datele pentru `wines_by`
      final List<dynamic> winesByData = jsonData['wines_by'];
      winesByList.value = winesByData.map((item) => WinesByModel.fromJson(item)).toList();

      // Afișează datele pentru `wines_by` în consolă
      for (var item in winesByList.value) {
        print('Tag: ${item.tag}, Name: ${item.name}');
      }

      // Afișează datele pentru `carousel` în consolă
      for (var wine in wineList.value) {
        print('Wine: ${wine.name}, Type: ${wine.type}, Country: ${wine.country}, Price: ${wine.price}');
      }
    } catch (e) {
      print('Error loading JSON: $e');
    }
  }
}

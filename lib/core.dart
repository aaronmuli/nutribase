import 'package:http/http.dart';
import 'dart:convert';

class Core {
  // bool history = false;
  Map foodInfo = {
    "sugar_g": 2.6,
    "fiber_g": 1.2,
    "serving_size_g": 100.0,
    "sodium_mg": 4,
    "name": "tomato",
    "potassium_mg": 23,
    "fat_saturated_g": 0.0,
    "fat_total_g": 0.2,
    "calories": 18.2,
    "cholesterol_mg": 0,
    "protein_g": 0.9,
    "carbohydrates_total_g": 3.9
  };

  // Map foodInfo = {};
  var headers = {
    "X-RapidAPI-Key": "692655bfb2msh572510d61eb9fcep105ba5jsn43742c7229d0",
    "X-RapidAPI-Host": "calorieninjas.p.rapidapi.com"
  };

  Map getFoodInformation(String food) {
    try {
      var url = Uri.https(
          "calorieninjas.p.rapidapi.com", "/v1/nutrition", {"query": food});
      // var response = await get(url, headers: headers);
      // var foodInfo = jsonDecode(response.body);
      // foodInfo = foodInfo["items"][0]; // get the inner map
      return foodInfo;
    } catch (e) {
      print(foodInfo);
      return {};
    }
  }
}

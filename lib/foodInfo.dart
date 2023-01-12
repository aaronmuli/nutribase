class FoodInfo {
  Map foodInfo;
  // nutrition content for the food

  String name = "";
  double servingSize = 100.0; // grams
  double sugar = 0.0; // grams
  double fiber = 0.0; // grams
  double sodium = 0.0; // milligrams
  double potassium = 0.0; // milligrams
  double saturatedFats = 0.0; // grams
  double totalFats = 0.0; // grams
  double calories = 0.0; // grams
  double cholesterol = 0.0; // milligrams
  double protein = 0.0; // grams
  double totalCarbohydrates = 0.0; // grams

  FoodInfo(this.foodInfo) {
    name = foodInfo["name"].toUpperCase();
    servingSize = foodInfo["serving_size_g"].toDouble();
    sugar = foodInfo["sugar_g"].toDouble();
    fiber = foodInfo["fiber_g"].toDouble();
    sodium = foodInfo["sodium_mg"].toDouble();
    potassium = foodInfo["potassium_mg"].toDouble();
    saturatedFats = foodInfo["fat_saturated_g"].toDouble();
    totalFats = foodInfo["fat_total_g"].toDouble();
    calories = foodInfo["calories"].toDouble();
    cholesterol = foodInfo["cholesterol_mg"].toDouble();
    protein = foodInfo["protein_g"].toDouble();
    totalCarbohydrates = foodInfo["carbohydrates_total_g"].toDouble();
  }

  Map<String, dynamic> getNutrients() {
    return {
      "name": name,
      "servingSize": servingSize,
      "sugar": sugar,
      "fiber": fiber,
      "sodium": sodium,
      "potassium": potassium,
      "saturatedFats": saturatedFats,
      "totalFats": totalFats,
      "calories": calories,
      "cholesterol": cholesterol,
      "protein": protein,
      "totalCarbohydrates": totalCarbohydrates,
    };
  }

  // double getNutrient(String nutrient) {
  //   return this."$nutrient";
  // }
}

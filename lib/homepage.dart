import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'dart:convert';
import 'package:nutribase/foodInfo.dart';
import 'package:nutribase/loading.dart';
import 'package:nutribase/nutrient.dart';
import 'package:nutribase/core.dart';
import 'dart:io';

class Homepage extends StatefulWidget {
  const Homepage({Key? key}) : super(key: key);

  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  // @override
  // void initState() {
  //   super.initState();
  //   WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
  //     addNutrientToList();
  //   });
  // }

  final _formKey = GlobalKey<FormState>();
  var obj = Core();
  late FoodInfo foo;
  late Map nutrientMap;
  List<Nutrient> nutrientsList = [];

  bool gotFood = false;
  bool loading = false;
  String foodName = "";
  String message = "Search for food to get started.";
  IconData icon = Icons.live_help;

  final GlobalKey<AnimatedListState> _key = GlobalKey();
  final Tween<Offset> _offSet =
      Tween(begin: const Offset(1, 0), end: const Offset(0, 0));

  void addNutrientToList() {
    for (int index = 0; index < nutrients.length; index++) {
      String nutrient = nutrients[index]["name"];
      String info = nutrients[index]["info"];
      // cleaning up the info by removing the newlines.
      info = info.replaceAll("\n", "");
      // get the value of the nutrient
      double amount = nutrientMap[nutrient];
      double dispAmount = amount;

      nutrientsList.add(Nutrient(
        info: info,
        color: nutrients[index]["color"],
        amount: amount > 100.0 ? 100.0 : amount,
        dispAmount: dispAmount, // display amount
        nutrientName: nutrients[index]["dispName"],
        unit: nutrients[index]["unit"],
      ));
      _key.currentState?.insertItem(nutrientsList.length - 1,
          duration: Duration(seconds: 300));
    }
  }

  void showPopup(String message) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text("Error"),
            icon: Icon(Icons.error),
            content: Text(message),
            actions: [
              ElevatedButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: Text("OK"))
            ],
          );
        });
  }

  // used during development to get the predefined nutrients not accessing the internet
  void showNutrients() {
    Map res = obj.getFoodInformation(foodName);
    if (res.isEmpty) {
      setState(() {
        message = "Invalid food name, please enter a valid name!";
        icon = Icons.error;
        gotFood = false;
        loading = false;
      });
      showPopup(message);
    } else {
      setState(() {
        gotFood = true;
        obj.foodInfo = res;
        foo = FoodInfo(obj.foodInfo);
        nutrientMap = foo.getNutrients();
        addNutrientToList();
        loading = false;
      });
    }
  }

  void searchFood() async {
    FocusManager.instance.primaryFocus?.unfocus();
    setState(() {
      loading = true;
      gotFood = false;
    });
    if (_formKey.currentState!.validate()) {
      try {
        final result = await InternetAddress.lookup(
            "www.google.com"); // to check for internet connection
        if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
          Map res = obj.getFoodInformation(foodName);
          if (res.isEmpty) {
            setState(() {
              message = "Invalid food name, please enter a valid name!";
              icon = Icons.error;
              gotFood = false;
              loading = false;
            });
            showPopup(message);
          } else {
            setState(() {
              gotFood = true;
              obj.foodInfo = res;
              foo = FoodInfo(obj.foodInfo);
              nutrientMap = foo.getNutrients();
              addNutrientToList();
              loading = false;
            });
          }
        }
      } catch (e) {
        setState(() {
          message =
              "You are offline, check your internet connection and try again!";
          icon = Icons.cloud_off;
          gotFood = false;
          loading = false;
        });
        showPopup(message);
      }
    }
  }

  // defines the properties for each nutrient to be displayed
  final List nutrients = [
    {
      "dispName": "Serving Size",
      "name": "servingSize",
      "color": Colors.black26,
      "unit": "grams",
      "unitRep": "g",
      "info":
          """A “serving size” is a standard amount of a food, such as a cup or an ounce. Serving sizes can help you when choosing foods and when comparing similar items while shopping, but they are not recommendations for how much of a certain food to eat.""",
    },
    {
      "dispName": "Calories",
      "name": "calories",
      "color": Colors.red,
      "unit": "grams",
      "unitRep": "g",
      "info":
          """A calorie is a unit of measurement that describes how much energy is released when your body breaks down food. Although calorie count alone does not dictate whether a food is nutritious, thinking about how many calories you need can guide healthy eating habits.""",
    },
    {
      "dispName": "Proteins",
      "name": "protein",
      "color": Colors.deepPurple,
      "unit": "grams",
      "unitRep": "g",
      "info":
          """Proteins are large, complex molecules that play many critical roles in the body. They do most of the work in cells and are required for the structure, function, and regulation of the body’s tissues and organs. Proteins are made up of hundreds or thousands of smaller units called amino acids, which are attached to one another in long chains. There are 20 different types of amino acids that can be combined to make a protein. The sequence of amino acids determines each protein’s unique 3-dimensional structure and its specific function. Amino acids are coded by combinations of three DNA building blocks (nucleotides), determined by the sequence of genes.""",
    },
    {
      "dispName": "Total Carbohydrates",
      "name": "totalCarbohydrates",
      "color": Colors.brown,
      "unit": "grams",
      "unitRep": "g",
      "info":
          """Total carbohydrates includes all three types of carbohydrate: sugar, starch and fiber. It's important to use the total grams when counting carbs or choosing which foods to include.""",
    },
    {
      "dispName": "Fiber",
      "name": "fiber",
      "color": Colors.green,
      "unit": "grams",
      "unitRep": "g",
      "info":
          """Fiber is a type of carbohydrate that the body can’t digest. Though most carbohydrates are broken down into sugar molecules called glucose, fiber cannot be broken down into sugar molecules, and instead it passes through the body undigested. Fiber helps regulate the body’s use of sugars, helping to keep hunger and blood sugar in check.""",
    },
    {
      "dispName": "Sugar",
      "name": "sugar",
      "color": Colors.orange,
      "unit": "grams",
      "unitRep": "g",
      "info":
          """sugar is sucrose, a disaccharide, made up of two sugars (glucose and fructose) bound together, that is naturally made by and found in all green plants. Sugar found in the food supply is harvested from sugar beets and sugar cane.""",
    },
    {
      "dispName": "Sodium",
      "name": "sodium",
      "color": Colors.blue,
      "unit": "milligrams",
      "unitRep": "mg",
      "info":
          """Sodium is a chemical element with the symbol Na (from Latin natrium) and atomic number 11. It is a soft, silvery-white, highly reactive metal. Sodium is an alkali metal, being in group 1 of the periodic table. Your body needs a small amount of sodium to work properly, but too much sodium can be bad for your health. Diets higher in sodium are associated with an increased risk of developing high blood pressure, which is a major cause of stroke and heart disease.""",
    },
    {
      "dispName": "Total Fats",
      "name": "totalFats",
      "color": Colors.grey,
      "unit": "grams",
      "unitRep": "g",
      "info":
          """Total fats indicates how much fat is in a single serving of food. Although too much fat can lead to health problems, our bodies do need some fat every day. Fats are an important source of energy — they contain twice as much energy per gram as carbohydrates or protein.""",
    },
    {
      "dispName": "Saturated Fats",
      "name": "saturatedFats",
      "color": Colors.purple,
      "unit": "grams",
      "unitRep": "g",
      "info":
          """Saturated fat is a type of dietary fat. It is one of the unhealthy fats, along with trans fat. These fats are most often solid at room temperature. Foods like butter, palm and coconut oils, cheese, and red meat have high amounts of saturated fat. Too much saturated fat in your diet can lead to heart disease and other health problems.""",
    },
    {
      "dispName": "Cholesterol",
      "name": "cholesterol",
      "color": Colors.indigo,
      "unit": "milligrams",
      "unitRep": "mg",
      "info":
          """Cholesterol is a waxy substance found in your blood. Your body needs cholesterol to build healthy cells, but high levels of cholesterol can increase your risk of heart disease. With high cholesterol, you can develop fatty deposits in your blood vessels. Eventually, these deposits grow, making it difficult for enough blood to flow through your arteries. Sometimes, those deposits can break suddenly and form a clot that causes a heart attack or stroke. High cholesterol can be inherited, but it's often the result of unhealthy lifestyle choices, which make it preventable and treatable. A healthy diet, regular exercise and sometimes medication can help reduce high cholesterol.""",
    },
    {
      "dispName": "Potassium",
      "name": "potassium",
      "color": Colors.blueGrey,
      "unit": "milligrams",
      "unitRep": "mg",
      "info":
          """Potassium is an essential mineral that is needed by all tissues in the body. It is sometimes referred to as an electrolyte because it carries a small electrical charge that activates various cell and nerve functions. Potassium is found naturally in many foods and as a supplement. Its main role in the body is to help maintain normal levels of fluid inside our cells. Sodium, its counterpart, maintains normal fluid levels outside of cells. Potassium also helps muscles to contract and supports normal blood pressure.""",
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Column(children: <Widget>[
        Padding(
          padding: const EdgeInsets.fromLTRB(10, 15, 10, 10),
          child: Form(
            key: _formKey,
            child: Expanded(
                child: TextFormField(
              cursorColor: Colors.black,
              decoration: InputDecoration(
                  prefixIcon: const Icon(Icons.food_bank_outlined),
                  suffixIcon: IconButton(
                      splashRadius: 30,
                      onPressed: () {
                        // searchFood();
                        showNutrients();
                      },
                      icon: const Icon(Icons.search)),
                  hintText: "food",
                  fillColor: Colors.grey.shade200,
                  filled: true,
                  enabledBorder: OutlineInputBorder(
                      borderSide:
                          BorderSide(color: Colors.grey.shade200, width: 1.0),
                      borderRadius:
                          const BorderRadius.all(Radius.circular(10))),
                  focusedBorder: const OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.white, width: 2.0),
                      borderRadius: BorderRadius.all(Radius.circular(10))),
                  errorBorder: const OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.red, width: 2.0),
                    borderRadius: BorderRadius.all(Radius.circular(10)),
                  )),
              onChanged: (val) {
                setState(() {
                  foodName = val;
                });
              },
              validator: (val) {
                if (val == null || val.isEmpty) {
                  AlertDialog(
                    elevation: 1,
                    title: const Text("Error"),
                    content: const Text(
                        "Sorry, you have not entered any valid food name."),
                    actions: [
                      TextButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          child: const Text("OK"))
                    ],
                  );
                }
                return;
              },
            )),
          ),
        ),
        const SizedBox(
          height: 5,
        ),
        gotFood
            ? Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    foo.name,
                    style: const TextStyle(
                      fontSize: 18,
                    ),
                  ),
                ],
              )
            : const Text(
                '',
                style: TextStyle(
                  fontSize: 0,
                ),
              ),
        const SizedBox(
          height: 10,
        ),
        gotFood
            ? Expanded(
                child: AnimatedList(
                    initialItemCount: nutrientsList.length,
                    itemBuilder: (BuildContext context, int index,
                        Animation<double> animation) {
                      return SlideTransition(
                          child: nutrientsList[index],
                          position: animation.drive(_offSet));
                    })
                // child: AnimatedList(
                //     key: _key,
                //     initialItemCount: 0,
                //     scrollDirection: Axis.vertical,
                //     shrinkWrap: true,
                //     physics: const AlwaysScrollableScrollPhysics(),
                //     itemBuilder: (BuildContext context, int index,
                //         Animation<double> animation) {
                //       return SizeTransition(
                //         key: UniqueKey(),
                //         sizeFactor: animation,
                //         child: nutrientsList[index],
                //       );
                //     }),
                )
            // gotFood
            //     ? Expanded(
            //         child: ListView.builder(
            //             itemCount: nutrients.length,
            //             scrollDirection: Axis.vertical,
            //             physics: const AlwaysScrollableScrollPhysics(),
            //             shrinkWrap: true,
            //             itemBuilder: (BuildContext context, int index) {
            //               String nutrient = nutrients[index]["name"];
            //               String info = nutrients[index]["info"];
            //               info = info.replaceAll("\n", "");
            //               double amount = nutrientMap[nutrient];
            //               double dispAmount = amount;

            //               return Nutrient(
            //                 info: info,
            //                 color: nutrients[index]["color"],
            //                 amount: amount > 100.0 ? 100.0 : amount,
            //                 dispAmount: dispAmount, // display amount
            //                 nutrientName: nutrients[index]["dispName"],
            //                 unit: nutrients[index]["unit"],
            //               );
            //             }),
            //       )
            : loading && !gotFood
                ? Expanded(child: Loading().spinkit)
                : Expanded(child: Center()),
      ]),
    );
  }
}

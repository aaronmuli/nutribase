import 'package:flutter/material.dart';
// import 'package:nutribase/foodInfo.dart';
import 'package:percent_indicator/percent_indicator.dart';

class Nutrient extends StatelessWidget {
  const Nutrient({
    Key? key,
    required this.color,
    required this.amount,
    required this.nutrientName,
    required this.unit,
    // required this.unitRep,
    required this.dispAmount,
    required this.info,
  }) : super(key: key);

  // final FoodInfo foodInfo;
  final Color color;
  final double amount;
  final double dispAmount;
  final String nutrientName;
  final String unit;
  final String info;

  // var amountCount = 0.0;

  amountCounter(double amount) {
    for (var i = 0.0; i < amount; i++) {
      return (i);
    }
  }

  @override
  Widget build(BuildContext context) {
    // print(amountCounter(amount));
    return Material(
      child: Card(
        shadowColor: Colors.grey.shade300,
        margin: const EdgeInsets.all(10),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        child: Container(
          margin: const EdgeInsets.fromLTRB(10, 5, 5, 5),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  CircularPercentIndicator(
                    radius: 33,
                    lineWidth: 6.0,
                    circularStrokeCap: CircularStrokeCap.round,
                    percent: (amount / 100), // percent has to be between 0 to 1
                    progressColor: color,
                    animationDuration: 800,
                    backgroundColor: const Color.fromARGB(31, 131, 131, 131),
                    animation: true,
                    center: Text(
                      "$amount",
                      style: const TextStyle(
                        fontSize: 13,
                      ),
                    ),
                  ),
                  const SizedBox(
                    width: 15,
                  ),
                  // name of nutrient
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        nutrientName,
                        style: const TextStyle(
                          fontSize: 16,
                        ),
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      Text(
                        unit,
                        style: const TextStyle(
                          fontSize: 13,
                          color: Colors.grey,
                        ),
                      ),
                    ],
                  )
                ],
              ),
              // information button icon
              InkWell(
                  splashColor: Colors.grey.shade300,
                  borderRadius: BorderRadius.circular(50),
                  onTap: () {
                    showModalBottomSheet(
                        elevation: 1,
                        context: context,
                        backgroundColor: Colors.grey[200],
                        builder: (BuildContext context) {
                          return Column(
                            children: [
                              const SizedBox(
                                height: 20,
                              ),
                              InkWell(
                                splashColor: Colors.grey[600],
                                borderRadius: BorderRadius.circular(50),
                                onTap: () {
                                  Navigator.pop(context);
                                },
                                child: const Icon(
                                  Icons.close,
                                  color: Colors.grey,
                                  size: 30,
                                ),
                              ),
                              const SizedBox(
                                height: 30,
                              ),
                              Text(
                                nutrientName,
                                style: const TextStyle(
                                  color: Colors.green,
                                  fontSize: 30,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              const SizedBox(
                                height: 5,
                              ),
                              Expanded(
                                child: SingleChildScrollView(
                                  child: Center(
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Text(info.trim(),
                                          style: const TextStyle(
                                            fontSize: 18,
                                          )),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          );
                        });
                  },
                  child:
                      Icon(Icons.info_outline, color: Colors.grey, size: 40)),
            ],
          ),
        ),
      ),
    );
  }
}

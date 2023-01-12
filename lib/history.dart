// import 'package:flutter/material.dart';
// import 'package:nutribase/core.dart';
// import 'package:nutribase/foodInfo.dart';

// class History extends StatefulWidget {
//   const History({
//     Key? key,
//     // required this.gotHistory,
//     // required this.message,
//     // required this.searches,
//   }) : super(key: key);

//   // bool gotHistory = false;
//   // String message = "No search history found, search for food to get started.";
//   // List<String> searches = [
//   //   "Apple",
//   //   "Beef",
//   //   "Rice",
//   // ];
//   @override
//   State<History> createState() => _HistoryState();
// }

// class _HistoryState extends State<History> {
//   bool gotHistory = true;
//   String message = "No search history found, search for food to get started.";
//   List<String> searches = [
//     "Apple",
//     "Beef",
//     "Rice",
//   ];

//   void searchHistory(String history) async {
//     // print("search $history");
//     Core obj = Core();
//     var res = await obj.getFoodInformation(history);
//     setState(() {
//       obj.foodInfo = res;
//       obj.history = true;
//     });
//     print("response : $res");
//   }

//   void deleteHistory(String history) {
//     print("deleted $history");
//   }

//   @override
//   Widget build(BuildContext context) {
//     return gotHistory
//         ? Expanded(
//             child: ListView.builder(
//                 itemCount: searches.length,
//                 itemBuilder: (BuildContext context, int index) {
//                   return Material(
//                     child: InkWell(
//                       splashColor: Colors.grey,
//                       borderRadius: BorderRadius.circular(10),
//                       onTap: () {
//                         // search for this particulate history search
//                         searchHistory(searches[index]);
//                       },
//                       child: Card(
//                         shadowColor: Colors.grey,
//                         margin: const EdgeInsets.all(10),
//                         shape: RoundedRectangleBorder(
//                             borderRadius: BorderRadius.circular(10)),
//                         child: Row(
//                           mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                           children: <Widget>[
//                             Padding(
//                               padding: const EdgeInsets.all(10.0),
//                               child: Text(
//                                 searches[index],
//                                 style: const TextStyle(
//                                   fontSize: 20,
//                                 ),
//                               ),
//                             ),
//                             Padding(
//                               padding: const EdgeInsets.all(10.0),
//                               child: InkWell(
//                                 splashColor: Colors.lightGreen,
//                                 borderRadius: BorderRadius.circular(50),
//                                 onTap: () {
//                                   // delete the particulate history search from the history list
//                                   deleteHistory(searches[index]);
//                                 },
//                                 child: const Icon(
//                                   Icons.cancel_rounded,
//                                   color: Colors.green,
//                                   size: 40,
//                                 ),
//                               ),
//                             )
//                           ],
//                         ),
//                       ),
//                     ),
//                   );
//                 }),
//           )
//         : Expanded(
//             child: ListView(
//               children: [
//                 Padding(
//                   padding: const EdgeInsets.all(5.0),
//                   child: Column(
//                     mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                     children: <Widget>[
//                       const Icon(
//                         Icons.live_help,
//                         color: Colors.grey,
//                         size: 100,
//                       ),
//                       const SizedBox(
//                         height: 50,
//                       ),
//                       Text(
//                         message,
//                         textAlign: TextAlign.center,
//                         style: const TextStyle(
//                           fontSize: 30,
//                           color: Colors.grey,
//                         ),
//                       ),
//                     ],
//                   ),
//                 )
//               ],
//             ),
//           );
//   }
// }

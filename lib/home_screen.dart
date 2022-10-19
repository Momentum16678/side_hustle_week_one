import 'package:geolocator/geolocator.dart';
import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:side_hustle_week_one/left_bar.dart';
import 'package:side_hustle_week_one/right_bar.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}
//The getter 'latitude' isn't defined for the type 'Future<List<Location>>'.
//check medium link on android permissions and google api keys setup
final TextEditingController _firstLocation = TextEditingController();
final TextEditingController _secondLocation = TextEditingController();
Position secondCoordinates = (locationFromAddress(_secondLocation.text.toString())) as Position;
Position firstCoordinates  = (locationFromAddress(_firstLocation.text.toString())) as Position;


class _HomePageState extends State<HomePage> {

  double distanceInMeters = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Distance Calculator",
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: SingleChildScrollView(
         child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
             Padding(
               padding: const EdgeInsets.only(top: 25.0, left: 18.0),
               child: Column(
                 mainAxisAlignment: MainAxisAlignment.start,
                 children: [
                   Row(
                     mainAxisAlignment: MainAxisAlignment.start,
                     children: const [
                       Text("Enter first location",
                       style: TextStyle(
                           fontSize: 20,
                           fontWeight: FontWeight.w300,
                           color: Colors.black
                         ),
                       ),
                     ],
                   ),
                   const SizedBox(height: 10,),
                   Row(
                     mainAxisAlignment: MainAxisAlignment.start,
                     children: [
                       Container(
                         width: 300,
                         height: 30,
                         decoration: BoxDecoration(
                           border: Border.all(color: Colors.black)
                         ),
                         child: TextField(
                           controller: _firstLocation,
                           style: TextStyle(
                               color: Colors.black,
                               fontSize: 18,
                               fontWeight: FontWeight.normal
                           ),
                         ),
                       ),
                     ],
                   )
                 ],
               ),
             ),
             const SizedBox(height: 10,),
             Padding(
              padding: const EdgeInsets.all(18.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: const [
                      Text("Enter second location",
                        style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.w300,
                            color: Colors.black
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 10,),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Container(
                        width: 300,
                        height: 30,
                        decoration: BoxDecoration(
                            border: Border.all(color: Colors.black)
                        ),
                        child: TextField(
                          controller: _secondLocation,
                          style: TextStyle(
                              color: Colors.black,
                              fontSize: 18,
                              fontWeight: FontWeight.normal
                          ),
                        ),
                      ),
                    ],
                  )
                ],
              ),
            ),
             const SizedBox(height: 20,),
             GestureDetector(
               onTap: ()  {
                 setState(() {
                   distanceInMeters = Geolocator.distanceBetween(
                       firstCoordinates.latitude,
                       firstCoordinates.longitude,
                       secondCoordinates.latitude,
                       secondCoordinates.longitude
                   );
                 });
               },
               child: Container(
                 height: 50,
                 width: 200,
                 color: Colors.blue,
                 child: Row(
                   mainAxisAlignment: MainAxisAlignment.center,
                   children: [
                     Text(
                       "Calculate",
                       style: TextStyle(
                         color: Colors.white,
                         fontSize: 30,
                         fontWeight: FontWeight.bold,
                       ),
                     ),
                   ],
                 ),
               ),
             ),
             const SizedBox(height: 20,),
             Padding(
              padding: const EdgeInsets.only(left: 18.0, top: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Container(
                    width: 300,
                    height: 30,
                    decoration: BoxDecoration(
                        border: Border.all(color: Colors.black)
                    ),
                    child: Text(
                      distanceInMeters.toStringAsFixed(2),
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 18,
                          fontWeight: FontWeight.normal
                      ),
                    ),
                  ),
                ],
              ),
            ),

             const SizedBox(height: 40,),
             const LeftBar(barWidth: 40,),
             const SizedBox(height: 20,),
             const LeftBar(barWidth: 70,),
             const SizedBox(height: 20,),
             const RightBar(barWidth: 70,),
             const SizedBox(height: 20,),
             const RightBar(barWidth: 40,),
             const SizedBox(height: 40,),
             const LeftBar(barWidth: 40,),
             const SizedBox(height: 20,),
             const LeftBar(barWidth: 70,),
          ],
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  String category1 = "Flutter";
  String _name1 = "";
  String _courseName1 = "";
  String _img1 = "";
  String category2 = "Web Programming";
  String _name2 = "";
  String _courseName2 = "";
  String _img2 = "";
  String category3 = "AI & ML";
  String _name3 = "";
  String _courseName3 = "";
  String _img3 = "";
  String category4 = "Digital Marketing";
  String _name4 = "";
  String _courseName4 = "";
  String _img4 = "";

  @override
  void initState() {
    var db = FirebaseFirestore.instance;
    final docRef1 = db.collection('courses').doc(category1);
    docRef1.get().then((value) {
      print(value.data());
      setState(() {
        _name1 = value.data()?['name'];
        _courseName1 = value.data()?['course_name'];
        _img1 = value.data()?['img'];
      });
    });

    final docRef2 = db.collection('courses').doc(category2);
    docRef2.get().then((value) {
      print(value.data());
      setState(() {
        _name2 = value.data()?['name'];
        _courseName2 = value.data()?['course_name'];
        _img2 = value.data()?['img'];
      });
    });

    final docRef3 = db.collection('courses').doc(category3);
    docRef3.get().then((value) {
      print(value.data());
      setState(() {
        _name3 = value.data()?['name'];
        _courseName3 = value.data()?['course_name'];
        _img3 = value.data()?['img'];
      });
    });

    final docRef4 = db.collection('courses').doc(category4);
    docRef4.get().then((value) {
      print(value.data());
      setState(() {
        _name4 = value.data()?['name'];
        _courseName4 = value.data()?['course_name'];
        _img4 = value.data()?['img'];
      });
    });

    super.initState();
    //getUserData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Card Example'),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            buildCard(_courseName1, _name1, Colors.teal, Colors.yellow, _img1),
            SizedBox(height: 16.0),
            buildCard(_courseName2, _name2, Colors.green, Colors.green, _img2),
            SizedBox(height: 16.0),
            buildCard(
                _courseName3, _name3, Colors.purple, Colors.purple, _img3),
            SizedBox(height: 16.0),
            buildCard(_courseName4, _name4, Colors.blue, Colors.blue, _img4),
          ],
        ),
      ),
    );
  }
}

Widget buildCard(String title, String name, Color stripeColor,
    Color borderColor, String imagePath) {
  return Card(
    elevation: 4.0,
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Container(
          color: stripeColor,
          padding: EdgeInsets.all(8.0),
          child: Text(
            title,
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        Padding(
          padding: EdgeInsets.all(16.0),
          child: Row(
            children: [
              CircleAvatar(
                radius: 40.0,
                backgroundColor: Colors.blueGrey,
                backgroundImage: NetworkImage(imagePath , scale: 1.0),
              ),
              SizedBox(width: 16.0),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    name,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 18.0,
                    ),
                  ),
                  // Add other details here, e.g., date for the third card
                ],
              ),
            ],
          ),
        ),
        // Add the barcode and additional data/function placeholders here
      ],
    ),
  );
}

// // ... (imports and MyApp class remain the same)
//
// class MyApp extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       home: Scaffold(
//         appBar: AppBar(
//           title: Text('Card Example'),
//         ),
//         body: SingleChildScrollView(
//           padding: EdgeInsets.all(16.0),
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.stretch,
//             children: [
//               buildCard("SE391 - Fall 2023", "Dr. Nada Sherief", Colors.teal, Colors.yellow, 'assets/nada_sherief.jpg'),
//               SizedBox(height: 16.0),
//               buildCard("Professional Training", "Mohamed Abozaid", Colors.green, Colors.green, 'assets/mohamed_abozaid.jpg'),
//               SizedBox(height: 16.0),
//               buildCard("Marketing Section", "Youssef Alaeldin", Colors.purple, Colors.purple, 'assets/youssef_alaeldin.jpg'),
//               SizedBox(height: 16.0),
//               buildCard("PM – Fall 2023", "Dr. Hagar Hussein", Colors.blue, Colors.blue, 'assets/hagar_hussein.jpg'),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
//
//   Widget buildCard(String title, String name, Color stripeColor, Color borderColor, String imagePath) {
//     return Card(
//       elevation: 4.0,
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.stretch,
//         children: [
//           Container(
//             color: stripeColor,
//             padding: EdgeInsets.all(8.0),
//             child: Text(
//               title,
//               textAlign: TextAlign.center,
//               style: TextStyle(
//                 color: Colors.white,
//                 fontWeight: FontWeight.bold,
//               ),
//             ),
//           ),
//           Padding(
//             padding: EdgeInsets.all(16.0),
//             child: Row(
//               children: [
//                 CircleAvatar(
//                   radius: 40.0,
//                   backgroundColor: Colors.transparent,
//                   backgroundImage: AssetImage(imagePath),
//                 ),
//                 SizedBox(width: 16.0),
//                 Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     Text(
//                       name,
//                       style: TextStyle(
//                         fontWeight: FontWeight.bold,
//                         fontSize: 18.0,
//                       ),
//                     ),
//                     // Add other details here, e.g., date for the third card
//                   ],
//                 ),
//               ],
//             ),
//           ),
//           // Add the barcode and additional data/function placeholders here
//         ],
//       ),
//     );
//   }
// }

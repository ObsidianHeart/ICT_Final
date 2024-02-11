import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:icthub/user_data_model.dart';
import "package:icthub/Screens/signup_screen.dart";




class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});


  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {

  String uid = FirebaseAuth.instance.currentUser!.uid;
  String _name = "";
  String _email = "";
  String _phoneNo = "";
  User? user = FirebaseAuth.instance.currentUser!;

  @override
  void initState() {
    var db = FirebaseFirestore.instance;
    final docRef1 = db.collection("users").doc(uid);
    docRef1.get().then((value) {
      print(value.data());
      setState(() {
        _name = value.data()?['name'];
        _email = value.data()?['email'];
        _phoneNo= value.data()?['phoneNo'];
        uid = value.data()?['uid'];

      });
    });

    super.initState();
    //getUserData();
  }

  //UserDataModel userDataModel = UserDataModel(name: _name, email: _email, uid: uid, phoneNo: _phoneNo);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical:100.0),
        child: Center(
          child: buildCard(
              "Profile", _name  , _phoneNo , _email , Colors.teal), //line 42
        ),
      ),
    );
  }
}

Widget buildCard(
    String title, String name , String phone , String email, Color stripeColor) {
  return Card(
    elevation: 4.0,
    child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
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
                //backgroundImage: AssetImage(imagePath),
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
                  Text(
                    email,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 18.0,
                    ),
                  ),
                  Text(
                    phone,
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


// Future<void> getUserDataFromFireStoreDataBase() async {
//   try {
//
//     String uid = FirebaseAuth.instance.currentUser!.uid;
//
//     await FirebaseFirestore.instance
//         .collection('users')
//         .doc(uid)
//         .get()
//         .then((value) {
//        UserDataModel.fromDoc(value);
//     });
//   } catch (error) {
//     'Error: $error';
//   }
// }



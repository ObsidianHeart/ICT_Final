import 'package:flutter/material.dart';
import 'package:icthub/Screens/mainpage_screen.dart';
import 'package:icthub/Screens/profilepage_screen.dart';

class HomeApp extends StatefulWidget {
  const HomeApp({super.key});

  @override
  State<HomeApp> createState() => _HomeAppState();
}

class _HomeAppState extends State<HomeApp> {
  int cIndx = 0;

  List<Widget> low =
  [
    MainPage() , ProfilePage()
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomNavigationBar(
        items: [
          BottomNavigationBarItem(icon:
          Icon(Icons.home_outlined) ,
            label: "Home" ,
          ),
          BottomNavigationBarItem(icon:
          Icon(Icons.perm_identity) ,
            label: "Profile" ,
          ),

        ],
        fixedColor: Colors.black,
        unselectedItemColor: Colors.blueAccent,
        currentIndex: cIndx,
        onTap: (index){
          setState(() {
            print(index);
            cIndx = index;
          });

        },
      ),
      body: IndexedStack(
        children: low,
        index: cIndx,
      ),
    );
  }
}

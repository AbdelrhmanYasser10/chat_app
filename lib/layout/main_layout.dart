import 'package:chat_application_it/screens/home_screen.dart';
import 'package:flutter/material.dart';

import '../screens/contact_screen.dart';
import '../screens/profile_screen.dart';
import '../shared/cubits/app_cubit/app_cubit.dart';

class MainLayout extends StatefulWidget {
  const MainLayout({Key? key}) : super(key: key);

  @override
  State<MainLayout> createState() => _MainLayoutState();
}

class _MainLayoutState extends State<MainLayout> with WidgetsBindingObserver {

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
  }

  @override
  void dispose() {
    super.dispose();
    WidgetsBinding.instance.removeObserver(this);
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    //paused , inactive , detached (Background)
    if(state == AppLifecycleState.paused
        || state == AppLifecycleState.inactive
        || state == AppLifecycleState.detached){
      //set current user offline
      AppCubit.get(context).setUserOffline();
    }
    else{
      //set current user online
      AppCubit.get(context).setUserOnline();
    }
  }



  int _currentIdx = 0;

  List<Widget >screens = const [
    HomeScreen(),
    ContactScreen(),
    ProfileScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIdx,
        onTap: (index){
          setState(() {
            _currentIdx = index;
          });
        },
        items: const [
          BottomNavigationBarItem(
              icon:Icon(
                Icons.home,
              ) ,
            label: "Home"
          ),
          BottomNavigationBarItem(
              icon:Icon(
                Icons.phone,
              ) ,
            label: "Contacts"
          ),
          BottomNavigationBarItem(
              icon:Icon(
                Icons.person,
              ) ,
            label: "Profile"
          ),
        ],
      ),
      body: screens[_currentIdx],
    );
  }
}

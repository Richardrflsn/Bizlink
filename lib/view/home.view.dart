import 'package:bizlink/providers/auth.provider.dart';
import 'package:bizlink/view/intro.view.dart';
import 'package:flutter/material.dart';
import 'package:bizlink/utils/global.colors.dart';
import 'package:geolocator/geolocator.dart';
import 'package:geocoding/geocoding.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  _HomeViewState createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  String _location = "Getting location...";

  Future<void> _checkAndRequestPermission() async {
    LocationPermission permission = await Geolocator.checkPermission();

    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
    }

    if (permission == LocationPermission.whileInUse || permission == LocationPermission.always) {
      _getLocation();
    } else {
      setState(() {
        _location = "Permission Denied";
      });
    }
  }

  Future<void> _getLocation() async {
    try {
      Position position = await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
      List<Placemark> placemarks = await placemarkFromCoordinates(position.latitude, position.longitude);

      if (placemarks.isNotEmpty) {
        Placemark place = placemarks[0];
        setState(() {
          _location = "${place.name}, ${place.locality}, ${place.country}";
        });
      }
    } catch (e) {
      setState(() {
        _location = "Error getting location";
      });
    }
  }

  @override
  void initState() {
    super.initState();
    _checkAndRequestPermission();
  }

  void logout(BuildContext context) {
    final auth = AuthService();
    auth.signOut(context);

    Navigator.pushReplacement(
      context,
      PageRouteBuilder(
        pageBuilder: (context, animation, secondaryAnimation) => const IntroView(),
        transitionsBuilder: (context, animation, secondaryAnimation, child) {
          var fadeAnimation = Tween(begin: 0.0, end: 1.0).animate(animation);
          return FadeTransition(opacity: fadeAnimation, child: child);
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final user = AuthService().currentUser;
    final String userEmail = user?.email ?? "User";
    final String userName = userEmail.split('@')[0];

    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [GlobalColors.secondaryColor, GlobalColors.neutralColor],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Welcome, $userName!',
                        style: const TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                      ),
                      Row(
                        children: [
                          IconButton(
                            icon: Image.asset('assets/images/buttonIcons/notification.png', width: 40, height: 40),
                            onPressed: () => print("Notification Icon Clicked"),
                          ),
                          IconButton(
                            icon: Image.asset('assets/images/buttonIcons/businessIconButton.png', width: 40, height: 40),
                            onPressed: () => print("Shop Owner Icon Clicked"),
                          ),
                        ],
                      ),
                    ],
                  ),
                  const SizedBox(height: 2),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Image.asset('assets/images/location.png', width: 35, height: 35),
                      const SizedBox(width: 8),
                      Expanded(
                        child: Text(
                          _location,
                          style: const TextStyle(fontSize: 16, color: Colors.black87, fontFamily: 'SFProDisplay'),
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        'What did you\nwant to eat today?',
                        style: TextStyle(fontSize: 24, color: Colors.black, fontWeight: FontWeight.bold),
                      ),
                      Image.asset('assets/images/homeMaru.png', width: 70, height: 70),
                    ],
                  ),
                  const SizedBox(height: 18),
                  TextField(
                    decoration: InputDecoration(
                      hintText: 'Restaurant or food',
                      prefixIcon: Icon(Icons.search, color: Colors.black54),
                      filled: true,
                      fillColor: Colors.white,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: BorderSide(color: Colors.grey, width: 2),
                      ),
                    ),
                  ),
                  const SizedBox(height: 40),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: () => print("button manage orders clicked"),
                      style: ElevatedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(vertical: 14),
                        backgroundColor: GlobalColors.primaryColor,
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                      ),
                      child: const Text('Manage Orders', style: TextStyle(fontSize: 18, color: Colors.white)),
                    ),
                  ),
                  const SizedBox(height: 20),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: () => logout(context),
                      style: ElevatedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(vertical: 14),
                        backgroundColor: GlobalColors.secondaryColor,
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                      ),
                      child: const Text('Signout', style: TextStyle(fontSize: 18, color: Colors.black)),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

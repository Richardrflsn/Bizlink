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

  // Function to check and request location permission
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

  // Function to get user's current location and convert Lat & Lon to address
  Future<void> _getLocation() async {
    try {
      Position position = await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
      List<Placemark> placemarks = await placemarkFromCoordinates(position.latitude, position.longitude);

      if (placemarks.isNotEmpty) {
        // Get the first placemark and extract address information
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
    _checkAndRequestPermission(); // Request permission on initial load
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
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Row for Welcome Text and Icons
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    // Welcome Text
                    Text(
                      'Welcome, $userName!',
                      style: const TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    ),
                    // Row for Custom Image Icons
                    Row(
                      children: [
                        // Notification Icon
                        IconButton(
                          icon: Image.asset(
                            'assets/images/buttonIcons/notification.png',
                            width: 40,
                            height: 40,
                          ),
                          onPressed: () {
                            print("Notification Icon Clicked");
                          },
                        ),
                        // Shop Owner Icon
                        IconButton(
                          icon: Image.asset(
                            'assets/images/buttonIcons/businessIconButton.png',
                            width: 40,
                            height: 40,
                          ),
                          onPressed: () {
                            print("Shop Owner Icon Clicked");
                          },
                        ),
                        const SizedBox(width: 8),
                      ],
                    ),
                  ],
                ),
                const SizedBox(height: 2),
                // Location Section
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    // Custom location icon from assets
                    Image.asset(
                      'assets/images/location.png',
                      width: 35,
                      height: 35,
                    ),
                    const SizedBox(width: 8),
                    // Location display text or input field
                    if (_location == "Getting location..." || _location == "Permission Denied")
                      Text(
                        _location,
                        style: const TextStyle(
                          fontSize: 16,
                          color: Colors.black87,
                          fontFamily: 'SFProDisplay',
                        ),
                      )
                    else
                      Expanded(
                        child: Text(
                          _location,
                          style: const TextStyle(
                            fontSize: 16,
                            color: Colors.black87,
                            fontFamily: 'SFProDisplay',
                          ),
                          overflow: TextOverflow.ellipsis, // Handle overflow with ellipsis
                        ),
                      ),
                  ],
                ),
                const SizedBox(height: 16),
                // "What did you want to eat today?" Section
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'What did you\nwant to eat today?',
                      style: const TextStyle(
                        fontSize: 24,
                        color: Colors.black,
                        fontFamily: 'SFProDisplay',
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Image.asset(
                      'assets/images/homeMaru.png',
                      width: 70,
                      height: 70,
                    ),
                  ],
                ),
                const SizedBox(height: 18),
                // Search Bar Section
                TextField(
                  decoration: InputDecoration(
                    hintText: 'Restaurant or food',
                    hintStyle: const TextStyle(fontSize: 16, color: Colors.black54),
                    prefixIcon: Icon(
                      Icons.search,
                      color: Colors.black54,
                    ),
                    filled: true,
                    fillColor: Colors.white,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: BorderSide(color: Colors.grey, width: 2,),
                    ),
                  ),
                ),
                const SizedBox(height: 20),

                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                        'Top Categories',
                        style: const TextStyle(
                          fontSize: 20,
                          color: Colors.black,
                          fontFamily: 'SFProDisplay',
                          fontWeight: FontWeight.bold,
                        ),
                    ),
                    GestureDetector(
                      onTap: (){
                        print('View All clicked');
                      },
                      child: Text(
                          'View All',
                        style: TextStyle(
                          fontSize: 16,
                          fontFamily: 'SFProDisplay',
                          color: GlobalColors.primaryColor,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    )
                  ],
                ),
                const SizedBox(height: 16,),
                const Text(
                  'Manage your F&B orders and payments easily',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                    color: Colors.black54,
                  ),
                ),
                const SizedBox(height: 40),
                // Manage Orders Button
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () {
                      print("button manage orders clicked");
                    },
                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(vertical: 14),
                      backgroundColor: GlobalColors.primaryColor,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    child: const Text(
                      'Manage Orders',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                // Sign Out Button
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () {
                      logout(context);
                    },
                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(vertical: 14),
                      backgroundColor: GlobalColors.secondaryColor,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    child: const Text(
                      'Signout',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';

import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:news/Screen/aerobic_screen.dart';
import 'package:news/model/gymelist_model.dart';
import 'package:news/view_model/activities_viewmodel.dart';
import 'package:news/view_model/gym_viewmodel.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late GoogleMapController mapController;

  bool _isLocationPermissionGranted = false;

  @override
  void initState() {
    super.initState();
    _requestLocationPermission();
  }

  Future<void> _requestLocationPermission() async {
    final status = await Permission.location.request();
    if (status.isGranted) {
      setState(() {
        _isLocationPermissionGranted = true;
      });
    } else if (status.isDenied) {
    } else if (status.isPermanentlyDenied) {
      openAppSettings();
    }
  }

  @override
  Widget build(BuildContext context) {
    var fitness = Provider.of<FitnessModeProvider>(context);
    var activites = Provider.of<ActivitesProvider>(context);
    List<Data>? gymData = fitness.fitnessModel?.data;
    Set<Marker> markers = Set();

    if (gymData != null) {
      for (var gym in gymData) {
        if (gym.latitude != null && gym.longitude != null) {
          markers.add(
            Marker(
              markerId: MarkerId(gym.gymId.toString()),
              position: LatLng(
                  double.parse(gym.latitude!), double.parse(gym.longitude!)),
              infoWindow: InfoWindow(title: gym.gymName ?? 'Gym'),
            ),
          );
        }
      }
    }
    return SafeArea(
      child: Scaffold(
        backgroundColor: const Color.fromARGB(221, 58, 57, 57),
        body: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Padding(
                //   padding: const EdgeInsets.all(8.0),
                //   child: Container(
                //     width: MediaQuery.sizeOf(context).width * 2,
                //     height: MediaQuery.sizeOf(context).height * 0.05,
                //     decoration: BoxDecoration(
                //       color: Colors.black38,
                //       borderRadius: BorderRadius.circular(5.0),
                //       border: Border.all(color: Colors.white, width: 1.0),
                //     ),
                //   ),
                // ),
                const Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Text(
                    "FITNESS LOCATION FOR YOU",
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                SizedBox(
                  height: 200,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount:
                        fitness.fitnessModel?.data?.first.gymImages2?.length ??
                            0,
                    itemBuilder: (context, index) {
                      String image =
                          fitness.fitnessModel!.data!.first.gymImages2![index];
                      String gymName =
                          fitness.fitnessModel!.data![index].gymName.toString();
                      return Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          children: [
                            ClipOval(
                              child: Image.network(
                                image,
                                fit: BoxFit.cover,
                                width: 100,
                                height: 100,
                              ),
                            ),
                            const SizedBox(height: 8),
                            Container(
                              height: 70,
                              decoration:
                                  const BoxDecoration(color: Colors.black38),
                              child: Padding(
                                padding: const EdgeInsets.all(16.0),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Image.network(
                                      image,
                                      height: 70,
                                    ),
                                    const SizedBox(
                                      width: 10,
                                    ),
                                    Text(
                                      gymName,
                                      textAlign: TextAlign.center,
                                      style: const TextStyle(
                                          color: Colors.white, fontSize: 12),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                ),
                const Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Text(
                    "ACTIVITES FOR YOU",
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                SizedBox(
                  height: 152,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: activites.activitesModel?.data?.length ?? 0,
                    itemBuilder: (context, index) {
                      String? image =
                          activites.activitesModel?.data?[index]?.icon;
                      String? name =
                          activites.activitesModel?.data?[index]?.name;
                      return Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          children: [
                            if (image != null)
                              GestureDetector(
                                onTap: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              const AerobicScreen()));
                                },
                                child: CircleAvatar(
                                  backgroundColor:
                                      const Color.fromARGB(66, 121, 119, 119),
                                  radius: 50,
                                  child: ClipOval(
                                    child: Image.network(
                                      image,
                                      fit: BoxFit.cover,
                                      color: Colors.white,
                                      width: 100,
                                      height: 100,
                                    ),
                                  ),
                                ),
                              ),
                            const SizedBox(
                              height: 10,
                            ),
                            if (name != null)
                              Text(
                                name,
                                style: const TextStyle(
                                    color: Colors.white, fontSize: 12),
                              ),
                            const SizedBox(height: 8),
                          ],
                        ),
                      );
                    },
                  ),
                ),
                const Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Text(
                    "AROUND YOU",
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                if (_isLocationPermissionGranted)
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: SizedBox(
                      height: 200,
                      child: GoogleMap(
                        initialCameraPosition: const CameraPosition(
                          target: LatLng(28.583745, 77.3155413),
                          zoom: 10,
                        ),
                        markers: markers,
                        onMapCreated: (GoogleMapController controller) {
                          mapController = controller;
                        },
                      ),
                    ),
                  ),

                if (!_isLocationPermissionGranted)
                  const Text(
                    'Location permission is required to display the map.',
                    style: TextStyle(color: Colors.white),
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

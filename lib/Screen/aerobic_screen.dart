import 'package:flutter/material.dart';

import 'package:news/view_model/exsersise_viewmodel.dart';
import 'package:provider/provider.dart';

class AerobicScreen extends StatefulWidget {
  const AerobicScreen({Key? key}) : super(key: key);

  @override
  State<AerobicScreen> createState() => _AerobicScreenState();
}

class _AerobicScreenState extends State<AerobicScreen> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Color.fromARGB(221, 219, 215, 215),
        appBar: AppBar(
          backgroundColor: Colors.black,
          title: const Text(
            "Aerobic Exercise",
            style: TextStyle(color: Colors.red),
          ),
          iconTheme: const IconThemeData(color: Colors.red),
        ),
        body: Consumer<ExcersisProvider>(
          builder: (context, excersisProvider, _) {
            if (excersisProvider.excersiseModel == null) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }

            if (excersisProvider.excersiseModel!.status == false) {
              return const Center(
                child: Text(
                  'Failed to fetch data. Please try again later.',
                  style: TextStyle(color: Colors.red),
                ),
              );
            }

            return ListView.builder(
              itemCount: excersisProvider.excersiseModel!.data!.length,
              itemBuilder: (context, index) {
                final gym = excersisProvider.excersiseModel!.data![index];
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    height: 200,
                    margin: const EdgeInsets.symmetric(vertical: 8.0),
                    decoration: BoxDecoration(
                      color: Colors.black87,
                      borderRadius: BorderRadius.circular(7),
                    ),
                    child: Row(
                      children: [
                        Expanded(
                          flex: 1,
                          child: Image.network(
                            gym.imgPath ?? "",
                            errorBuilder: (context, error, stackTrace) {
                              return const Icon(
                                Icons.error_outline,
                                color: Colors.red,
                                size: 48,
                              );
                            },
                          ),
                        ),
                        Expanded(
                          flex: 2,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                gym.gymName ?? "",
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              const SizedBox(height: 8),
                              Text(
                                gym.address ?? "",
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 14,
                                ),
                              ),
                              const SizedBox(height: 8),
                              Text(
                                "Open: ${gym.open ?? ""}",
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 14,
                                ),
                              ),
                              const SizedBox(height: 8),
                              Text(
                                "Rating: ${gym.rating ?? ""}",
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 14,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            );
          },
        ),
      ),
    );
  }
}

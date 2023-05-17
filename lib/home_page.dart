// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'doctor_details_page.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final List<Map<String, String>> doctors = [
    {
      'name': 'Dr. John Doe',
      'address': '123 Main St',
      'specialty': 'Cardiology',
    },
    {
      'name': 'Dr. Jane Smith',
      'address': '456 Park Ave',
      'specialty': 'Pediatrics',
    },
    {
      'name': 'Dr. Mokhtar Najjar',
      'address': '789 Ariana St Hedi Nouira',
      'specialty': 'Dermatology',
    },
    {
      'name': 'Dr. Sarah Lee',
      'address': '321 Oak St',
      'specialty': 'Oncology',
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
      body: Column(
        children: [
          Container(
            padding: EdgeInsets.all(16),
            child: TextField(
              decoration: InputDecoration(
                contentPadding:
                    EdgeInsets.symmetric(vertical: 16, horizontal: 16),
                filled: true,
                fillColor: Colors.white,
                hintText: 'Search',
                prefixIcon: Icon(Icons.search),
              ),
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: doctors.length,
              itemBuilder: (context, index) {
                return InkWell(
                  onTap: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => DoctorDetailsPage(
                          name: doctors[index]['name']!,
                          profileInfo: ProfileInfo(
                              specialty: doctors[index]['specialty']!,
                              name: doctors[index]['name']!,
                              city: "Araian mnihla",
                              country: "Tunisia",
                              state: "Tunis",
                              address: "Nasr street 5705"),
                          specialty: doctors[index]['specialty']!,
                          imageUrl:
                              "https://static.wikia.nocookie.net/onepiece/images/e/e6/Tony_Tony_Chopper_Anime_Pre_Timeskip_Infobox.png/revision/latest?cb=20160207143020",
                          education: doctors[index]['specialty']!,
                          experience: doctors[index]['specialty']!,
                          awards: doctors[index]['specialty']!,
                        ),
                      ),
                    );
                  },
                  child: Card(
                    child: ListTile(
                      title: Text(doctors[index]['name']!),
                      subtitle: Text(doctors[index]['address']!),
                      trailing: Text(doctors[index]['specialty']!),
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

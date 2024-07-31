import 'dart:convert';
import 'package:flutter/widgets.dart';
import 'package:intl/intl.dart';
import 'package:flutter/material.dart';
import '/pages/profileedit_page.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text(
            'Profile',
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: 26,
            ),
          ),
          centerTitle: true,
          backgroundColor: const Color.fromARGB(255, 167, 233, 226),
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              children: [
                const SizedBox(height: 40),
                CircleAvatar(
                  radius: 70,
                  backgroundImage: AssetImage('assets/__login_image.png'),
                ),
                const SizedBox(height: 20),
                itemProfile('Name', 'Anne Perera', Icons.person),
                const SizedBox(height: 10),
                itemProfile('Role', 'Parent', Icons.person),
                const SizedBox(height: 10),
                itemProfile('Phone', '0310708581', Icons.phone),
                const SizedBox(height: 10),
                itemProfile('Address', '#425, Main Street, Negombo.',
                    Icons.location_city),
                const SizedBox(height: 10),
                itemProfile('Email', 'anne_p@gmail.com', Icons.mail),
                const SizedBox(height: 10),
                itemProfile('Area', 'Negombo', Icons.location_on),
                const SizedBox(height: 10),
                itemProfile('Child Name', 'Arla', Icons.location_on),
                const SizedBox(height: 10),
                itemProfile('Birthday', '2022-01-01', Icons.location_on),
                const SizedBox(height: 10),
                itemProfile('Gender', 'Female', Icons.face),
                const SizedBox(
                  height: 20,
                ),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const ProfileEditPage()),
                        );
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Color.fromARGB(255, 143, 239, 230),
                        padding: const EdgeInsets.all(15),
                      ),
                      child: const Text(
                        'Edit Profile',
                        style: TextStyle(color: Colors.white, fontSize: 18),
                      )),
                )
              ],
            ),
          ),
        ));
  }
}

itemProfile(String title, String subtitle, IconData iconData) {
  return Container(
    decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
              offset: Offset(0, 5),
              color: Color.fromARGB(95, 135, 211, 205).withOpacity(.2),
              spreadRadius: 2,
              blurRadius: 10)
        ]),
    child: ListTile(
      title: Text(title),
      subtitle: Text(subtitle),
      leading: Icon(iconData),
    ),
  );
}

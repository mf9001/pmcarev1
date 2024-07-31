import 'dart:convert';
import 'package:flutter/widgets.dart';
import 'package:intl/intl.dart';
import 'package:flutter/material.dart';

class ProfileEditPage extends StatefulWidget {
  const ProfileEditPage({super.key});

  @override
  State<ProfileEditPage> createState() => _ProfileEditPageState();
}

class _ProfileEditPageState extends State<ProfileEditPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text(
            'Edit Profile',
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
                itemProfile('Name', 'Anne Perera', Icons.person),
                //// Role set by admin Default = Parent
                const SizedBox(height: 10),
                itemProfile('Phone', '0310708581', Icons.phone),
                const SizedBox(height: 10),
                itemProfile('Address', '#425, Main Street, Negombo.',
                    Icons.location_city),
                const SizedBox(height: 10),
                ////Emmail cannot be changed as it is the username
                ////Area is auto set based on the address
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
                      onPressed: () {},
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Color.fromARGB(255, 143, 239, 230),
                        padding: const EdgeInsets.all(15),
                      ),
                      child: const Text(
                        'Save Edited Profile',
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
      subtitle: TextFormField(
        initialValue: subtitle,
      ),
      leading: Icon(iconData),
    ),
  );
}

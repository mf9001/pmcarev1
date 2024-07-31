import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import '../model/post.dart';
import '/pages/menu_page.dart';

class SchListpage extends StatelessWidget {
  List<Post> posts = [];

  // get teams
  Future getPosts() async {
    posts = [];
    var response = await http
        .get(Uri.http('10.0.2.2:5000', 'schedule/new_appointment/Negombo'));

    var jsonData = jsonDecode(response.body);

    print('jsonData' + jsonData.toString());

    for (var eachPost in jsonData) {
      final post = Post(
          id: eachPost['id'],
          mwfid: eachPost['mwfid'],
          mwfname: eachPost['mwfname'],
          date: eachPost['date'],
          serialdate: eachPost['serialdate']);
      posts.add(post);
    }
  }

  Future<void> _showMyDialog(context) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Slot Confirmed'),
          content: const SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Text('Your selected slot has been confirmed !'),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: const Text('OK'),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => MenuPage()),
                );
              },
            ),
          ],
        );
      },
    );
  }

  //confirm
  Future confirmDate(context, mid, mdate) async {
    print("mid, mdate" + mid + mdate);

    String server_call = mid + "/" + mdate + "/1/P555";

    var response = await http
        .get(Uri.http('10.0.2.2:5000', '/schedule/cofirm_app/' + server_call));

    //var jsonData = jsonDecode(response.body);
    print("confirm" + response.body);

    await _showMyDialog(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: FutureBuilder(
            future: getPosts(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.done) {
                return ListView.builder(
                  itemCount: posts.length,
                  padding: const EdgeInsets.all(8),
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                        decoration: BoxDecoration(
                          color: const Color.fromARGB(255, 167, 233, 226),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: ListTile(
                          leading: const Icon(Icons.calendar_month,
                              size: 50, color: Colors.black87),
                          title: Text(posts[index].mwfname),
                          subtitle: Text(posts[index].date),
                          trailing: IconButton(
                              onPressed: () {
                                confirmDate(context, posts[index].mwfid,
                                    posts[index].serialdate);
                              },
                              icon: const Icon(Icons.add_circle)),
                          onTap: () {},
                        ),
                      ),
                    );
                  },
                );
              } else {
                return const Center(child: CircularProgressIndicator());
              }
            }),
      ),
    );
  }
}

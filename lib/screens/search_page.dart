import 'package:HintMe/components/avatar.dart';
import 'package:HintMe/screens/home.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({Key? key}) : super(key: key);

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  String name = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 39, 36, 36),
      appBar: AppBar(
          backgroundColor: const Color.fromARGB(255, 39, 36, 36),
          elevation: 0,
          title: Card(
            color: Color.fromRGBO(49, 45, 45, 1),
            child: TextField(
              decoration: InputDecoration(
                  prefixIcon: Icon(
                    Icons.search,
                    color: Colors.white,
                  ),
                  hintText: 'Search...',
                  hintStyle: TextStyle(color: Colors.white54)),
              style: TextStyle(color: Colors.white),
              onChanged: (val) {
                setState(() {
                  name = val;
                });
              },
            ),
          )),
      body: StreamBuilder<QuerySnapshot>(
          stream: FirebaseFirestore.instance.collection('users').snapshots(),
          builder: (context, snapshots) {
            return (snapshots.connectionState == ConnectionState.waiting)
                ? Center(
                    child: CircularProgressIndicator(),
                  )
                : ListView.builder(
                    itemCount: snapshots.data!.docs.length,
                    itemBuilder: (context, index) {
                      var data = snapshots.data!.docs[index].data()
                          as Map<String, dynamic>;

                      if (name.isEmpty) {
                        return Column(
                          children: [
                            ListTile(
                                title: Text(
                                  "@${data['user']}",
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold),
                                ),
                                subtitle: Text(
                                  data['name'],
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                  style: TextStyle(
                                      color: Colors.white54,
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold),
                                ),
                                leading: Avatar(
                                    action: HomePage(),
                                    border: true,
                                    image:
                                        "https://cdn.pixabay.com/photo/2015/08/05/04/25/people-875617_960_720.jpg",
                                    size: 7.h)),
                            Divider(
                              color: Colors.white,
                            )
                          ],
                        );
                      }
                      if (data['user']
                              .toString()
                              .toLowerCase()
                              .startsWith(name.toLowerCase()) ||
                          data['name']
                              .toString()
                              .toLowerCase()
                              .contains(name.toLowerCase())) {
                        return Column(
                          children: [
                            ListTile(
                                title: Text(
                                  "@${data['user']}",
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold),
                                ),
                                subtitle: Text(
                                  data['name'],
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                  style: TextStyle(
                                      color: Colors.white54,
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold),
                                ),
                                leading: Avatar(
                                    action: HomePage(),
                                    border: true,
                                    image:
                                        "https://cdn.pixabay.com/photo/2015/08/05/04/25/people-875617_960_720.jpg",
                                    size: 7.h)),
                            Divider(
                              color: Colors.white,
                            )
                          ],
                        );
                      }
                      return Container();
                    });
          }),
    );
  }
}

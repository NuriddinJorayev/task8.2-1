import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:pattern_setstate/models/post_model.dart';
import 'package:pattern_setstate/pages/create_post_page.dart';
import 'package:pattern_setstate/pages/update_post_page.dart';
import 'package:pattern_setstate/services/functions/create_delete_add.dart';
import 'package:pattern_setstate/services/http_server.dart';

class Home extends StatefulWidget {
  static final String id = "home_page";
  Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  Future<List<Post>>? future;

  @override
  void initState() {
    super.initState();
    initialize_future();
  }

  initialize_future() {
    setState(() {
      future = Rest_APi.GET_parsed_list(Rest_APi.API_GET);
    });
  }

  @override
  Widget build(BuildContext context) {
    var h = MediaQuery.of(context).size.height;
    var w = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text("setState"),
      ),
      body: Container(
        height: h,
        width: w,
        decoration: BoxDecoration(
            image: DecorationImage(
                image: NetworkImage(
                    "https://i.pinimg.com/originals/4b/f2/b3/4bf2b361a67b3030b185fd7447b279b5.jpg"),
                fit: BoxFit.fill)),
        child: FutureBuilder<List<Post>>(
          future: future,
          builder: (BuildContext context, snp) {
            if (snp.connectionState == ConnectionState.done) {
              return ListView.builder(
                itemCount: snp.data!.length,
                itemBuilder: (BuildContext context, int index) {
                  return items_builder(snp.data![index]);
                },
              );
            } else if (snp.connectionState == ConnectionState.waiting) {
              return Container(
                height: h,
                width: w,
                color: Colors.black.withOpacity(.4),
                child: Container(
                  height: 60,
                  width: 60,
                  alignment: Alignment.center,
                  child: CircularProgressIndicator(),
                ),
              );
            }
            return Container();
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.pushNamed(context, Create_post.id).then((value) {
            if (value != null) {
              initialize_future();
            }
            FocusScope.of(context).requestFocus(FocusNode());
          });
        },
        child: Icon(Icons.add),
      ),
    );
  }

  Widget items_builder(Post p) => Slidable(
        child: Card(
          margin: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
          child: Container(
            padding: EdgeInsets.all(20),
            width: double.infinity,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text(
                  p.title,
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 16,
                      fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 5),
                Text(
                  p.body,
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 14,
                      fontWeight: FontWeight.normal),
                ),
              ],
            ),
          ),
        ),
        startActionPane: ActionPane(
            extentRatio: .25,
            motion: const ScrollMotion(),
            children: [
              SlidableAction(
                // Edite function
                onPressed: (BuildContext con) {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (_) => Update_post(post: p))).then((value) {
                    FocusScope.of(context).requestFocus(FocusNode());
                  });
                },
                backgroundColor: Colors.blue,
                foregroundColor: Colors.white,
                icon: Icons.edit,
                label: 'Edite',
              ),
            ]),
        endActionPane: ActionPane(
            extentRatio: .25,
            motion: const ScrollMotion(),
            children: [
              SlidableAction(
                // delete function
                onPressed: (BuildContext con) {
                  Create_delete_add_function.Delete(p).then((value) {
                    if (value.isNotEmpty) {
                      initialize_future();
                    }
                  });
                },
                backgroundColor: Color(0xFFFE4A49),
                foregroundColor: Colors.white,
                icon: Icons.delete,
                label: 'Delete',
              ),
            ]),
      );
}

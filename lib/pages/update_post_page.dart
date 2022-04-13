import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:pattern_setstate/models/post_model.dart';
import 'package:pattern_setstate/services/functions/create_delete_add.dart';
import 'package:pattern_setstate/services/http_server.dart';
import 'package:pattern_setstate/widgets/text_field.dart';

class Update_post extends StatefulWidget {
  Post post;
  static final String id = "update_post";
  Update_post({Key? key, required this.post}) : super(key: key);

  @override
  State<Update_post> createState() => _Update_postState();
}

class _Update_postState extends State<Update_post> {
  bool isloading = false;
  var control1 = TextEditingController();
  var control2 = TextEditingController();
  Post? post;
  @override
  void initState() {
    post = widget.post;
    control1.text = widget.post.title;
    control2.text = widget.post.body;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var h = MediaQuery.of(context).size.height;
    var w = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text("Update Post"),
      ),
      body: SingleChildScrollView(
        child: Stack(
          children: [
            Container(
              height: h,
              width: w,
              child: Column(
                children: [
                  SizedBox(height: 20),
                  Text_Field.Create_textFiled("Title", control1, 3),
                  Text_Field.Create_textFiled("Body", control2, 6),
                ],
              ),
            ),
            isloading
                ? Container(
                    height: h,
                    width: w,
                    color: Colors.black.withOpacity(.4),
                    child: Container(
                      height: 60,
                      width: 60,
                      alignment: Alignment.center,
                      child: CircularProgressIndicator(),
                    ),
                  )
                : SizedBox.shrink()
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          FocusScope.of(context).requestFocus(FocusNode());
          var text1 = control1.text.trim();
          var text2 = control2.text.trim();
          if (text1.isNotEmpty && text2.isNotEmpty) {
            setState(() => isloading = true);
            post!.title = text1;
            post!.body = text2;
            await Create_delete_add_function.Update(post!);
            setState(() => isloading = false);
            Navigator.pop(context, "new_post");
          } else {
            var message = (text1.isEmpty && text2.isEmpty)
                ? "Title and Body"
                : text1.isEmpty
                    ? "Title"
                    : "Body";
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(
                  message + " are empty",
                  style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      letterSpacing: .5),
                ),
                action: SnackBarAction(
                  label: 'Exit',
                  onPressed: () {
                    Navigator.pop(context);
                  },
                ),
              ),
            );
          }
        },
        child: Icon(Icons.update),
      ),
    );
  }
}

import 'dart:convert';

import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_stars/flutter_rating_stars.dart';
import 'package:http/http.dart' as http;

import 'menu.dart';


class RatingScreen extends StatefulWidget {
  const RatingScreen({super.key});
  @override
  _RatingScreenState createState() => _RatingScreenState();

}
class _RatingScreenState extends State<RatingScreen> {
  TextEditingController comment = TextEditingController();
  TextEditingController username = TextEditingController();
  double value = 3.5;

  List<Map<String, dynamic>> dynamicdata = [];
  // Future<void> getData() async {
  //   final url = Uri.parse(
  //       "http://mybudgetbook.in/BUDGETAPI/profile.php?table=signup&id=${widget.uid}");
  //   final response = await http.get(url);
  //   print("URL: $url");
  //
  //   if (response.statusCode == 200) {
  //     print("Response Status: ${response.statusCode}");
  //     print("Response Body: ${response.body}");
  //     final data = jsonDecode(response.body);
  //     print("Data: $data");
  //
  //     setState(() {
  //       dynamicdata = data.cast<Map<String, dynamic>>();
  //       if (dynamicdata.isNotEmpty) {
  //         setState(() {
  //           // Check if fields are null or empty before assigning them
  //           if (dynamicdata[0]['name'] != null &&
  //               dynamicdata[0]['name'] != '') {
  //             username.text = dynamicdata[0]['name'];
  //           }
  //           print("my name is ${username.text}");
  //         });
  //       }
  //     });
  //   } else {
  //     print('Failed to load data');
  //   }
  // }

  Future<void> addTrip() async {
    try {
      final url = Uri.parse('http://mybudgetbook.in/BUDGETAPI/feedback.php');

      final response = await http.post(
        url,
        body: jsonEncode({
          //"uid": widget.uid,
          "name": username.text,
          "comment": comment.text,
          "star": value.toString(),
        }),
      );
      if (response.statusCode == 200) {
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
            content: Text("Feedback Added")));
        print("feedback added successfully!");
        Navigator.push(
          context,MaterialPageRoute(builder: (context) => MenuScreen()),
        );
      } else {
        print("Error: ${response.reasonPhrase}");
      }
    } catch (e) {
      print("Error during trip addition: $e");
    }
  }
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  initState() {
    super.initState();
    //getData();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text(
          "Rate",
        ),
      ),
      body: Container(
        alignment: Alignment.center,
        //color: Colors.blueGrey,
        padding: EdgeInsets.all(36),

        child: Form(
          key: _formKey,
          child: Column(

            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(
                height: 100,
              ),
              RatingStars(
                axis: Axis.horizontal,
                value: value,
                onValueChanged: (v) {
                  //
                  setState(() {
                    value = v;
                  });
                },
                starCount: 5,
                starSize: 40,
                valueLabelColor: const Color(0xff9b9b9b),
                valueLabelTextStyle: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w400,
                    fontStyle: FontStyle.normal,
                    fontSize: 12.0),
                valueLabelRadius: 10,
                maxValue: 5,
                starSpacing: 2,
                maxValueVisibility: true,
                valueLabelVisibility: true,
                animationDuration: Duration(milliseconds: 1000),
                valueLabelPadding:
                const EdgeInsets.symmetric(vertical: 1, horizontal: 8),
                valueLabelMargin: const EdgeInsets.only(right: 8),
                starOffColor: const Color(0xffe7e8ea),
                starColor: Colors.yellow,
                angle: 12,
              ),
              SizedBox(
                height: 30,
              ),
              TextFormField(
                controller: comment,
                decoration: InputDecoration(
                  labelStyle: Theme.of(context).textTheme.bodySmall, //Theme.of(context).textTheme.labelMedium,
                  labelText: "Comment",
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0),

                  ),
                ),
                keyboardType: TextInputType.multiline,
                validator: (value) {
                  if (value!.isEmpty) {
                    return '*Please enter your comment';
                  }
                  return null;
                },

              ),
              SizedBox(
                height: 30,
              ),
              MaterialButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    addTrip();
                  }                },
                child: Text("Submit"),
                color: Colors.blue,
                textColor: Colors.white,
                minWidth: 400,
                height: 50,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                padding: EdgeInsets.all(0),
              )
            ],
          ),
        ),
      ),
    );
  }
}



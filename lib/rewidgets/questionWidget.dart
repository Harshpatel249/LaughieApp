import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

/*
* This is a reusable template for creating questions in feedback pages
*
* */
class QuestionWidget extends StatefulWidget {
  String question;
  var id;
  QuestionWidget({this.question, this.id});
  @override
  _QuestionWidgetState createState() =>
      _QuestionWidgetState(question: this.question, id: this.id);
}

class _QuestionWidgetState extends State<QuestionWidget> {
  String question; //The question string
  var id; //Unique identifier for the question
  int selected = 0;
  _QuestionWidgetState({this.id, this.question});
  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    final padding = mediaQuery.size.width * 0.05;
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding:
                EdgeInsets.only(left: padding, right: padding, bottom: padding),
            child: Text(
              this.question,
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(left: padding, right: padding * 1.2),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                IconButton(
                  onPressed: () {
                    setState(() {
                      selected = 1;
                    });
                  },
                  icon: Icon(
                    FontAwesomeIcons.frown,
                    size: 40,
                    color: selected == 1 ? Colors.redAccent : Colors.black45,
                  ),
                ),
                IconButton(
                  onPressed: () {
                    setState(() {
                      selected = 2;
                    });
                  },
                  icon: Icon(
                    FontAwesomeIcons.frownOpen,
                    size: 40,
                    color: selected == 2
                        ? Colors.deepOrangeAccent
                        : Colors.black45,
                  ),
                ),
                IconButton(
                  onPressed: () {
                    setState(() {
                      selected = 3;
                    });
                  },
                  icon: Icon(
                    FontAwesomeIcons.meh,
                    size: 40,
                    color: selected == 3 ? Color(0xfffbb313) : Colors.black45,
                  ),
                ),
                IconButton(
                  onPressed: () {
                    setState(() {
                      selected = 4;
                    });
                  },
                  icon: Icon(
                    FontAwesomeIcons.grin,
                    size: 40,
                    color: selected == 4 ? Colors.greenAccent : Colors.black45,
                  ),
                ),
                IconButton(
                  onPressed: () {
                    setState(() {
                      selected = 5;
                    });
                  },
                  icon: Icon(
                    FontAwesomeIcons.grinBeam,
                    size: 40,
                    color: selected == 5
                        ? Colors.lightGreenAccent
                        : Colors.black45,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

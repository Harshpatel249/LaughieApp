import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class QuestionWidget extends StatefulWidget {
  String question;
  var id;
  QuestionWidget({this.question, this.id});
  @override
  _QuestionWidgetState createState() =>
      _QuestionWidgetState(question: this.question, id: this.id);
}

class _QuestionWidgetState extends State<QuestionWidget> {
  String question;
  var id;
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
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
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
                    Icons.emoji_emotions_outlined,
                    size: 40,
                    color: selected == 1 ? Color(0xfffbb313) : Colors.black45,
                  ),
                ),
                IconButton(
                  onPressed: () {
                    setState(() {
                      selected = 2;
                    });
                  },
                  icon: Icon(
                    Icons.emoji_emotions_outlined,
                    size: 40,
                    color: selected == 2 ? Color(0xfffbb313) : Colors.black45,
                  ),
                ),
                IconButton(
                  onPressed: () {
                    setState(() {
                      selected = 3;
                    });
                  },
                  icon: Icon(
                    Icons.emoji_emotions_outlined,
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
                    Icons.emoji_emotions_outlined,
                    size: 40,
                    color: selected == 4 ? Color(0xfffbb313) : Colors.black45,
                  ),
                ),
                IconButton(
                  onPressed: () {
                    setState(() {
                      selected = 5;
                    });
                  },
                  icon: Icon(
                    Icons.emoji_emotions_outlined,
                    size: 40,
                    color: selected == 5 ? Color(0xfffbb313) : Colors.black45,
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
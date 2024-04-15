import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

import '../../../constance.dart';

class DescriptionTextWidget extends StatefulWidget {
  final String text;

  DescriptionTextWidget({required this.text});

  @override
  _DescriptionTextWidgetState createState() => _DescriptionTextWidgetState();
}

class _DescriptionTextWidgetState extends State<DescriptionTextWidget> {
  late String firstHalf;
  late String secondHalf;
  bool flag = true;

  @override
  void initState() {
    super.initState();

    if (widget.text.length > 100) {
      firstHalf = widget.text.substring(0, 100);
      secondHalf = widget.text.substring(100, widget.text.length);
    } else {
      firstHalf = widget.text;
      secondHalf = "";
    }
  }

  @override
  Widget build(BuildContext context) {
    return secondHalf.isEmpty
        ? Text(firstHalf)
        : RichText(
      text: TextSpan(
        children: <TextSpan>[
          TextSpan(
            text: flag ? (firstHalf) : (firstHalf + secondHalf),
            style:  TextStyle(color: Constans(context).brown, fontSize: 16),
          ),
          TextSpan(
            text: flag ? " show more" : " show less",
            style: TextStyle(color: Constans(context).brown,),
            recognizer: TapGestureRecognizer()
              ..onTap = () {
                setState(() {
                  flag = !flag;
                });
              },
          ),
        ],
      ),
    );
  }
}
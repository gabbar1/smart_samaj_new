
import 'package:flutter/material.dart';
import '../screen/helper/constant.dart';


class CircularProgress extends StatelessWidget {

  @override
  Widget build(BuildContext context) {

    return SizedBox(
      height: MediaQuery.of(context).size.height,
      child: Center(
        child: CircularProgressIndicator(
          valueColor: new AlwaysStoppedAnimation<Color>(
            Constants().mainColor,
          ),
        ),
      ),
    );
  }
}

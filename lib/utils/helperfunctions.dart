import 'package:flutter/material.dart';

class HelperFunctions{
  void showLoadingDialog(BuildContext context) {
    showDialog(
      context: context,
      barrierDismissible: false,
      // Prevent dismissing the dialog by tapping outside
      builder: (context) => Center(
        child: Card(
          elevation: 2,
          child: Container(
            width: 75.0,
            height: 75.0,
            decoration: BoxDecoration(
              color: Colors.black,
              borderRadius: BorderRadius.circular(4.0),
            ),
            child: const Padding(
              padding: EdgeInsets.all(12.0),
              child: SizedBox(
                  height: 60,
                  width: 60,
                  child: CircularProgressIndicator.adaptive()),
            ),
          ),
        ),
      ),
    );
  }
}
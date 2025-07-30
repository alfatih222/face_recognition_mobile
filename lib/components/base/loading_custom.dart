import 'package:flutter/material.dart';

class CLoading extends StatelessWidget {
  const CLoading({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          CircularProgressIndicator(
            color: Theme.of(context).primaryColor,
          ),
          const SizedBox(
            height: 24,
          ),
          Text(
            "Loading...",
            style: TextStyle(color: Colors.grey.shade700),
          )
        ],
      ),
    );
  }
}

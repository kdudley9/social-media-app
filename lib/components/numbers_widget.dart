import 'package:flutter/material.dart';

class NumbersWidget extends StatelessWidget {
  const NumbersWidget({super.key});

  @override
  Widget build(BuildContext context) => IntrinsicHeight(
    child: Row (
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        buildButton(context, '25', 'Following'),
        buildDivider(),
        buildButton(context, '50', 'Followers'),
      ],
    ),
  );

  Widget buildDivider() => const SizedBox(
    height: 24,
    child: VerticalDivider(),
  );

  Widget buildButton (
    BuildContext context, 
    String value,
    String text
    ) => MaterialButton(
      onPressed: () {},
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          Text(
            value,
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 20,
            )
          ),
          const SizedBox(height: 2),
          Text(
            text,
            style: const TextStyle(
              fontWeight: FontWeight.bold,
            )
          ),
        ],
      ),
    );
  


}
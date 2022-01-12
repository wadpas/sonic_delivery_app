import 'package:flutter/material.dart';

import '../screens/category_screen.dart';

class CategotyItem extends StatelessWidget {
  const CategotyItem({Key? key, this.title}) : super(key: key);
  final String? title;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => Navigator.pushNamed(context, CategoryScreen.routeName,
          arguments: title),
      splashColor: Theme.of(context).colorScheme.primary,
      borderRadius: BorderRadius.circular(4),
      child: Column(
        children: [
          const Expanded(
            child: Image(
              image: AssetImage('assets/images/food.png'),
              fit: BoxFit.cover,
            ),
          ),
          Text(title!),
        ],
      ),
    );
  }
}

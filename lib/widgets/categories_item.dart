import 'package:flutter/material.dart';

import '../screens/category_screen.dart';

class CategoriesItem extends StatelessWidget {
  const CategoriesItem({Key? key, this.id, this.title}) : super(key: key);
  final String? id;
  final String? title;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => Navigator.pushNamed(context, CategoryScreen.routeName,
          arguments: {'id': id, 'title': title}),
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

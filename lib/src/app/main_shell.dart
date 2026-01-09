import 'package:flutter/material.dart';
import 'package:reseller/src/modules/home/presentation/pages/home.dart';
import 'package:reseller/src/modules/ingredients/presentation/pages/ingredient_list.dart';
import 'package:reseller/src/modules/recipes/presentation/pages/recipe_list.dart';

class MainShell extends StatefulWidget {
  const MainShell({super.key});

  @override
  State<MainShell> createState() => _MainShellState();
}

class _MainShellState extends State<MainShell> {
  int index = 0;

  final pages = const [Home(), RecipeList(), IngredientList()];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:  IndexedStack(index: index, children: pages),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: index,
        onTap: (i) => setState(() => index = i),
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(icon: Icon(Icons.book), label: 'Receitas'),
          BottomNavigationBarItem(
            icon: Icon(Icons.kitchen),
            label: 'Ingredientes',
          ),
        ],
      ),
    );
  }
}

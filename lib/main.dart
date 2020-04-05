import 'package:flutter/material.dart';

import './models/meal.dart';
import './data/dummy_data.dart';

import './screens/tabs_screen.dart';
import './screens/category_meals_screen.dart';
import './screens/categories_screen.dart';
import './screens/meal_detail_screen.dart';
import './screens/settings_screen.dart';

void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  Map<String, bool> _settings = {
    'gluten':false,
    'lactose':false,
    'vegan':false,
    'vegetarian':false,
  };

  List<Meal> _availableMeals = DUMMY_MEALS;

  void _setSettings(Map<String, bool> settingsData){
    setState(() {
      _settings = settingsData;

      _availableMeals = DUMMY_MEALS.where((meal){
        if(_settings['gluten'] && !meal.isGlutenFree ){
          return false;
        }
        if(_settings['lactose'] && !meal.isLactoseFree ){
          return false;
        }
        if(_settings['vegan'] && !meal.isVegan ){
          return false;
        }
        if(_settings['vegetarian'] && !meal.isVegetarian ){
          return false;
        }
        return true;
      }).toList();
    });
  }
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Meals App',
      theme: ThemeData(
        primarySwatch: Colors.deepOrange,
        accentColor: Colors.orangeAccent,
        canvasColor: Color.fromRGBO(255, 254, 229, 1),
        fontFamily: 'Raleway',
        textTheme: ThemeData.light().textTheme.copyWith(
              body1: TextStyle(
                color: Color.fromRGBO(20, 51, 51, 1),
              ),
              body2: TextStyle(
                color: Color.fromRGBO(20, 51, 51, 1),
              ),
              title: TextStyle(
                fontSize: 20,
                fontFamily: 'RobotoCondensed',
                fontWeight: FontWeight.bold,
              ),
            ),
      ),
      //home: CategoriesScreen(),
      debugShowCheckedModeBanner: false,
      routes: {
        '/': (ctx) => TabsScreen(),
        CategoryMealsScreen.routeName: (ctx) => CategoryMealsScreen(_availableMeals),
        MealDetailScreen.routeName: (ctx) => MealDetailScreen(),
        SettingsScreen.routeName: (ctx) => SettingsScreen(_setSettings, _settings),
      },
      // onGenerateRoute: (settings){
      //   print(settings.arguments);
      //   if(settings.name == '/meal-detail'){
      //     return ...;
      //   } else if(settings.name == '/something-else'){
      //     return ...;
      //   }
      //   return MaterialPageRoute(builder: (ctx) => CategoriesScreen());
      // },
      onUnknownRoute: (settings){
        //fallback page
        return MaterialPageRoute(builder: (ctx) => CategoriesScreen());
      },
    );
  }
}

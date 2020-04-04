import 'package:flutter/material.dart';

import '../widgets/main_drawer.dart';

class SettingsScreen extends StatefulWidget {
  static const routeName = '/settings';

  final Function saveSettings;

  SettingsScreen(this.saveSettings);

  @override
  _SettingsScreenState createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  bool _glutenFree = false;
  bool _vegetarian = false;
  bool _vegan = false;
  bool _lactoseFree = false;

  Widget _buildSwitchListTile(
      String title, String description, bool currentVal, Function updateValue) {
    return SwitchListTile(
      title: Text(title),
      subtitle: Text(description),
      value: currentVal,
      onChanged: updateValue,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Settings',
        ),
        actions: <Widget>[
          IconButton(icon: Icon(Icons.save), onPressed: widget.saveSettings)
        ],
      ),
      drawer: MainDrawer(),
      body: Column(
        children: <Widget>[
          Container(
            padding: EdgeInsets.all(15),
            child: Text(
              'Adjust your meals selection',
              style: Theme.of(context).textTheme.title,
            ),
          ),
          Expanded(
            child: ListView(
              children: <Widget>[
                _buildSwitchListTile(
                  'Gluten Free',
                  'Only include Gluten free meals',
                  _glutenFree,
                  (newVal) {
                    setState(() {
                      _glutenFree = newVal;
                    });
                  },
                ),
                _buildSwitchListTile(
                  'Vegetarian',
                  'Only include Vegetarian meals',
                  _vegetarian,
                  (newVal) {
                    setState(() {
                      _vegetarian = newVal;
                    });
                  },
                ),
                _buildSwitchListTile(
                  'Vegan',
                  'Only include Vegan meals',
                  _vegan,
                  (newVal) {
                    setState(() {
                      _vegan = newVal;
                    });
                  },
                ),
                _buildSwitchListTile(
                  'Lactose Free',
                  'Only include Lactose free meals',
                  _lactoseFree,
                  (newVal) {
                    setState(() {
                      _lactoseFree = newVal;
                    });
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

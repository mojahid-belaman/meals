import 'package:flutter/material.dart';

enum Filter { glutenFree, lactoseFree, vegetarian, vegan }

class FiltersScreen extends StatefulWidget {
  const FiltersScreen(
      {super.key, required this.onSelectScreen, required this.initialFilter});

  final void Function(String identifier) onSelectScreen;
  final Map<Filter, bool> initialFilter;

  @override
  State<FiltersScreen> createState() {
    return _FiltersScreenState();
  }
}

class _FiltersScreenState extends State<FiltersScreen> {
  var _isGlutenFreeFilter = false;
  var _islactoseFreeFilter = false;
  var _isVegetarianFilter = false;
  var _isVeganFilter = false;

  @override
  void initState() {
    super.initState();
    _isGlutenFreeFilter = widget.initialFilter[Filter.glutenFree]!;
    _islactoseFreeFilter = widget.initialFilter[Filter.lactoseFree]!;
    _isVegetarianFilter = widget.initialFilter[Filter.vegetarian]!;
    _isVeganFilter = widget.initialFilter[Filter.vegan]!;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Your Filters'),
      ),
      // drawer: DrawerMain(selectScreen: (identifier) {
      //   Navigator.of(context).pop();
      //   if (identifier == 'meals') {
      //     Navigator.of(context)
      //         .push(MaterialPageRoute(builder: (ctx) => const TabScreen()));
      //   }
      // }),
      body: PopScope(
        canPop: false,
        onPopInvoked: (didPop) {
          if (didPop) return;
          Navigator.of(context).pop({
            Filter.glutenFree: _isGlutenFreeFilter,
            Filter.lactoseFree: _islactoseFreeFilter,
            Filter.vegetarian: _isVegetarianFilter,
            Filter.vegan: _isVeganFilter
          });
        },
        child: Column(
          children: [
            SwitchListTile(
              value: _isGlutenFreeFilter,
              onChanged: (isChecked) {
                setState(() {
                  _isGlutenFreeFilter = isChecked;
                });
              },
              title: Text(
                'Gluten-free',
                style: Theme.of(context).textTheme.titleLarge!.copyWith(
                      color: Theme.of(context).colorScheme.onBackground,
                    ),
              ),
              subtitle: Text(
                'Only include gluten-free meals.',
                style: Theme.of(context).textTheme.labelMedium!.copyWith(
                    color: Theme.of(context).colorScheme.onBackground),
              ),
              activeColor: Theme.of(context).colorScheme.tertiary,
            ),
            SwitchListTile(
              value: _islactoseFreeFilter,
              onChanged: (isChecked) {
                setState(() {
                  _islactoseFreeFilter = isChecked;
                });
              },
              title: Text(
                'Lactose-free',
                style: Theme.of(context).textTheme.titleLarge!.copyWith(
                      color: Theme.of(context).colorScheme.onBackground,
                    ),
              ),
              subtitle: Text(
                'Only include lactose-free meals.',
                style: Theme.of(context).textTheme.labelMedium!.copyWith(
                    color: Theme.of(context).colorScheme.onBackground),
              ),
              activeColor: Theme.of(context).colorScheme.tertiary,
            ),
            SwitchListTile(
              value: _isVegetarianFilter,
              onChanged: (isChecked) {
                setState(() {
                  _isVegetarianFilter = isChecked;
                });
              },
              title: Text(
                'Vegetarian',
                style: Theme.of(context).textTheme.titleLarge!.copyWith(
                      color: Theme.of(context).colorScheme.onBackground,
                    ),
              ),
              subtitle: Text(
                'Only include vegetarian meals.',
                style: Theme.of(context).textTheme.labelMedium!.copyWith(
                    color: Theme.of(context).colorScheme.onBackground),
              ),
              activeColor: Theme.of(context).colorScheme.tertiary,
            ),
            SwitchListTile(
              value: _isVeganFilter,
              onChanged: (isChecked) {
                setState(() {
                  _isVeganFilter = isChecked;
                });
              },
              title: Text(
                'Vegan',
                style: Theme.of(context).textTheme.titleLarge!.copyWith(
                      color: Theme.of(context).colorScheme.onBackground,
                    ),
              ),
              subtitle: Text(
                'Only include vegan meals.',
                style: Theme.of(context).textTheme.labelMedium!.copyWith(
                    color: Theme.of(context).colorScheme.onBackground),
              ),
              activeColor: Theme.of(context).colorScheme.tertiary,
            )
          ],
        ),
      ),
    );
  }
}

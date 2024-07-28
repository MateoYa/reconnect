import 'package:flutter/material.dart';

import '../settings/settings_view.dart';
import 'sample_item.dart';
import 'sample_item_details_view.dart';
import 'NotificationPlugin.dart';

/// Displays a list of SampleItems.
class SampleItemListView extends StatefulWidget {
  const SampleItemListView({Key? key}) : super(key: key);
  @override
  State<SampleItemListView> createState() => _SampleItemListView();
}

class _SampleItemListView extends State<SampleItemListView> {
  static const routeName = '/';
  int _selectedIndex = -1;  
  int _selectedIndex2 = -1;  
  int _selectedIndex3 = -1;  

  Icon _buildIcon(int index) {
    switch (index) {
      case 0:
        return Icon(Icons.sentiment_very_dissatisfied, size: 40,); // Lowest rating
      case 1:
        return Icon(Icons.sentiment_dissatisfied, size: 40,); // Moderate-low rating
      case 2:
        return Icon(Icons.sentiment_neutral, size: 40,); // Neutral rating
      case 3:
        return Icon(Icons.sentiment_satisfied, size: 40,); // Moderate-high rating
      case 4:
        return Icon(Icons.sentiment_very_satisfied, size: 40,); // Highest rating
      default:
        return Icon(Icons.star_border, size: 40,); // Default icon
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Mood Survey'),
        actions: [
          IconButton(
            icon: const Icon(Icons.settings),
            onPressed: () {
              LocalNotificationService().showNotificationAndroid("Show", "Something");
              // Navigate to the settings page. If the user leaves and returns
              // to the app after it has been killed while running in the
              // background, the navigation stack is restored.
              Navigator.restorablePushNamed(context, SettingsView.routeName);
            },
          ),
        ],
      ),

      // To work with lists that may contain a large number of items, it’s best
      // to use the ListView.builder constructor.
      //
      // In contrast to the default ListView constructor, which requires
      // building all Widgets up front, the ListView.builder constructor lazily
      // builds Widgets as they’re scrolled into view.
      body: Column(
        children: [ const Text(
                'Rate Your Day Overall',
                style: TextStyle(
                    color: Color.fromARGB(255, 0, 0, 0),
                    fontWeight: FontWeight.bold,
                    fontSize: 25,),
                    textAlign: TextAlign.center,
              ),
          Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(5, (index) {
                return IconButton(
                  icon: _buildIcon(index),
                  onPressed: () {
                    setState(() {
                      _selectedIndex = index;
                    }
                    );
                  },
                  color: _selectedIndex == index ? Colors.green : null,
                );
              }),
            ),
            const Text(
                'How Productive Was Your Screen Time',
                style: TextStyle(
                    color: Color.fromARGB(255, 0, 0, 0),
                    fontWeight: FontWeight.bold,
                    fontSize: 25,),
                    textAlign: TextAlign.center,
              ),
          Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(5, (index) {
                return IconButton(
                  icon: _buildIcon(index),
                  onPressed: () {
                    setState(() {
                      _selectedIndex2 = index;
                    }
                    );
                  },
                  color: _selectedIndex2 == index ? Colors.green : null,
                );
              }),
            ),
            const Text(
                'How Anxious Did You Feel Today',
                style: TextStyle(
                    color: Color.fromARGB(255, 0, 0, 0),
                    fontWeight: FontWeight.bold,
                    fontSize: 25,),
                    textAlign: TextAlign.center,
              ),
          Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(5, (index) {
                return IconButton(
                  icon: _buildIcon(index),
                  onPressed: () {
                    setState(() {
                      _selectedIndex3 = index;
                    }
                    );
                  },
                  color: _selectedIndex3 == index ? Colors.green : null,
                );
              }),
            ),
            ElevatedButton(
              onPressed: () {
                LocalNotificationService().showNotificationAndroid("Submitted", "Yay You Submitted Today's Report");
                setState(() {
                  //Call api backened 
                  _selectedIndex = -1;
                  _selectedIndex2 = -1;
                  _selectedIndex3 = -1;
                });
              },
              child: const Text('Submit'),
            ),

                  
                  ]),
        // Providing a restorationId allows the ListView to restore the
        // scroll position when a user leaves and returns to the app after it
        // has been killed while running in the background.
        // restorationId: 'sampleItemListView',
        // itemCount: items.length,
        // itemBuilder: (BuildContext context, int index) {
        //   final item = items[index];

        //   return ListTile(
        //     title: Text('SampleItem ${item.id}'),
        //     leading: const CircleAvatar(
        //       // Display the Flutter Logo image asset.
        //       foregroundImage: AssetImage('assets/images/flutter_logo.png'),
        //     ),
        //     onTap: () {
        //       // Navigate to the details page. If the user leaves and returns to
        //       // the app after it has been killed while running in the
        //       // background, the navigation stack is restored.
        //       Navigator.restorablePushNamed(
        //         context,
        //         SampleItemDetailsView.routeName,

    );
  }
}

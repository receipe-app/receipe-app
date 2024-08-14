import 'package:flutter/material.dart';

class SearchDelegateWidget extends SearchDelegate {
  // List of search data
  final List<String> searchItems;

  SearchDelegateWidget(this.searchItems);

  // Override the `buildSuggestions` method to show suggestions as the user types
  @override
  Widget buildSuggestions(BuildContext context) {
    List<String> suggestions = searchItems.where((item) {
      return item.toLowerCase().contains(query.toLowerCase());
    }).toList();

    return ListView.builder(
      itemCount: suggestions.length,
      itemBuilder: (context, index) {
        return ListTile(
          title: Text(suggestions[index]),
          onTap: () {
            query = suggestions[index];
            showResults(context);
          },
        );
      },
    );
  }

  // Override the `buildResults` method to show the results based on the search query
  @override
  Widget buildResults(BuildContext context) {
    List<String> results = searchItems.where((item) {
      return item.toLowerCase().contains(query.toLowerCase());
    }).toList();

    return ListView.builder(
      itemCount: results.length,
      itemBuilder: (context, index) {
        return ListTile(
          title: Text(results[index]),
          onTap: () {
            close(context, results[index]); // Return the selected result
          },
        );
      },
    );
  }

  // Override the `buildActions` method to show actions for the AppBar (e.g., clear the search query)
  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
        icon: const Icon(Icons.clear),
        onPressed: () {
          query = '';
        },
      ),
    ];
  }

  // Override the `buildLeading` method to add a back button or other leading widget in the AppBar
  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
      icon: const Icon(Icons.arrow_back),
      onPressed: () {
        close(context, null); // Close the search and return null
      },
    );
  }
}

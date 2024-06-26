import 'package:flutter/material.dart';
import 'package:movie_app/provider/movie_provider.dart';
import 'package:movie_app/screens/my_list.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key, required this.title});
  final String title;

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    var movie = context
        .watch<MovieProvider>()
        .movies; // Corrected 'MovieProvideer' to 'MovieProvider'
    var myList = context
        .watch<MovieProvider>()
        .myList; // Corrected 'MovieProvideer' to 'MovieProvider'

    return Scaffold(
      // Removed 'const' from Scaffold to allow dynamic content
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Padding(
        padding: const EdgeInsets.all(15),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            ElevatedButton.icon(
              onPressed: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) =>
                        MyListScreen(), // Fixed builder syntax
                  ),
                );
              },
              icon: const Icon(Icons.favorite),
              label: Text(
                'My Favorite ${myList.length}',
                style: const TextStyle(fontSize: 23),
              ),
              style: ElevatedButton.styleFrom(
                primary: Colors.deepOrange,
                padding: const EdgeInsets.symmetric(vertical: 20),
              ),
            ),
            SizedBox(
              height: 16,
            ),
            Expanded(
                child: ListView.builder(
                    itemCount: movie.length,
                    itemBuilder: (_, index) {
                      final currentMovie = movie[index];
                      return Card(
                        key: ValueKey(currentMovie.title),
                        color: Colors.deepPurple,
                        elevation: 4,
                        child: ListTile(
                          title: Text('${currentMovie.title}'),
                          subtitle: Text(currentMovie.runtime ?? 'No Data'),
                          trailing: IconButton(
                            icon: Icon(
                              Icons.favorite,
                              color: myList.contains(currentMovie)
                                  ? Colors.deepOrange
                                  : Colors.white,
                              size: 25,
                            ),
                            onPressed: () {
                              if (!myList.contains(currentMovie)) {
                                context
                                    .read<MovieProvider>()
                                    .addToList(currentMovie);
                              } else {
                                context
                                    .read<MovieProvider>()
                                    .removeFromList(currentMovie);
                              }
                            },
                          ),
                        ),
                      );
                    }))
          ],
        ),
      ),
    );
  }
}

import 'package:bloc_architect/src/blocs/movies_bloc.dart';
import 'package:bloc_architect/src/models/item_model.dart';
import 'package:flutter/material.dart';

class MyWidget extends StatefulWidget {
  const MyWidget({super.key});

  @override
  State<MyWidget> createState() => _MyWidgetState();
}

class _MyWidgetState extends State<MyWidget> {
  bool isSearching = false;
  TextEditingController controller = TextEditingController();
  Iterable<String> string = Iterable.empty();

  @override
  Widget build(BuildContext context) {
    try {
      bloc.fetchAllMovies();
      return Scaffold(
        drawer: Drawer(
            clipBehavior: Clip.antiAlias,
            elevation: 10,
            child: ListView(
              padding: EdgeInsets.all(10),
              children: [
                const Text(
                  "Movie Genre",
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                ListTile(
                  title: Text("Horror"),
                  onTap: () {},
                ),
                ListTile(
                  onTap: () {},
                  title: Text("Adventure"),
                )
              ],
            )),
        appBar: AppBar(
          title: AnimatedCrossFade(
              firstCurve: Curves.easeIn,
              secondCurve: Curves.easeInOut,
              firstChild: const Text("MOVIE DB"),
              secondChild: TextField(
                autofillHints: string,
                controller: controller,
                showCursor: true,
                onEditingComplete: () {
                  setState(() {
                    isSearching = false;
                  });
                },
              ),
              crossFadeState: isSearching
                  ? CrossFadeState.showSecond
                  : CrossFadeState.showFirst,
              duration: const Duration(milliseconds: 100)),
          actions: [
            IconButton(
              onPressed: () {
                setState(() {
                  isSearching = !isSearching;
                  if (isSearching) controller.text = '';
                });
              },
              icon: isSearching ? Icon(Icons.cancel) : Icon(Icons.search),
            )
          ],
        ),
        body: StreamBuilder(
          stream: bloc.allMovies,
          builder: (context, AsyncSnapshot<ItemModel> snapshot) {
            if (snapshot.hasData) {
              string = List.generate(
                  snapshot.data!.results.length,
                  (index) =>
                      snapshot.data!.results[index].original_title.toString());
              return buildList(snapshot);
            } else if (snapshot.hasError) {
              return Text(snapshot.error.toString());
            }
            return const Center(
              child: CircularProgressIndicator(),
            );
          },
        ),
      );
    } catch (e) {
      print(e.toString());
      return Card();
    }
  }

  Widget buildList(AsyncSnapshot<ItemModel> snapshot) {
    Color color = Colors.transparent;
    return GridView.builder(
        physics: const BouncingScrollPhysics(),
        itemCount: snapshot.data?.results.length,
        gridDelegate:
            SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
        itemBuilder: (context, index) {
          return Stack(
            children: [
              GestureDetector(
                behavior: HitTestBehavior.opaque,
                onTap: () {
                  Navigator.pushNamed(context, "/details",
                      arguments: {"snap": snapshot, "index": index});
                },
                child: Card(
                  elevation: 10,
                  clipBehavior: Clip.antiAlias,
                  child: Column(
                    children: [
                      AspectRatio(
                        aspectRatio: 4 / 3.5,
                        child: Image.network(
                          "https://image.tmdb.org/t/p/w185${snapshot.data!.results[index].poster_path}",
                          fit: BoxFit.fitWidth,
                        ),
                      ),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          const Expanded(child: Text("Release Date:")),
                          Expanded(
                              child: Text(snapshot
                                  .data!.results[index].release_Date
                                  .toString()))
                        ],
                      )
                    ],
                  ),
                ),
              ),
              Positioned(
                  right: 1.0,
                  top: 1.0,
                  // height: 1.0,
                  child: Container(
                    foregroundDecoration: BoxDecoration(
                        color: color, borderRadius: BorderRadius.circular(38)),
                    decoration: BoxDecoration(
                      color: Colors.transparent,
                      borderRadius: BorderRadius.circular(38),
                    ),
                    child: IconButton(
                      highlightColor: Colors.blue,
                      splashRadius: 20,
                      hoverColor: Colors.blue,
                      onPressed: () {},
                      icon: Icon(Icons.more),
                    ),
                  )),
            ],
          );
        });
  }
}

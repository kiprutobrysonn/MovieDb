import 'dart:ui';
import 'package:bloc_architect/src/models/item_model.dart';
import 'package:flutter/material.dart';

class MovieDetails extends StatelessWidget {
  const MovieDetails({super.key});

  @override
  Widget build(BuildContext context) {
    Map result = ModalRoute.of(context)?.settings.arguments as Map;
    AsyncSnapshot<ItemModel> res = result['snap'];
    int index = result["index"] ?? 1;

    return Scaffold(
        appBar: AppBar(
          title: Text(res.data!.results[index].original_title),
          centerTitle: true,
        ),
        body: Stack(fit: StackFit.expand, children: [
          Image.network(
              "https://image.tmdb.org/t/p/w185${res.data!.results[index].poster_path}",
              filterQuality: FilterQuality.high,
              fit: BoxFit.cover),
          ClipRRect(
            child: BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 20, sigmaY: 20),
              child: Container(
                color: Colors.grey.withOpacity(0.1),
                alignment: Alignment.center,
              ),
            ),
          ),
          Column(
            children: [
              const SizedBox(
                height: 10,
              ),
              Stack(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Expanded(
                        child: AspectRatio(
                          aspectRatio: 9 / 5,
                          child: Image.network(
                            "https://image.tmdb.org/t/p/w185${res.data!.results[index].poster_path}",
                            fit: BoxFit.contain,
                          ),
                        ),
                      ),
                    ],
                  ),
                  Positioned(
                      right: 50.0,
                      top: 0.0,
                      child: RatingIndicator(
                          averageCount: res.data!.results[index].vote_average))
                ],
              ),
              Padding(
                padding: const EdgeInsets.symmetric(
                  vertical: 30,
                  horizontal: 10,
                ),
                child: Column(
                  children: [
                    const Text(
                      "Overview",
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                    Row(
                      children: [
                        Expanded(
                          child: Container(
                            decoration: BoxDecoration(
                              border: Border.all(color: Colors.white),
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(10.0),
                              child: Text(
                                res.data!.results[index].overview.toString(),
                                softWrap: true,
                                overflow: TextOverflow.visible,
                                style: const TextStyle(fontSize: 16),
                              ),
                            ),
                          ),
                        )
                      ],
                    ),
                  ],
                ),
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.only(left: 20),
                  child: Row(
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              const Text("Release Date: "),
                              Text(res.data!.results[index].release_Date
                                  .toString())
                            ],
                          ),
                          Row(
                            children: [
                              const Text("Rating: "),
                              Text(res.data!.results[index].vote_average
                                  .toString())
                            ],
                          ),
                        ],
                      )
                    ],
                  ),
                ),
              )
            ],
          )
        ]));
  }
}

class RatingIndicator extends StatefulWidget {
  RatingIndicator({super.key, required this.averageCount});

  final double averageCount;

  @override
  State<RatingIndicator> createState() => _RatingIndicatorState();
}

class _RatingIndicatorState extends State<RatingIndicator> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            IconButton(
              onPressed: () {},
              icon: CircularProgressIndicator(
                strokeWidth: 8,
                backgroundColor: Colors.transparent,
                valueColor:
                    const AlwaysStoppedAnimation<Color>(Colors.greenAccent),
                value: widget.averageCount / 10,
              ),
            ),
          ],
        ),
        const SizedBox(
          height: 5,
        ),
        Text("${(widget.averageCount * 10).round()}%")
      ],
    );
  }
}

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_movie_app_ui/models/movie.dart';
import 'package:flutter_movie_app_ui/screens/movie_player_screen.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

import '../components/custom_back_button.dart';

class MovieScreen extends StatelessWidget {
  const MovieScreen({super.key, required this.movie});

  final Movie movie;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          ..._buildBackground(context, movie),
          _buildMovieInformation(context),
          _buildActions(context),
          const SafeArea(
            child: Positioned(
              left: 10,
              top: 10,
              child: CustomBackButton(),
            ),
          ),
        ],
      ),
    );
  }

  Positioned _buildActions(BuildContext context) {
    return Positioned(
        bottom: 50,
        width: MediaQuery.of(context).size.width,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.all(20),
                    backgroundColor: Colors.red[400],
                    fixedSize:
                        Size(MediaQuery.of(context).size.width * 0.425, 50),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15))),
                onPressed: () {},
                child: RichText(
                  text: TextSpan(
                      style: Theme.of(context)
                          .textTheme
                          .bodyLarge!
                          .copyWith(color: Colors.white),
                      children: [
                        TextSpan(
                          text: 'Add to ',
                          style: Theme.of(context)
                              .textTheme
                              .bodyLarge!
                              .copyWith(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold),
                        ),
                        const TextSpan(text: 'Watchlist'),
                      ]),
                ),
              ),
              const SizedBox(width: 8),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.all(20),
                    backgroundColor: Colors.white,
                    fixedSize:
                        Size(MediaQuery.of(context).size.width * 0.425, 50),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15))),
                onPressed: () => Navigator.of(context).push(MaterialPageRoute(
                    builder: (ctx) => MoviePlayer(movie: movie))),
                child: RichText(
                  text: TextSpan(
                      style: Theme.of(context).textTheme.bodyLarge!,
                      children: [
                        TextSpan(
                          text: 'Start ',
                          style: Theme.of(context)
                              .textTheme
                              .bodyLarge!
                              .copyWith(fontWeight: FontWeight.bold),
                        ),
                        const TextSpan(text: 'Watching'),
                      ]),
                ),
              ),
            ],
          ),
        ));
  }

  Positioned _buildMovieInformation(BuildContext context) {
    return Positioned(
      width: MediaQuery.of(context).size.width,
      bottom: 150,
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            Text(
              movie.name,
              style: Theme.of(context)
                  .textTheme
                  .headline6!
                  .copyWith(color: Colors.white, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            Text(
              '${movie.year} | ${movie.category} | ${movie.duration.inHours}h ${movie.duration.inMinutes}m',
              style: Theme.of(context)
                  .textTheme
                  .bodySmall!
                  .copyWith(color: Colors.white, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            RatingBar.builder(
              initialRating: 3.5,
              minRating: 1,
              direction: Axis.horizontal,
              allowHalfRating: true,
              unratedColor: Colors.white,
              itemCount: 5,
              itemPadding: const EdgeInsets.symmetric(horizontal: 4.0),
              itemBuilder: (ctx, index) =>
                  const Icon(Icons.star, color: Colors.amber),
              onRatingUpdate: (value) {},
            ),
            Text(
              "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum.",
              maxLines: 8,
              style: Theme.of(context).textTheme.bodySmall!.copyWith(
                    height: 1.75,
                    color: Colors.white,
                  ),
            ),
          ],
        ),
      ),
    );
  }

  List<Widget> _buildBackground(BuildContext context, Movie movie) => [
        Container(height: double.infinity, color: const Color(0xFF000B49)),
        CachedNetworkImage(
          imageUrl: movie.imagePath,
          width: double.infinity,
          height: MediaQuery.of(context).size.height * 0.5,
          fit: BoxFit.cover,
          //TODO PLACEHOLDER CARREGAMENTO
          errorWidget: (context, url, error) => const Icon(Icons.error),
        ),
        const Positioned.fill(
          child: DecoratedBox(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  Colors.transparent,
                  Color(0xFF000B49),
                ],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                stops: [0.3, 0.5],
              ),
            ),
          ),
        ),
      ];
}

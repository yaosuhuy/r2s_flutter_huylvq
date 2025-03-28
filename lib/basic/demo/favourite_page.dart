import 'package:flutter/material.dart';

void main() {
  runApp(const FavouritePage());
}

class FavouritePage extends StatelessWidget {
  const FavouritePage({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: _buildHomePage(),
    );
  }

  Widget _buildHomePage() {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Favourite Page",
        ),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.network(
                "https://opidesign.net/wp-content/uploads/landscape-architecture-fun-facts-outside-productions-blog-980x551.jpg"),
            Row(
              children: [
                const Text("This picture is so sick!"),
                const Icon(
                  Icons.star,
                  color: Colors.red,
                ),
                const Text("41"),
              ],
            ),
            Row(
              children: [
                const Icon(Icons.location_on),
                const Icon(Icons.import_contacts),
                const Icon(Icons.access_alarm),
              ],
            ),
            Text(
                r"The Bliss image, famously used as the default wallpaper for Windows XP, is one of the most recognizable photographs in the world. Captured by photographer Charles O’Rear in 1996 in California’s Napa Valley, the image showcases a vibrant green hill under a bright blue sky with fluffy white clouds. Contrary to popular belief, the photo was not digitally altered—its stunning colors were the result of perfect weather conditions. Microsoft selected Bliss to symbolize the simplicity and optimism of Windows XP, making it an iconic piece of digital history"),
          ],
        ),
      ),
    );
  }
}

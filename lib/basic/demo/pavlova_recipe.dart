import 'package:flutter/material.dart';

void main() {
  runApp(const PavlovaRecipe());
}

var stars = Row(
  mainAxisSize: MainAxisSize.min,
  children: [
    const Icon(Icons.star_purple500_sharp),
    const Icon(Icons.star_purple500_sharp),
    const Icon(Icons.star_purple500_sharp),
    const Icon(Icons.star_border_purple500),
    const Icon(Icons.star_border_purple500),
  ],
);

var reviewsNumber = Text(
  "170 Reviews",
  style: TextStyle(
    fontWeight: FontWeight.w800,
    fontSize: 16,
  ),
);

class PavlovaRecipe extends StatelessWidget {
  const PavlovaRecipe({super.key});

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
          "Strawberry Pavlova Recipe",
          style: TextStyle(
            color: Colors.white,
          ),
        ),
        backgroundColor: Colors.blue,
      ),
      body: Container(
        padding: EdgeInsets.all(20),
        child: Column(
          children: [
            const Text(
              "Strawberry Pavlova",
              style: TextStyle(
                fontWeight: FontWeight.w800,
                fontSize: 25,
              ),
            ),
            const SizedBox(height: 20,),
            const Text(
              "Strawberry Pavlova is a delightful dessert featuring a crisp meringue shell with a soft, marshmallow-like center, topped with fluffy whipped cream and fresh strawberries. The meringue is made by whipping egg whites with sugar until stiff peaks form, then baked at a low temperature to achieve its signature texture. ",
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 20,),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [stars, reviewsNumber],
            ),
            const SizedBox(height: 20,),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Column(
                  children: [
                    Icon(
                      Icons.kitchen,
                      color: Colors.green[500],
                    ),
                    const Text(
                      "PREP.",
                      style: TextStyle(
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                    const Text(
                      "25 mins",
                      style: TextStyle(
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                  ],
                ),
                Column(
                  children: [
                    Icon(
                      Icons.timer,
                      color: Colors.green[500],
                    ),
                    const Text(
                      "COOK.",
                      style: TextStyle(
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                    const Text(
                      "1 hr",
                      style: TextStyle(
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                  ],
                ),
                Column(
                  children: [
                    Icon(
                      Icons.restaurant,
                      color: Colors.green[500],
                    ),
                    const Text(
                      "FEEDS.",
                      style: TextStyle(
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                    const Text(
                      "4-6",
                      style: TextStyle(
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                  ],
                ),
              ],
            ),
            Expanded(
                  child: Image.network(
                    "https://static01.nyt.com/images/2022/05/11/dining/NL-Strawberry-pavlova/merlin_205193310_6169f5d3-5ad8-4eae-b05e-427f41b6a1ff-superJumbo.jpg",
                  ),
                ),
          ],
        ),
      ),
    );
  }
}

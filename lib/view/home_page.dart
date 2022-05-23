import 'package:flutter/material.dart';
import 'package:shimmer_effect/Data/food_data.dart';
import 'package:shimmer_effect/model/foods.dart';
import 'package:shimmer_effect/widget/shimmer_widget.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  bool isLoading = false;
  List<Foods> foods = [];

  @override
  void initState() {
    super.initState();
    loadData();
  }

  Future loadData() async {
    setState(() => isLoading = true);
    await Future.delayed(const Duration(seconds: 4), () {});
    foods = List.of(allFoods);
    setState(() => isLoading = false);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Shimmer Example'),
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: loadData,
            icon: Icon(Icons.refresh),
          ),
        ],
      ),
      body: ListView.builder(
        itemCount: isLoading ? 20 : foods.length,
        itemBuilder: (BuildContext context, int index) {
          if (isLoading) {
            return buildFoodShimmer();
          } else {
            final food = foods[index];
            return buildFood(food);
          }
        },
      ),
    );
  }

  Widget buildFood(Foods food) {
    return ListTile(
      leading: CircleAvatar(
        radius: 32,
        backgroundImage: NetworkImage(food.urlImages),
      ),
      title: Text(
        food.title,
        style: TextStyle(fontSize: 16),
      ),
      subtitle: Text(
        food.description,
        style: TextStyle(fontSize: 14),
        maxLines: 1,
      ),
    );
  }

  Widget buildFoodShimmer() {
    return ListTile(
      leading: ShimmerWidget.circular(width: 64, height: 64),
      title: Align(
        alignment: Alignment.centerLeft,
        child: ShimmerWidget.rectangular(
          height: 16,
          width: MediaQuery.of(context).size.width * 0.3,
        ),
      ),
      subtitle: ShimmerWidget.rectangular(height: 14),
    );
  }
}

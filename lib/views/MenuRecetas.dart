import 'package:flutter/material.dart';

class RecipesPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFE0F2E9), // Light mint green background
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: Text('Recipes', style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold)),
        actions: [
          IconButton(
            icon: Icon(Icons.search, color: Colors.black),
            onPressed: () {},
          ),
          IconButton(
            icon: Icon(Icons.filter_list, color: Colors.black),
            onPressed: () {},
          ),
        ],
      ),
      body: Column(
        children: [
          _buildCategoryTabs(),
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  _buildRecipeGrid(),
                  _buildTrendingSection(),
                ],
              ),
            ),
          ),
        ],
      ),
      bottomNavigationBar: _buildBottomNavBar(),
    );
  }

  Widget _buildCategoryTabs() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          ElevatedButton(
            child: Text('Breakfast'),
            onPressed: () {},
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.green,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
            ),
          ),
          TextButton(
            child: Text('Lunch', style: TextStyle(color: Colors.grey)),
            onPressed: () {},
          ),
          TextButton(
            child: Text('Dinner', style: TextStyle(color: Colors.grey)),
            onPressed: () {},
          ),
        ],
      ),
    );
  }

  Widget _buildRecipeGrid() {
    return GridView.count(
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      crossAxisCount: 2,
      childAspectRatio: 1,
      children: [
        _buildRecipeCard('Avocado Salad', '230 kcal', 'assets/glucofit_logo.jpeg'),
        _buildRecipeCard('Breakfast Bowl', '220 kcal', 'assets/glucofit_logo.jpeg'),
        _buildRecipeCard('Healthy Snacks', '250 kcal', 'assets/glucofit_logo.jpeg'),
        _buildRecipeCard('Meal salad', '280 kcal', 'assets/glucofit_logo.jpeg'),
      ],
    );
  }

  Widget _buildRecipeCard(String title, String calories, String imagePath) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          CircleAvatar(
            radius: 50,
            backgroundImage: AssetImage(imagePath),
          ),
          SizedBox(height: 10),
          Text(title, style: TextStyle(fontWeight: FontWeight.bold)),
          Text(calories, style: TextStyle(color: Colors.grey)),
        ],
      ),
    );
  }

  Widget _buildTrendingSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: Text('Trending and easy recept', style: TextStyle(fontWeight: FontWeight.bold)),
        ),
        Container(
          height: 200,
          child: ListView(
            scrollDirection: Axis.horizontal,
            children: [
              _buildTrendingCard('Avocado Tost', '2 servings', 'assets/glucofit_logo.jpeg'),
              _buildTrendingCard('Green salad', '2 servings', 'assets/glucofit_logo.jpeg'),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildTrendingCard(String title, String servings, String imagePath) {
    return Container(
      width: 200,
      margin: EdgeInsets.only(left: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(15),
            child: Image.asset(imagePath, height: 150, fit: BoxFit.cover),
          ),
          SizedBox(height: 8),
          Text(title, style: TextStyle(fontWeight: FontWeight.bold)),
          Text(servings, style: TextStyle(color: Colors.grey)),
        ],
      ),
    );
  }

  Widget _buildBottomNavBar() {
    return BottomNavigationBar(
      type: BottomNavigationBarType.fixed,
      items: [
        BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
        BottomNavigationBarItem(icon: Icon(Icons.book), label: 'Diaries'),
        BottomNavigationBarItem(icon: Icon(Icons.settings), label: 'Settings'),
        BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Profile'),
      ],
    );
  }
}
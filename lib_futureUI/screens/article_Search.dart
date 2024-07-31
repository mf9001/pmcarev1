import 'package:flutter/material.dart';
import '../models/article_list.dart';
import 'article_detail.dart';

class ArticleSearch extends StatefulWidget {
  @override
  _ArticleSearchState createState() => _ArticleSearchState();
}

class _ArticleSearchState extends State<ArticleSearch> {
  final List<String> categories = [
    'Nutrition',
    'Health & Safety',
    'Growth & Development',
    'Parental Support'
  ];
  final List<Map<String, String>> articles = [
    {
      'title': 'Essential Nutrients for Preterm Babies',
      'views': '324 views',
      'image': 'lib/assets/essential_nutrients.jpg',
      'content':
          'Preterm babies have unique nutritional needs to support their growth and development. This article covers the essential nutrients required for preterm babies.',
    },
    {
      'title': 'Nutritional Guidelines for Preterm Infants',
      'views': '411 views',
      'image': 'lib/assets/nutritional_guidelines.jpeg',
      'content':
          'Following proper nutritional guidelines is crucial for the healthy growth of preterm infants. Learn about the recommended practices and tips for feeding your preterm baby.',
    },
    {
      'title': 'Importance of Iron in Preterm Baby Nutrition',
      'views': '289 views',
      'image': 'lib/assets/importance_of_iron.jpg',
      'content':
          'Iron is a vital nutrient for the development of preterm babies. This article explains the role of iron and how to ensure your baby gets enough of it.',
    },
    {
      'title': 'Protein Needs for Preterm Babies',
      'views': '356 views',
      'image': 'lib/assets/protein_needs.jpeg',
      'content':
          'Protein is essential for the growth and repair of tissues in preterm babies. Discover the best sources of protein and how to include them in your baby\'s diet.',
    },
    {
      'title': 'Vitamins and Minerals for Preterm Babies',
      'views': '375 views',
      'image': 'lib/assets/vitamins_minerals.jpeg',
      'content':
          'Vitamins and minerals play a significant role in the development of preterm babies. This article covers the essential vitamins and minerals and how to ensure your baby gets them.',
    },
  ];
  String selectedCategory = 'Nutrition';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 108, 215, 230),
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 108, 215, 230),
        title: Text(
          'Find Helpful Articles',
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.search, color: Colors.white),
            onPressed: () {
              // Search functionality not implemented yet
            },
          )
        ],
      ),
      body: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(16),
            topRight: Radius.circular(16),
          ),
        ),
        child: Column(
          children: [
            Container(
              height: 50,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: categories.length,
                itemBuilder: (context, index) {
                  return GestureDetector(
                    onTap: () {
                      setState(() {
                        selectedCategory = categories[index];
                      });
                    },
                    child: Container(
                      alignment: Alignment.center,
                      padding: EdgeInsets.symmetric(horizontal: 16),
                      margin: EdgeInsets.symmetric(horizontal: 8, vertical: 8),
                      decoration: BoxDecoration(
                        color: selectedCategory == categories[index]
                            ? const Color.fromARGB(255, 108, 215, 230)
                            : Colors.grey[300],
                        borderRadius: BorderRadius.circular(16),
                      ),
                      child: Text(categories[index]),
                    ),
                  );
                },
              ),
            ),
            Expanded(
              child: ListView.builder(
                itemCount: articles.length,
                itemBuilder: (context, index) {
                  return ArticleListTile(
                    article: articles[index],
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) =>
                              ArticleDetailScreen(article: articles[index]),
                        ),
                      );
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

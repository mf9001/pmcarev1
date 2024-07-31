import 'package:flutter/material.dart';

class ArticleListTile extends StatelessWidget {
  final Map<String, String> article;
  final VoidCallback onTap;

  const ArticleListTile({required this.article, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      child: ListTile(
        leading: ClipRRect(
          borderRadius: BorderRadius.circular(8.0),
          child: Image.asset(
            article['image']!,
            width: 50,
            height: 50,
            fit: BoxFit.cover,
          ),
        ),
        title: Text(article['title']!,
            style: TextStyle(
                color: Color.fromARGB(255, 75, 74, 74),
                fontWeight: FontWeight.bold)),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(article['views']!),
            SizedBox(height: 8),
            Text(
              article['content']!.substring(0, 50) + '...',
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
          ],
        ),
        onTap: onTap,
      ),
    );
  }
}
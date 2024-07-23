import 'package:flutter/material.dart';
import 'package:shelf/_core/constants/http.dart';
import 'package:shelf/_core/constants/size.dart';
import 'package:shelf/ui/pages/myshelf/data/myshelf_model.dart';
import 'package:shelf/ui/pages/myshelf/pages/book_detail_page.dart';

class WishlistItem extends StatelessWidget {
  final WishBook book;

  const WishlistItem({
    required this.book,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16.0),
      padding: const EdgeInsets.all(12.0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8.0),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            spreadRadius: 2,
            blurRadius: 5,
            offset: Offset(0, 3),
          ),
        ],
      ),
      child: InkWell(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => WishDetailPage(bookId: book.bookId),
            ),
          );
        },
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              height: 90,
              width: 60,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: NetworkImage(baseURL + book.bookImagePath),
                  fit: BoxFit.cover,
                ),
                borderRadius: BorderRadius.circular(8.0),
              ),
            ),
            SizedBox(width: 16.0),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: Text(
                          book.bookTitle,
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      Icon(Icons.favorite, color: Colors.red),
                    ],
                  ),
                  SizedBox(height: 4.0),
                  Text(
                    book.author,
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.black45,
                    ),
                    overflow: TextOverflow.ellipsis,
                  ),
                  SizedBox(height: gap_m),
                  Text(
                    '${book.createdAt}에 담김',
                    style: TextStyle(
                      fontSize: 12,
                      color: Colors.black26,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

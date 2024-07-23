import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shelf/ui/pages/myshelf/_components/wishlist_item.dart';
import 'package:shelf/ui/pages/myshelf/data/myshelf_model.dart';
import 'package:shelf/ui/pages/myshelf/data/wishlist_viewmodel.dart';

import '../../../../_core/constants/size.dart';

class WishlistTab extends ConsumerWidget {
  final List<WishBook> wishBookList;

  const WishlistTab({
    required this.wishBookList,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final updatedWishList = ref.watch(wishListProvider).bookList;
    final displayList =
        updatedWishList.isEmpty ? wishBookList : updatedWishList;

    return Padding(
      padding: const EdgeInsets.all(gap_m),
      child: Wrap(
        spacing: 8.0,
        runSpacing: gap_xs,
        children: displayList.isEmpty
            ? [
                Center(
                  child: Padding(
                    padding: const EdgeInsets.all(50.0),
                    child: Text(
                      "위시리스트가 비어있습니다.",
                      style: TextStyle(
                        color: Colors.black26,
                        fontSize: 16,
                      ),
                    ),
                  ),
                )
              ]
            : displayList.map((book) {
                return WishlistItem(book: book);
              }).toList(),
      ),
    );
  }
}

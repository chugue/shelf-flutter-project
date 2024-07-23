import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shelf/ui/common/components/modified_bottom_navigation_bar.dart';
import 'package:shelf/ui/pages/home/_components/best_seller_section.dart';
import 'package:shelf/ui/pages/home/_components/book_of_the_day_section.dart';
import 'package:shelf/ui/pages/home/_components/top_pick_section.dart';
import 'package:shelf/ui/pages/home/data/home_page_viewmodel.dart';

import '_components/history_section.dart';

class HomePage extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final homePageModel = ref.watch(homePageProvider);

    return Scaffold(
      backgroundColor: Colors.white,
      body: homePageModel == null
          ? Center(child: CircularProgressIndicator())
          : SingleChildScrollView(
              child: Column(
                children: [
                  TopPicksSection(books: homePageModel.homeData.bestSellers),
                  HistorySection(
                      historyBooks: homePageModel.homeData.bookHistory),
                  BookOfTheDaySection(
                      book: homePageModel.homeData.dayBestSeller),
                  BestSellerSection(),
                ],
              ),
            ),
      bottomNavigationBar: ModifiedBottomNavigator(
        selectedIndex: 0,
      ),
    );
  }
}

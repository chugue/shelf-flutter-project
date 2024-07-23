import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:shelf/_core/constants/http.dart';
import 'package:shelf/ui/pages/home/pages/book_detail_page/_components/detail_page_tabs.dart';
import 'package:shelf/ui/pages/home/pages/book_detail_page/data/book_detail_viewmodel.dart';

import '../../../../../_core/constants/constants.dart';
import '../../../../../_core/constants/size.dart';
import '../../../../../data/model/home/book_detail_data.dart';
import '../../../../../data/store/wishlist_toggle.dart';
import '../../widgets/bottom_action_bar.dart';
import '../../widgets/pie_chart_widget.dart';

class BookDetailPage extends ConsumerWidget {
  final int? bookId;

  const BookDetailPage({Key? key, required this.bookId}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final bookDetailState = ref.watch(bookDetailProvider(bookId!));

    if (bookDetailState == null) {
      return Center(child: CircularProgressIndicator());
    }
    final formattedDate = DateFormat('yyyy년 MM월 dd일').format(bookDetailState.bookDetailDTO.registrationDate);


    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [TColor.primaryColor1, TColor.secondaryColor2],
          ),
        ),
        child: SafeArea(
          child: SingleChildScrollView(
            child: Column(
              children: [
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 16),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      IconButton(
                        icon: Icon(Icons.arrow_back, color: Colors.white),
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                      ),
                      IconButton(
                        icon: Icon(
                          bookDetailState.bookDetailDTO.isWish
                              ? Icons.favorite
                              : Icons.favorite_border,
                          color: Colors.white,
                        ),
                        onPressed: () {
                          ref
                              .read(wishlistProvider.notifier)
                              .toggleWishlist(bookDetailState.bookDetailDTO);
                        },
                      ),
                    ],
                  ),
                ),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                  decoration: BoxDecoration(
                    color: Colors.black54,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Text(
                    '이 책이 담긴 서재 $libraryCount',
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.white,
                    ),
                  ),
                ),
                SizedBox(height: 10),
                Image.network(
                  baseURL + bookDetailState.bookDetailDTO.path,
                  height: 200,
                ),
                SizedBox(height: 20),
                Container(
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: Colors.grey[200],
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(20),
                      topRight: Radius.circular(20),
                    ),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: EdgeInsets.all(gap_l),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              bookDetailState.bookDetailDTO.title,
                              style: TextStyle(
                                fontSize: 24,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Text(
                              bookDetailState.bookDetailDTO.author.name,
                              style: TextStyle(
                                fontSize: 18,
                                color: Colors.grey[700],
                              ),
                            ),
                            SizedBox(height: 10),
                            Text(
                              '${bookDetailState.bookDetailDTO.publisher} · ${bookDetailState.bookDetailDTO.category} · $formattedDate',
                              style: TextStyle(
                                fontSize: 16,
                                color: Colors.grey[700],
                              ),
                            ),
                            SizedBox(height: 20),
                            Container(
                              padding: EdgeInsets.only(
                                  top: 25, left: 13, right: 25, bottom: 25),
                              decoration: BoxDecoration(
                                color: Colors.white54.withOpacity(0.8),
                                borderRadius: BorderRadius.circular(10),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.grey.withOpacity(0.3),
                                    spreadRadius: 3,
                                    blurRadius: 5,
                                    offset: Offset(0, 3),
                                  ),
                                ],
                              ),
                              child: Row(
                                children: [
                                  SizedBox(
                                    width: 100,
                                    height: 100,
                                    child: PieChartWidget(
                                      totalViews: bookDetailState
                                          .bookDetailDTO.totalViews,
                                      completedViews: bookDetailState
                                          .bookDetailDTO.completedViews,
                                    ),
                                  ),
                                  SizedBox(width: 12),
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        '${((bookDetailState.bookDetailDTO.completedViews ?? 0) / (bookDetailState.bookDetailDTO.totalViews ?? 1) * 100).toStringAsFixed(1)}%의 구독자가 완독했어요!',
                                        style: TextStyle(fontSize: 14),
                                      ),
                                      Text(
                                        '총 완독자 수 ${bookDetailState.bookDetailDTO.completedViews ?? 0}명',
                                        style: TextStyle(fontSize: 14),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                      DetailPageTabs(
                        book: bookDetailState.bookDetailDTO,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
      bottomNavigationBar:
          BottomActionBar(id: bookDetailState.bookDetailDTO.id),
    );
  }
}

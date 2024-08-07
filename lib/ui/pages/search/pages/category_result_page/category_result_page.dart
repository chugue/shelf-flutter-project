import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shelf/_core/constants/line.dart';
import 'package:shelf/data/model/category/category_list.dart';
import 'package:shelf/ui/common/components/modified_bottom_navigation_bar.dart';
import 'package:shelf/ui/pages/search/pages/category_result_page/_components/back_arrow_appbar.dart';
import 'package:shelf/ui/pages/search/pages/category_result_page/_components/category_result_book_grid.dart';
import 'package:shelf/ui/pages/search/pages/category_result_page/_components/result_title.dart';
import 'package:shelf/ui/pages/search/pages/category_result_page/_components/sort_bottm_sheet.dart';
import 'package:shelf/ui/pages/search/pages/category_result_page/_components/sort_section.dart';
import 'package:shelf/ui/pages/search/pages/category_result_page/data/category_result_model.dart';
import 'package:shelf/ui/pages/search/pages/category_result_page/data/category_result_viewmodel.dart';

class CategoryResultPage extends ConsumerWidget {
  final String categoryName;

  const CategoryResultPage({
    required this.categoryName,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final categoryResult = ref.watch(categoryResultProvider(categoryName));
    int _selectedIndex = 1;
    int _curationIndex = 0;
    String selectedSort = "완독할 확률 높은 순";

    return Scaffold(
      appBar: BackArrowAppBar(),
      body: Container(
        padding: EdgeInsets.symmetric(horizontal: 15),
        color: Colors.white,
        child: categoryResult == null
            ? Center(child: CircularProgressIndicator())
            : Column(
                children: [
                  ResultTitle(
                    // ~분야 모아보기 탭
                    categories: categories,
                    categoryName: categoryName,
                    curationIndex: _curationIndex,
                    applySelection: (selectedCategoryName) {
                      ref.refresh(categoryResultProvider(selectedCategoryName));
                    },
                  ),
                  SizedBox(height: 10),
                  greyLine1,
                  SortSection(
                    // 정렬 방식 선택
                    bookCount: categoryResult.categoryResultDTO.books.length,
                    selectedSort: selectedSort,
                    onSortTap: () {
                      _showSortBottomSheet(context, ref);
                    },
                  ),
                  CategoryResultBookGrid(
                    // 검색 결과 아이템들
                    books: categoryResult.categoryResultDTO.books,
                  ),
                ],
              ),
      ),
      bottomNavigationBar: ModifiedBottomNavigator(
        selectedIndex: _selectedIndex,
      ),
    );
  }

  // 내부 메소드=========================================

  void _showSortBottomSheet(BuildContext context, WidgetRef ref) {
    showModalBottomSheet(
      context: context,
      builder: (context) {
        return SortBottmSheet(
          sortBy: sortBy,
          selectedIndex: 0,
          onSortSelected: (index) {
            // 정렬 기준 변경 로직
          },
          onApply: () {
            Navigator.pop(context);
          },
        );
      },
    );
  }
}

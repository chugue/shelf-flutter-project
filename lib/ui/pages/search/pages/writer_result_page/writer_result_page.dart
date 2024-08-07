import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shelf/ui/common/components/modified_bottom_navigation_bar.dart';
import 'package:shelf/ui/pages/search/pages/category_result_page/_components/sort_bottm_sheet.dart';
import 'package:shelf/ui/pages/search/pages/category_result_page/data/category_result_model.dart';
import 'package:shelf/ui/pages/search/pages/writer_result_page/_components/writer_appbar.dart';
import 'package:shelf/ui/pages/search/pages/writer_result_page/_components/writer_result_book_grid.dart';
import 'package:shelf/ui/pages/search/pages/writer_result_page/_components/writer_sort_section.dart';
import 'package:shelf/ui/pages/search/pages/writer_result_page/data/writer_result_viewmodel.dart';

class WriterResultPage extends ConsumerWidget {
  final String? authorName;

  const WriterResultPage({
    this.authorName,
  });

  @override
  build(BuildContext context, WidgetRef ref) {
    final writerResultData = ref.watch(writerResultProvider(authorName!));
    int _selectedIndex = 0;
    String selectedSort = "완독할 확률 높은 순";

    return Scaffold(
      appBar: WriterAppBar(writerName: authorName),
      body: Container(
        padding: EdgeInsets.symmetric(horizontal: 15),
        color: Colors.white,
        child: writerResultData == null
            ? Center(child: CircularProgressIndicator())
            : Column(
                children: [
                  WriterSortSection(
                    // 총 몇권 -- 정렬순 섹션
                    bookCount: writerResultData.writerResultDTO.books.length,
                    selectedSort: selectedSort,
                    onSortTap: () {
                      _showResultSort(context, ref);
                    },
                  ),
                  WriterResultBookGrid(
                    // 검색된 아이템 그리드 뷰
                    books: writerResultData.writerResultDTO.books,
                  )
                ],
              ),
      ),
      bottomNavigationBar: ModifiedBottomNavigator(
        selectedIndex: _selectedIndex,
      ),
    );
  }

  // 내부 메소드 ======================================

  void _showResultSort(BuildContext context, WidgetRef ref) {
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

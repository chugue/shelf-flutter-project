// import 'package:flutter_riverpod/flutter_riverpod.dart';
//
// import '../model/category/category_page_data.dart';
// import '../repository/brandnew_repo.dart';
//
//
// class BrandNewModel {
//   DateTime selectedMonth;
//   List<Book> books;
//   Map<String, List<Book>> groupedBooks;
//
//   BrandNewModel({
//     required this.selectedMonth,
//     required this.books,
//     required this.groupedBooks,
//   });
// }
//
// class BrandNewViewModel extends StateNotifier<BrandNewModel> {
//   BrandNewViewModel() : super(BrandNewModel(selectedMonth: DateTime(2024, 10), books: [], groupedBooks: {})) {
//     fetchBrandNewData();
//   }
//
//   void updateSelectedMonth(DateTime newMonth) {
//     final updatedBooks = state.books.where((book) {
//       DateTime date = DateTime.parse(book.registrationDate);
//       return date.year == newMonth.year && date.month == newMonth.month;
//     }).toList();
//
//     state = BrandNewModel(
//       selectedMonth: newMonth,
//       books: updatedBooks,
//       groupedBooks: _groupBooksByWeek(updatedBooks, newMonth),
//     );
//   }
//
//   Future<void> fetchBrandNewData() async {
//     final responseDTO = await BrandnewRepo(baseUrl: 'https://api.yourserver.com').fetchBrandNewData();
//     final initialMonth = state.selectedMonth;
//
//     state = BrandNewModel(
//       selectedMonth: initialMonth,
//       books: responseDTO.brandNewList,
//       groupedBooks: _groupBooksByWeek(responseDTO.brandNewList, initialMonth),
//     );
//   }
//
//   Map<String, List<Book>> _groupBooksByWeek(List<Book> books, DateTime selectedMonth) {
//     Map<String, List<Book>> groupedBooks = {};
//     for (var book in books) {
//       DateTime date = DateTime.parse(book.registrationDate);
//       int weekNumber = ((date.day - 1) / 7).floor() + 1;
//       String weekKey = '${selectedMonth.month}월 ${_weekNumberToKorean(weekNumber)}';
//       if (groupedBooks[weekKey] == null) {
//         groupedBooks[weekKey] = [];
//       }
//       groupedBooks[weekKey]!.add(book);
//     }
//     return groupedBooks;
//   }
//
//   String _weekNumberToKorean(int weekNumber) {
//     switch (weekNumber) {
//       case 1:
//         return '첫째주';
//       case 2:
//         return '둘째주';
//       case 3:
//         return '셋째주';
//       case 4:
//         return '넷째주';
//       case 5:
//         return '다섯째주';
//       default:
//         return '${weekNumber}주';
//     }
//   }
// }
//
// final brandNewProvider = StateNotifierProvider<BrandNewViewModel, BrandNewModel>(
//       (ref) => BrandNewViewModel(),
// );

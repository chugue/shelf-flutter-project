import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:dio/dio.dart';

// DTO 정의

class BrandNewRespDTO {
  final String brandNewWeekly;
  final List<BrandNewList> brandNewList;

  BrandNewRespDTO({
    required this.brandNewWeekly,
    required this.brandNewList,
  });

  factory BrandNewRespDTO.fromJson(Map<String, dynamic> json) {
    var list = json['brandNewList'] as List;
    List<BrandNewList> brandNewList = list.map((i) => BrandNewList.fromJson(i)).toList();

    return BrandNewRespDTO(
      brandNewWeekly: json['brandNewWeekly'],
      brandNewList: brandNewList,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'brandNewWeekly': brandNewWeekly,
      'brandNewList': brandNewList.map((book) => book.toJson()).toList(),
    };
  }
}

class BrandNewList {
  final int bookId;
  final String title;
  final String author;
  final String path;
  final String registrationDate; // 추가된 필드

  BrandNewList({
    required this.bookId,
    required this.title,
    required this.author,
    required this.path,
    required this.registrationDate,
  });

  factory BrandNewList.fromJson(Map<String, dynamic> json) {
    return BrandNewList(
      bookId: json['bookId'],
      title: json['title'],
      author: json['author'],
      path: json['path'],
      registrationDate: json['registrationDate'], // 추가된 필드
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'bookId': bookId,
      'title': title,
      'author': author,
      'path': path,
      'registrationDate': registrationDate, // 추가된 필드
    };
  }
}

// Repository 클래스 정의

class BrandnewRepo {
  final String baseUrl;
  final Dio _dio = Dio();

  BrandnewRepo({required this.baseUrl});

  Future<BrandNewRespDTO> fetchBrandNewData(String registrationMonth) async {
    try {
      final response = await _dio.get('$baseUrl/app/book/new', queryParameters: {'month': registrationMonth});

      if (response.statusCode == 200) {
        return BrandNewRespDTO.fromJson(response.data);
      } else {
        throw Exception('Failed to load brand new data');
      }
    } catch (e) {
      throw Exception('Failed to load brand new data: $e');
    }
  }
}

// ViewModel 정의

final selectedMonthProvider = StateProvider<DateTime>((ref) {
  return DateTime(2024, 10);
});

final brandNewDataProvider = FutureProvider<BrandNewRespDTO>((ref) async {
  final selectedMonth = ref.watch(selectedMonthProvider);
  final repo = BrandnewRepo(baseUrl: 'https://api.yourserver.com');
  String registrationMonth = '${selectedMonth.year}-${selectedMonth.month.toString().padLeft(2, '0')}';
  return await repo.fetchBrandNewData(registrationMonth);
});

final groupedBooksProvider = Provider<Map<String, List<BrandNewList>>>((ref) {
  final asyncBrandNewData = ref.watch(brandNewDataProvider);

  return asyncBrandNewData.when(
    data: (data) {
      Map<String, List<BrandNewList>> groupedBooks = {};
      for (var book in data.brandNewList) {
        DateTime date = DateTime.parse(book.registrationDate);
        String weekKey = '${date.month}월 ${_getWeekKey(date, data.brandNewWeekly)}';
        if (groupedBooks[weekKey] == null) {
          groupedBooks[weekKey] = [];
        }
        groupedBooks[weekKey]!.add(book);
      }
      return groupedBooks;
    },
    loading: () => {},
    error: (_, __) => {},
  );
});

String _getWeekKey(DateTime date, String brandNewWeekly) {
  int weekNumber = ((date.day - 1) / 7).floor() + 1;
  return brandNewWeekly.replaceAllMapped(RegExp(r'\d'), (match) => weekNumber.toString());
}

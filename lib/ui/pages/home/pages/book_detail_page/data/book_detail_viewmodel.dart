import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shelf/_core/constants/http.dart';
import 'package:shelf/data/store/session_store.dart';
import 'package:shelf/main.dart';
import 'package:shelf/ui/pages/home/pages/book_detail_page/data/book_detail_model.dart';
import 'package:shelf/ui/pages/home/pages/book_detail_page/data/book_detail_repo.dart';

// 창고 관리자
final bookDetailProvider =
    StateNotifierProvider.family<BookDetailViewmodel, BookDetailModel?, int>(
        (ref, id) {
  return BookDetailViewmodel(ref, id)..loadBookDetail();
});

// 창고
class BookDetailModel {
  final BookDetailDTO bookDetailDTO;

  const BookDetailModel({
    required this.bookDetailDTO,
  });

  BookDetailModel copyWith({
    BookDetailDTO? bookDetailDTO,
  }) {
    return BookDetailModel(
      bookDetailDTO: bookDetailDTO ?? this.bookDetailDTO,
    );
  }
}

BookDetailModel? copyWith({required BookDetailDTO bookDetailDTO}) {}

// 창고 데이터
class BookDetailViewmodel extends StateNotifier<BookDetailModel?> {
  final mContext = navigatorKey.currentContext;
  final Ref ref;
  final int id;

  BookDetailViewmodel(this.ref, this.id) : super(null);

  // 페이지 로드시 데이터 요청
  Future<void> loadBookDetail() async {
    logger.d("11111");
    SessionUser sessionUser = ref.read(sessionProvider);

    BookDetailDTO bookDetailDTO =
        await BookDetailRepo().fetchBookDetails(sessionUser.jwt!, id);
    state = BookDetailModel(bookDetailDTO: bookDetailDTO);
  }

  // 위시리스트 상태 업데이트
  Future<void> updateBookWishStatus(int bookId) async {
    SessionUser sessionUser = ref.read(sessionProvider);

    IsWish isWish = await BookDetailRepo()
        .updateBookWishStatus(sessionUser.jwt!, sessionUser.user!.id, bookId);

    // 상태 업데이트
    state = state!.copyWith(
      bookDetailDTO: state!.bookDetailDTO.copyWith(isWish: isWish.isWish),
    );
  }

  // 내서재 위시리스트 통신
  Future<void> updateMyShelfWishList(int bookId) async {
    SessionUser sessionUser = ref.read(sessionProvider);

    IsWish isWish = await BookDetailRepo()
        .updateBookWishStatus(sessionUser.jwt!, sessionUser.user!.id, bookId);

    // 상태 업데이트
    state = state!.copyWith(
      bookDetailDTO: state!.bookDetailDTO.copyWith(isWish: isWish.isWish),
    );
  }
}

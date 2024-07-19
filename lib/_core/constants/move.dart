import 'package:flutter/material.dart';
import 'package:shelf/ui/pages/home/home_page.dart';
import 'package:shelf/ui/pages/home/pages/best_seller_detail_page.dart';
import 'package:shelf/ui/pages/home/pages/brand_new_page.dart';
import 'package:shelf/ui/pages/mypage/mypage.dart';
import 'package:shelf/ui/pages/mypage/pages/myinfo/my_info.dart';
import 'package:shelf/ui/pages/mypage/pages/payment_management_page.dart';
import 'package:shelf/ui/pages/mypage/pages/profile_edit_page.dart';
import 'package:shelf/ui/pages/myshelf/my_shelf.dart';
import 'package:shelf/ui/pages/search/search_page.dart';
import 'package:shelf/ui/startview/start_view_page.dart';

class Move {
  static String startViewPage = "시작 영상 페이지";
  static String loginPage = "/login";
  static String joinPage = "/join";
  static String homePage = "메인 홈 페이지";
  static String bookDetailPage = "책 상세보기 페이지";
  static String sellerDetailPage = "/home/seller-detail";
  static String brandNewPage = "신간 코너 페이지";
  static String searchPage = "검색페이지";
  static String categoryResultPage = "카테고리 검색결과 페이지";
  static String writerResultPage = "작가검색 결과페이지";
  static String myShelfPage = "/myshelf";
  static String myPage = "나의 페이지";
  static String myInfo = "내 정보 페이지";
  static String profileEditPage = "내 정보 수정페이지";
  static String paymentManagementPage = "/my-page/payment_management";
}

Map<String, Widget Function(BuildContext)> getRouters() {
  return {
    Move.startViewPage: (context) => const StartViewPage(),
    Move.homePage: (context) => HomePage(),
    Move.sellerDetailPage: (context) => BestSellerDetailPage(),
    Move.searchPage: (context) => SearchPage(),
    Move.brandNewPage: (context) => BrandNewPage(),
    Move.myShelfPage: (context) => MyShelf(),
    Move.myPage: (context) => const MyPage(),
    Move.myInfo: (context) => const MyInfo(),
    Move.profileEditPage: (context) => const ProfileEditPage(),
    Move.paymentManagementPage: (context) => PaymentManagementPage(),
  };
}

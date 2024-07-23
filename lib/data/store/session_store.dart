import 'package:flutter/material.dart';
import 'package:flutter_naver_login/flutter_naver_login.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shelf/_core/constants/move.dart';
import 'package:shelf/data/dto/response_dto.dart';
import 'package:shelf/data/model/user/user.dart';
import 'package:shelf/data/model/user/user_request.dart';
import 'package:shelf/data/repository/user_repo.dart';
import 'package:shelf/main.dart';
import 'package:shelf/ui/pages/home/data/home_page_repo.dart';

import '../../_core/constants/http.dart';

class SessionUser {
  User? user;
  String? jwt;
  bool isLogin;

  SessionUser({
    this.user,
    this.jwt,
    this.isLogin = false,
  });

  SessionUser copyWith({
    User? user,
    String? jwt,
    bool? isLogin,
  }) {
    return SessionUser(
      user: user ?? this.user,
      jwt: jwt ?? this.jwt,
      isLogin: isLogin ?? this.isLogin,
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is SessionUser &&
        other.user == user &&
        other.jwt == jwt &&
        other.isLogin == isLogin;
  }

  @override
  int get hashCode => user.hashCode ^ jwt.hashCode ^ isLogin.hashCode;
}

// User Repository Provider
final userRepoProvider = Provider((ref) => UserRepo());

// Home Repository Provider
final homeRepoProvider = Provider((ref) => HomeRepo());

// 2. 창고
class SessionStore extends StateNotifier<SessionUser> {
  final UserRepo userRepository;
  SessionStore(this.userRepository) : super(SessionUser());

  final mContext = navigatorKey.currentContext;

  // 회원가입
  Future<void> join(JoinReqDTO joinReqDTO) async {
    ResponseDTO responseDTO = await userRepository.fetchJoin(joinReqDTO);

    logger.d("👉👉👉👉👉👉");
    logger.d(responseDTO.token);

    if (responseDTO.token != null) {
      await secureStorage.write(key: "accessToken", value: responseDTO.token);

      state = SessionUser(
          user: responseDTO.data, isLogin: true, jwt: responseDTO.token);

      Navigator.pushNamed(mContext!, Move.homePage);
    } else {
      ScaffoldMessenger.of(mContext!)
          .showSnackBar(SnackBar(content: Text(responseDTO.msg)));
    }
  }

  // 로그인
  Future<void> login(LoginReqDTO reqDTO) async {
    ResponseDTO responseDTO = await userRepository.fetchLogin(reqDTO);

    if (responseDTO.token != null) {
      await secureStorage.write(key: "accessToken", value: responseDTO.token);

      state = SessionUser(
          user: responseDTO.data, isLogin: true, jwt: responseDTO.token);

      Navigator.pushNamed(mContext!, Move.homePage);
    } else {
      ScaffoldMessenger.of(mContext!)
          .showSnackBar(SnackBar(content: Text(responseDTO.msg)));
    }
  }

  Future<void> naverLogin() async {
    try {
      final NaverLoginResult res = await FlutterNaverLogin.logIn();
      print("네이버로그인 성공 : ${res.toString()}");

      final NaverAccessToken nat = await FlutterNaverLogin.currentAccessToken;
      final naverAccessTokenoken = nat.accessToken;
      print("네이버 로그인 : ${naverAccessTokenoken}");

      // 토큰을 스프링 서버에 전달하기
      final response = await dio.get("/oauth/naver/callback",
          queryParameters: {"accessToken": naverAccessTokenoken});
      response.toString();

      // 토큰(스프링서버)의 토큰 응답받기
      final shelfAccessToken = response.headers["Authorization"]!.first;

      // 시큐어 스토리지에 저장
      await secureStorage.write(
          key: "shelfAccessToken", value: shelfAccessToken);

      // 상태 업데이트
      state = SessionUser(isLogin: true, jwt: shelfAccessToken);

      Navigator.pushNamed(mContext!, Move.homePage);
    } catch (error) {
      print('네이버 로그인 실패 ${error.toString()}');
      ScaffoldMessenger.of(mContext!).showSnackBar(
        SnackBar(
          backgroundColor: Colors.red,
          content: Text(error.toString()),
        ),
      );
    }
  }

  Future<void> updateAvatar(String avatar) async {
    if (state.user != null) {
      final updatedUser = state.user!.copyWith(avatar: avatar);
      state = state.copyWith(user: updatedUser);
    }
  }


  void logout() async {
    // 로그아웃 처리
    state = SessionUser(
      user: null,
      jwt: null,
      isLogin: false,
    );

    globalAccessToken = null;
    await secureStorage.delete(key: "shelfAccessToken");
    await secureStorage.delete(key: "accessToken");

    Navigator.pushNamedAndRemoveUntil(
        mContext!, Move.startViewPage, (route) => false);
  }
}

final sessionProvider = StateNotifierProvider<SessionStore, SessionUser>((ref) {
  return SessionStore(UserRepo());
});

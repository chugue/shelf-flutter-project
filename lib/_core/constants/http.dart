import 'package:dio/dio.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:logger/logger.dart';

// http 통신
// android 에뮬레이터에서 루트백주소는 10.0.2.2:8080
final baseURL = "http://10.0.2.2:8080";

final dio = Dio(
  BaseOptions(
    baseUrl: baseURL, // 내 IP 입력
    contentType: "application/json; charset=utf-8",
  ),
);

// 휴대폰 로컬에 파일로 저장
const secureStorage = FlutterSecureStorage();

String? globalAccessToken;
var logger = Logger();

// 인터셉터 생성
var interceptor = InterceptorsWrapper(
  onRequest: (options, handler) async {
    // /app으로 시작하는 경로에 대해서만 토큰 처리
    if (options.path.startsWith('/app')) {
      if (globalAccessToken != null) {
        options.headers["Authorization"] = "Bearer $globalAccessToken";
        logger.d("토큰이 추가된 요청: ${options.path}");
      } else {
        logger.d("토큰이 없습니다: ${options.path}");
      }
    } else {
      logger.d("토큰 처리 제외 경로: ${options.path}");
    }

    return handler.next(options);
  },
  onResponse: (response, handler) async {
    // 응답 처리
    return handler.next(response);
  },
  onError: (error, handler) {
    // 요청, 응답 오류 처리
    return handler.next(error);
  },
);

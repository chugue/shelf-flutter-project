import 'package:dio/dio.dart';
import 'package:shelf/_core/constants/http.dart';
import 'package:shelf/data/dto/response_dto.dart';
import 'package:shelf/data/model/user/user.dart';
import 'package:shelf/data/model/user/user_request.dart';

class UserRepo {
  Future<ResponseDTO> fetchJoin(JoinReqDTO requestDTO) async {
    try {
      // dynamic -> http body
      Response<dynamic> response =
          await dio.post("/user/join", data: requestDTO.toJson());

      ResponseDTO responseDTO = ResponseDTO.fromJson(response.data);
      responseDTO.data = User.fromJson(responseDTO.data);

      // 헤더에서 JWT 토큰 추출
      responseDTO.token = response.headers['authorization']?.first;

      logger.d("responseDTO ${responseDTO.token}");
      return responseDTO;
    } catch (e) {
      // 200이 아니면 catch로 감
      return ResponseDTO(code: -1, msg: "중복되는 유저명입니다");
    }
  }

  Future<ResponseDTO> fetchLogin(LoginReqDTO requestDTO) async {
    try {
      Response<dynamic> response =
          await dio.post("/user/login", data: requestDTO.toJson());

      ResponseDTO responseDTO = ResponseDTO.fromJson(response.data);
      responseDTO.data = User.fromJson(responseDTO.data);

      // 헤더에서 JWT 토큰 추출
      responseDTO.token = response.headers['Authorization']?.first;
      globalAccessToken = "Bearer ${responseDTO.token}";

      return responseDTO;
    } catch (e) {
      return ResponseDTO(code: -1, msg: "유저네임 혹은 비번이 틀렸습니다");
    }
  }
}

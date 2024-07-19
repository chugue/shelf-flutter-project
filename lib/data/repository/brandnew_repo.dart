import 'dart:convert';

import 'package:shelf/_core/constants/http.dart';

import '../dto/response_dto.dart';
import '../model/home/brandnew_dto.dart';

class BrandnewRepo {
  final String baseUrl;

  BrandnewRepo({required this.baseUrl});

  Future<BrandNewRespDTO> fetchBrandNewData(String registrationMonth) async {
    final response = await dio.get("/app/book/new", queryParameters: {'month': registrationMonth});

    ResponseDTO responseDTO = ResponseDTO.fromJson(response.data);

    if (response.statusCode == 200) {
      return BrandNewRespDTO.fromJson(responseDTO.data);
    } else {
      throw Exception('Failed to load brand new data');
    }
  }

}
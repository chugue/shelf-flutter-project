import 'dart:async';
import 'dart:convert';
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shelf/data/globals/avatar.dart';
import 'package:shelf/data/model/user/user.dart';
import 'package:shelf/ui/pages/mypage/_components/logout_button.dart';
import 'package:shelf/ui/pages/mypage/_components/next_purchase.dart';
import 'package:shelf/ui/pages/mypage/_components/sub_period.dart';
import '../../../../_core/constants/constants.dart';
import '../../../../_core/constants/size.dart';
import '../../../../_core/constants/style.dart';
import 'package:http/http.dart' as http;

import '../../../../data/store/profile_provider.dart';
import '../pages/payment_management_page.dart';

class UpperComponentSubscribed extends ConsumerWidget {
  final User user;

  UpperComponentSubscribed({required this.user});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final profile = ref.watch(profileProvider);

    return Container(
      padding: EdgeInsets.symmetric(horizontal: 15, vertical: 15),
      child: Column(
        children: [
          Row(
            children: [
              Padding(
                padding: const EdgeInsets.only(right: 10),
                child: CircleAvatar(
                  radius: 20,
                  backgroundImage: NetworkImage(profile.avatar.isNotEmpty ? profile.avatar : 'https://example.com/default_avatar.png'),
                ),
              ),
              SizedBox(height: 20, width: 5),
              Text(
                '${user.nickName} 님',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              Spacer(),
              LogoutButton(),
            ],
          ),
          SizedBox(height: 10),
          Container(
            decoration: BoxDecoration(
              border: Border.all(color: Color(0xffe6e6e6)),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  width: double.infinity,
                  height: gap_xxl,
                  decoration: BoxDecoration(
                    color: Color(0xffa179da),
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(10),
                      topRight: Radius.circular(10),
                    ),
                  ),
                  child: Container(
                    alignment: Alignment.centerLeft,
                    padding: EdgeInsets.symmetric(horizontal: 10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          '나의 정기구독',
                          style: h8(),
                        ),
                        GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => PaymentManagementPage(),
                              ),
                            );
                          },
                          child: Icon(
                            Icons.arrow_forward_ios,
                            color: TColor.white,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(height: 10),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                  alignment: Alignment.centerLeft,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        padding: EdgeInsets.symmetric(vertical: 5),
                        child: Row(
                          children: [
                            Text(
                              '전자책 월 정기구독',
                            ),
                            SizedBox(width: 5),
                            Container(
                              padding: EdgeInsets.symmetric(horizontal: 5, vertical: 2),
                              decoration: BoxDecoration(
                                  border: Border.all(color: Color(0xffe6e6e6), width: 1),
                                  borderRadius: BorderRadius.circular(5)),
                              child: Text("전차책 구독",
                                  style: TextStyle(
                                      color: Color(0xffababab), fontSize: 10)),
                            )
                          ],
                        ),
                      ),
                      SizedBox(height: 5),
                      Column(
                        children: [
                          SubPeriod(),
                          NextPurchase(),
                        ],
                      ),
                      SizedBox(height: 10),
                      SizedBox(
                        width: double.infinity,
                        child: FilledButton(
                          onPressed: () {
                            _showConfirmationDialog(context);
                          },
                          style: ButtonStyle(
                            backgroundColor: MaterialStateProperty.all<Color>(TColor.primaryColor1), // 버튼 배경 색상
                            foregroundColor: MaterialStateProperty.all<Color>(Colors.white),
                            shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                              RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(5.0), // 원하는 반경 값 설정
                              ),
                            ),
                          ),
                          child: Text('구독 해지'),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  void _showConfirmationDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('구독 해지'),
          content: Text('구독을 해지하시겠습니까?'),
          actions: [
            TextButton(
              child: Text('취소'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: Text('확인'),
              onPressed: () {
                Navigator.of(context).pop();
                handleUnschedulePayment(context);
              },
            ),
          ],
        );
      },
    );
  }

  Future<void> handleUnschedulePayment(BuildContext context) async {
    try {
      // 요청할 URL
      final url = Uri.parse('http://10.0.2.2:8080/app/unschedule');

      // 요청 본문 데이터
      final body = jsonEncode({
        'user_id': user.id,
      });

      // POST 요청 보내기
      final response = await http.post(
        url,
        headers: {'Content-Type': 'application/json'},
        body: body,
      );

      if (response.statusCode == 200) {
        // 성공 처리
        _showSuccessDialog(context); // 성공 메시지 표시
      } else {
        // 실패 처리
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('결제 해지에 실패했습니다. 서버 응답: ${response.body}')),
        );
      }
    } catch (e) {
      // 예외 처리
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('결제 해지 요청 중 오류가 발생했습니다.')),
      );
    }
  }

  void _showSuccessDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('구독 해지 완료'),
          content: Text('구독 해지가 완료되었습니다. 잔여 기간 2024.07.21 까지는 정상적인 이용이 가능합니다.'),
          actions: [
            TextButton(
              child: Text('확인'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }
}
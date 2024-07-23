import 'dart:convert';
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shelf/data/globals/avatar.dart';
import 'package:shelf/data/model/user/user.dart';
import 'package:shelf/ui/pages/mypage/_components/logout_button.dart';
import '../../../../_core/constants/constants.dart';
import '../../../../_core/constants/size.dart';
import '../../../../_core/constants/style.dart';
import '../../../../data/store/profile_provider.dart';
import '../pages/payment_management_page.dart';

class UpperComponent extends ConsumerWidget {
  final User user;

  UpperComponent({required this.user});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final profile = ref.watch(profileProvider);

    return Container(
      padding: EdgeInsets.symmetric(horizontal: gap_m, vertical: gap_m),
      color: Colors.white,
      child: Column(
        children: [
          Row(
            children: [
              Padding(
                padding: const EdgeInsets.only(right: gap_s),
                child: CircleAvatar(
                  radius: 20,
                  backgroundImage: NetworkImage(profile.avatar.isNotEmpty ? profile.avatar : 'https://example.com/default_avatar.png'),
                ),
              ),
              SizedBox(height: gap_xxxl, width: gap_s),
              Text(
                '${user.nickName} 님',
                style: h6(),
              ),
              Spacer(),
              LogoutButton(),
            ],
          ),
          SizedBox(height: gap_s),
          Container(
            decoration: BoxDecoration(
              border: Border.all(color: Colors.grey),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  width: double.infinity,
                  height: gap_xxl,
                  decoration: BoxDecoration(
                    color: Color(0xFFB48EEE),
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(8),
                      topRight: Radius.circular(8),
                    ),
                  ),
                  child: GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => PaymentManagementPage(),
                        ),
                      );
                    },
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
                          Icon(Icons.arrow_forward_ios, color: TColor.white),
                        ],
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 10),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 10),
                  alignment: Alignment.centerLeft,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'SHELF의 정기구독을 시작하세요',
                        style: p3(),
                      ),
                      SizedBox(height: 5),
                      Text(
                        '어려운 독서, 시작하면 습관이 됩니다.',
                        style: plainText(),
                      ),
                      SizedBox(height: 10),
                      SizedBox(
                        width: double.infinity,
                        child: FilledButton(
                          onPressed: () {}, // 이 부분은 필요에 따라 구현
                          style: ButtonStyle(
                            backgroundColor: MaterialStateProperty.all<Color>(TColor.primaryColor1), // 버튼 배경 색상
                            foregroundColor: MaterialStateProperty.all<Color>(Colors.white),
                            shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                              RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(5.0), // 원하는 반경 값 설정
                              ),
                            ),
                          ),
                          child: Text('구독 하기'),
                        ),
                      ),
                      SizedBox(height: 5)
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
}
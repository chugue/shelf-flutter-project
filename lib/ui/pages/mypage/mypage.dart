import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shelf/data/store/session_store.dart';
import 'package:shelf/ui/common/components/modified_bottom_navigation_bar.dart';
import 'package:shelf/ui/pages/mypage/_components/lower_component.dart';
import 'package:shelf/ui/pages/mypage/_components/upper_component_subscribed.dart';
import 'package:shelf/ui/pages/mypage/widgets/company_info.dart';
import 'package:shelf/ui/pages/mypage/widgets/contact_icons.dart';
import '../../../_core/constants/size.dart';
import '_components/upper_component.dart';

class MyPage extends ConsumerWidget {
  const MyPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final int _selectedIndex = 3;
    final session = ref.read(sessionProvider);


    return Scaffold(
      body: Container(
        child: ListView(
          children: [
            Padding(
              padding: const EdgeInsets.only(top: gap_l),
              child: session.user!.status
                  ? UpperComponentSubscribed()
                  : UpperComponent(),
            ),
            SizedBox(height: gap_m),
            LowerComponent(),
            SizedBox(height: gap_m),
            CompanyInfo(),
            ContactIcons(),
          ],
        ),
      ),
      bottomNavigationBar: ModifiedBottomNavigator(
        selectedIndex: _selectedIndex,
      ),
    );
  }
}

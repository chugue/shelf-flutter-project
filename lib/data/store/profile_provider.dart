import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

final profileProvider = StateNotifierProvider<ProfileNotifier, Profile>((ref) {
  return ProfileNotifier();
});


class Profile {
  final String name;
  final String password;
  final String phone;
  final String address;
  final String avatar;

  Profile({
    required this.name,
    required this.password,
    required this.phone,
    required this.address,
    required this.avatar,
  });

  Profile copyWith({
    String? name,
    String? password,
    String? phone,
    String? address,
    String? avatar,
  }) {
    return Profile(
      name: name ?? this.name,
      password: password ?? this.password,
      phone: phone ?? this.phone,
      address: address ?? this.address,
      avatar: avatar ?? this.avatar,
    );
  }
}

class ProfileNotifier extends StateNotifier<Profile> {

  ProfileNotifier()
      : super(Profile(
  name: '박선규',
  password: '1234',
  phone: '010-2897-2345',
  address: '부산광역시 금정구',
  avatar: 'assets/images/avatar1.png',
  )) {
  _loadProfile();
  }

  Future<void> _loadProfile() async {
  final prefs = await SharedPreferences.getInstance();
  state = Profile(
  name: prefs.getString('name') ?? '박선규',
  password: prefs.getString('password') ?? '1234',
  phone: prefs.getString('phone') ?? '010-2897-2345',
  address: prefs.getString('address') ?? '부산광역시 금정구',
  avatar: prefs.getString('avatar') ?? 'assets/images/avatar1.png',
  );
  }

  Future<void> saveProfile(Profile profile) async {
  final prefs = await SharedPreferences.getInstance();
  await prefs.setString('name', profile.name);
  await prefs.setString('password', profile.password);
  await prefs.setString('phone', profile.phone);
  await prefs.setString('address', profile.address);
  await prefs.setString('avatar', profile.avatar);
  state = profile;
  }

  void updateAvatar(String avatar) {
  state = state.copyWith(avatar: avatar);
  }
}

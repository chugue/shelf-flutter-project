import 'dart:io';
import 'dart:convert';
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shelf/_core/constants/http.dart';
import 'package:shelf/data/store/session_store.dart';
import '../../../../data/globals/avatar.dart';
import '../../../../data/store/profile_provider.dart';
import '../../../../_core/constants/size.dart';

class EditImage extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final profile = ref.watch(profileProvider);
    final profileNotifier = ref.read(profileProvider.notifier);
    final sessionUser = ref.watch(sessionProvider).user;
    final sessionUserNotifier = ref.read(sessionProvider.notifier);
    final avatarPath = getAvatarPath(sessionUser!.avatar);
    ImageProvider<Object>? _profileImage;

    // 프로필 이미지 경로에 따라 적절한 ImageProvider를 선택합니다.
    if (sessionUser.avatar.startsWith('assets/')) {
      _profileImage = AssetImage(avatarPath);
    } else if (sessionUser.avatar.startsWith('http')) {
      _profileImage = NetworkImage(baseURL + avatarPath);
    } else {
      try {
        _profileImage = AssetImage(avatarPath);
      } catch (e) {
        _profileImage = AssetImage('assets/images/default_avatar.png');
      }
    }

    Future<void> _pickImage(ImageSource source) async {
      final pickedFile = await ImagePicker().pickImage(source: source);
      if (pickedFile != null) {
        final base64Image = await imageFileToBase64(File(pickedFile.path));
        profileNotifier.updateAvatar(base64Image);
        sessionUserNotifier.updateAvatar(base64Image);
      }
    }

    void _showAvatarChooser() {
      showModalBottomSheet(
        context: context,
        builder: (BuildContext context) {
          return Padding(
            padding: const EdgeInsets.all(gap_sm),
            child: Container(
              height: 350,
              child: Column(
                children: [
                  ListTile(
                    title: Text('프로필 사진을 선택하세요'),
                    onTap: () => Navigator.of(context).pop(),
                  ),
                  Container(
                    height: 100,
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: avatarlist.length,
                      itemBuilder: (context, index) => Container(
                        width: 100,
                        padding: EdgeInsets.symmetric(horizontal: 10),
                        child: GestureDetector(
                          onTap: () async {
                            final newAvatar = avatarlist[index].values.first;
                            sessionUserNotifier.updateAvatar(newAvatar);
                            Navigator.of(context).pop();
                          },
                          child: Image.asset(avatarlist[index].values.first),
                        ),
                      ),
                    ),
                  ),
                  ListTile(
                    leading: Icon(Icons.photo_library),
                    title: Text('앨범에서 추가하기'),
                    onTap: () {
                      _pickImage(ImageSource.gallery);
                      Navigator.of(context).pop();
                    },
                  ),
                  ListTile(
                    leading: Icon(Icons.camera_alt),
                    title: Text('카메라 열기'),
                    onTap: () {
                      _pickImage(ImageSource.camera);
                      Navigator.of(context).pop();
                    },
                  ),
                ],
              ),
            ),
          );
        },
      );
    }

    return Align(
      alignment: Alignment.center,
      child: Stack(
        children: [
          CircleAvatar(
            radius: 75,
            backgroundColor: Colors.grey[300],
            backgroundImage: _profileImage,
          ),
          Positioned(
            bottom: 10,
            right: 10,
            child: FloatingActionButton(
              onPressed: _showAvatarChooser,
              mini: true,
              backgroundColor: Colors.white,
              child: Icon(
                Icons.edit,
                color: Colors.black,
              ),
            ),
          ),
        ],
      ),
    );
  }

  // 이미지 파일을 Base64 문자열로 인코딩
  Future<String> imageFileToBase64(File imageFile) async {
    Uint8List imageBytes = await imageFile.readAsBytes();
    return base64Encode(imageBytes);
  }
}

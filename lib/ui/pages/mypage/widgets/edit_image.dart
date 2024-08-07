import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shelf/data/globals/avatar.dart';

import '../../../../_core/constants/size.dart';

class EditImage extends StatefulWidget {
  @override
  _EditImageState createState() => _EditImageState();
}

class _EditImageState extends State<EditImage> {
  ImageProvider<Object>? _profileImage;
  List<Map<String, String>> avatars = avatarlist;

  Future<void> _pickImage(ImageSource source) async {
    final pickedFile = await ImagePicker().pickImage(source: source);
    if (pickedFile != null) {
      setState(() {
        _profileImage = FileImage(File(pickedFile.path));
      });
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
                    itemCount: avatars.length,
                    itemBuilder: (context, index) => Container(
                      width: 100,
                      padding: EdgeInsets.symmetric(horizontal: 10),
                      child: GestureDetector(
                        onTap: () {
                          setState(() {
                            _profileImage =
                                AssetImage(avatars[index].values.first);
                          });
                          Navigator.of(context).pop();
                        },
                        child: Image.asset(avatars[index].values.first),
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

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.center,
      child: Stack(
        children: [
          CircleAvatar(
            radius: 75,
            backgroundColor: Colors.grey[300],
            backgroundImage:
                _profileImage ?? AssetImage("assets/images/avatar1.png"),
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
}

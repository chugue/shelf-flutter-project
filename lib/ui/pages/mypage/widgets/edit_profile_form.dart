import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../../_core/constants/constants.dart';

class EditProfileForm extends StatefulWidget {
  @override
  _EditProfileFormState createState() => _EditProfileFormState();
}

class _EditProfileFormState extends State<EditProfileForm> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();
  final _phoneController = TextEditingController();
  final _addressController = TextEditingController();
  final String _userEmail = "psk@naver.com";

  @override
  void initState() {
    super.initState();
    _loadProfile();
  }

  @override
  void dispose() {
    _nameController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    _phoneController.dispose();
    _addressController.dispose();
    super.dispose();
  }

  Future<void> _loadProfile() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      _nameController.text = prefs.getString('name') ?? '박선규';
      _passwordController.text = prefs.getString('password') ?? '1234';
      _confirmPasswordController.text = prefs.getString('password') ?? '1234';
      _phoneController.text = prefs.getString('phone') ?? '010-2897-2345';
      _addressController.text = prefs.getString('address') ?? '부산광역시 금정구';
    });
  }

  Future<void> _saveProfile() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('name', _nameController.text);
    await prefs.setString('password', _passwordController.text);
    await prefs.setString('phone', _phoneController.text);
    await prefs.setString('address', _addressController.text);
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        children: [
          SizedBox(height: 20),
          Text(
            _userEmail,
            style: TextStyle(fontSize: 16, color: Colors.grey[600]),
          ),
          SizedBox(height: 20),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 10),
            child: TextFormField(
              controller: _nameController,
              decoration: InputDecoration(
                label: Text('닉네임'),
                hintText: '닉네임을 입력하세요',
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 10),
            child: TextFormField(
              controller: _passwordController,
              obscureText: true,
              decoration: InputDecoration(
                label: Text('비밀번호'),
                hintText: '비밀번호를 입력하세요',
              ),
              onChanged: (value) {
                setState(() {});
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 10),
            child: TextFormField(
              controller: _confirmPasswordController,
              obscureText: true,
              decoration: InputDecoration(
                label: Text('비밀번호 확인'),
                hintText: '비밀번호를 다시 입력하세요',
                suffixIcon: _passwordController.text.isNotEmpty &&
                    _confirmPasswordController.text.isNotEmpty
                    ? (_passwordController.text ==
                    _confirmPasswordController.text
                    ? Icon(Icons.check, color: Colors.green)
                    : Icon(Icons.close, color: Colors.red))
                    : null,
              ),
              onChanged: (value) {
                setState(() {});
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 10),
            child: TextFormField(
              controller: _phoneController,
              decoration: InputDecoration(
                label: Text('휴대폰번호'),
                hintText: '휴대폰번호를 입력하세요',
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 10),
            child: TextFormField(
              controller: _addressController,
              decoration: InputDecoration(
                label: Text('주소'),
                hintText: '주소를 입력하세요',
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 20),
            child: SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    _saveProfile();
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text('저장되었습니다.')),
                    );
                  }
                },
                child: Text('저장'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: kAccentColor2,
                  foregroundColor: TColor.white,
                  padding: EdgeInsets.symmetric(vertical: 15),
                  elevation: 10,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  textStyle: TextStyle(
                    fontSize: 16,
                  ),
                ),
              ),
            ),
          ),
          SizedBox(height: 30),
        ],
      ),
    );
  }
}

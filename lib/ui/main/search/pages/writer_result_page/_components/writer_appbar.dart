import 'package:flutter/material.dart';
import 'package:untitled/_core/constants/style.dart';

class WriterAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String? writerName;

  WriterAppBar({
    required this.writerName,
  });

  @override
  Size get preferredSize => Size.fromHeight(40);

  @override
  Widget build(BuildContext context) {
    return PreferredSize(
      preferredSize: Size.fromHeight(40),
      child: AppBar(
        leading: Icon(Icons.arrow_back),
        backgroundColor: Colors.white,
        centerTitle: true,
        title: Text(
          "#유발 하라리",
          style: h8(),
        ),
      ),
    );
  }
}
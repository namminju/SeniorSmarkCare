// /*APP 화면 위의 로고, 뒤로가기 위젯 */

import 'package:flutter/material.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final bool showBackButton;

  const CustomAppBar({super.key, this.showBackButton = true});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      leading: showBackButton
          ? IconButton(
              icon: const Icon(Icons.arrow_back),
              iconSize: 30.0,
              onPressed: () {
                Navigator.pop(context);
              },
            )
          : null,
      centerTitle: true,
      backgroundColor: Colors.transparent,
      elevation: 0,
      bottom: PreferredSize(
        preferredSize: const Size.fromHeight(200),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            //logo 누르면 main으로 돌아감
            GestureDetector(
              onTap: () {
                Navigator.pushNamedAndRemoveUntil(
                    context, '/', (route) => false);
              },
              child: Image.asset(
                'images/mainIcon.png',
                height: 80,
              ),
            ),
            GestureDetector(
              onTap: () {
                Navigator.pushNamedAndRemoveUntil(
                    context, '/', (route) => false);
              },
              child: Image.asset(
                'images/mainIcon_text.png',
                height: 35,
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Size get preferredSize =>
      const Size.fromHeight(kToolbarHeight + 80); // AppBar의 총 높이 설정
}

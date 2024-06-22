import 'package:flutter/material.dart';

class PageNavigationBigButton extends StatelessWidget {
  final String buttonText; // 버튼 텍스트
  final Widget nextPage; // 클릭 시 이동할 페이지

  PageNavigationBigButton({required this.buttonText, required this.nextPage});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor: const Color(0xFFFEB2B2),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
        elevation: 4, // 그림자 높이 조정
        minimumSize: const Size(240, 44), // 최소 크기 설정
      ),
      onPressed: () {
        // 클릭 시 nextPage로 이동
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => nextPage,
          ),
        );
      },
      child: Text(
        buttonText, // 외부에서 받은 버튼 텍스트 사용
        style: const TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.bold,
          color: Colors.black,
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import '../../widgets/PageNavigationBigButton.dart';
import 'package:frontend/screen/MyPage/Mypage.dart';

class NoticeDialog extends StatelessWidget {
  final String text;
  final VoidCallback? onConfirm;
  final String? nextPageName; // 다음 페이지 이름을 저장할 변수 추가

  const NoticeDialog(
      {Key? key, required this.text, this.onConfirm, this.nextPageName})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: Colors.white,
      content: SizedBox(
        width: 288,
        height: 256,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  '',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                const Text(
                  '',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                const Text(
                  '알림',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop(); // 팝업 닫기
                  },
                  child: const Text('X'),
                ),
              ],
            ),
            const Padding(
              padding: EdgeInsets.all(4),
            ),
            const Divider(),
            const Padding(
              padding: EdgeInsets.all(16),
            ),
            Text(
              text,
              textAlign: TextAlign.center,
              style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const Padding(
              padding: EdgeInsets.all(16),
            ),
            PageNavigationBigButton(
              buttonText: '확인',
              nextPage: const Mypage(), // MedicalHistory 페이지로 이동
            )
          ],
        ),
      ),
    );
  }
}

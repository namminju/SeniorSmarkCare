import 'package:flutter/material.dart';

class CloseDialog extends StatelessWidget {
  final String text;
  final VoidCallback? onConfirm;
  final String? nextPageName; // 다음 페이지 이름을 저장할 변수 추가

  const CloseDialog(
      {Key? key, required this.text, this.onConfirm, this.nextPageName})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: Colors.white,
      content: Container(
        width: 288,
        height: 256,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  '',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                Text(
                  '',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                Text(
                  '알림',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop(); // 팝업 닫기
                  },
                  child: Text('X'),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.all(4),
            ),
            Divider(),
            Padding(
              padding: const EdgeInsets.all(16),
            ),
            Text(
              text,
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            Padding(
              padding: const EdgeInsets.all(16),
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Color(0xFFFEB2B2),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
                elevation: 4, // 그림자 높이 조정
                minimumSize: Size(240, 44), // 최소 크기 설정
              ),
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text(
                '확인', // 외부에서 받은 버튼 텍스트 사용
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:my_app/layout/demo/trainer/trainer.dart';

void main() {
  runApp(TrainerIntroduction());
}

class TrainerIntroduction extends StatelessWidget {
  const TrainerIntroduction({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: _introductionPage(),
    );
  }
}

class _introductionPage extends StatelessWidget {
  const _introductionPage({super.key});

  @override
  Widget build(BuildContext context) {
    final trainers = _getAllTrainers();
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Profile",
          style: TextStyle(
            fontWeight: FontWeight.w600,
            color: Colors.white,
          ),
        ),
        backgroundColor: Colors.lightBlue,
      ),
      body: Container(
        padding: EdgeInsets.only(top: 10),
        child: ListView.builder(
          itemCount: trainers.length,
          itemBuilder: (context, index) {
            final trainer = trainers[index];
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Center(
                  child: Image.network(
                    trainer.imagePath,
                    height: 200,
                    fit: BoxFit.cover,
                  ),
                ),
                ListTile(
                  leading: Icon(Icons.arrow_forward_ios),
                  title: Text(
                    trainer.name,
                    style: commonTextStyle(),
                  ),
                  trailing: Text(
                    trainer.role,
                    style: commonTextStyle(),
                  ),
                ),
                ListTile(
                  leading: Icon(Icons.mail),
                  title: Text(
                    trainer.email,
                    style: commonTextStyle(),
                  ),
                ),
                ListTile(
                  leading: Icon(Icons.phone),
                  title: Text(
                    trainer.phoneNumber,
                    style: commonTextStyle(),
                  ),
                ),
                ListTile(
                  leading: Icon(Icons.document_scanner),
                  title: Text(
                    trainer.description,
                  ),
                  subtitle: Text("Câu nói yêu thích"),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}

List<Trainer> _getAllTrainers() {
  return [
    Trainer(
        "https://r2s.edu.vn/wp-content/uploads/2023/10/IMG_6940-963x1024.jpeg",
        "Lê Hồng Kỳ (Kỳ Lê)",
        "Trainer",
        "kyle@r2s.com.vn",
        "0855881889",
        "Một doanh nghiệp chỉ phát triển bền vững khi làm ăn chân chính, coi trọng đạo đức kinh doanh. Sự thành công của doanh nghiệp là kết quả của quá trình tận tuỵ phục vụ khách hàng, tạo niềm tin với dối tác, quan tâm đến nhân viên, và đóng góp thiết thực cho cộng đồng")
  ];
}

TextStyle commonTextStyle({
  FontWeight fontWeight = FontWeight.w600,
  Color color = Colors.blue,
}) {
  return TextStyle(
    fontWeight: fontWeight,
    color: color,
  );
}

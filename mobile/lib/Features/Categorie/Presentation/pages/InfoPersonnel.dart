import 'package:flutter/material.dart';
import 'package:mobile/Features/Auth/data/datasource/user_local_data_source.dart';
import 'package:mobile/Features/Auth/data/model/UserModelLogin.dart';
import 'package:mobile/injection_container.dart';

class InfoUser extends StatefulWidget {
  const InfoUser({super.key});

  @override
  State<InfoUser> createState() => _InfoUserState();
}

class _InfoUserState extends State<InfoUser> {
  final UserLocalDataSource userLocalDataSource = sl.get<UserLocalDataSource>();
  UserModelLogin? user = null;

  @override
  void initState() {
    this.getUser();
    super.initState();
  }

  getUser() async {
    var res = await userLocalDataSource.getCachedUser();
    if (res != null) {
      setState(() {
        user = res;
      });
      print(user);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Boycott & Stand with Palestine",
            style: TextStyle(color: Colors.black)),
        backgroundColor: Colors.white,
      ),
      body: SingleChildScrollView(child: Padding(
        padding: const EdgeInsets.all(15),
        child: Column(
          children: [
            Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const SizedBox(height: 5),
                  Text(user!.nom.toString() + " " + user!.prenom.toString(),
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                  const SizedBox(height: 2),
                  Text(user!.email.toString(), style: TextStyle(fontSize: 15)),
                ],
              ),
            ),
            const SizedBox(height: 20),
            const Text(
              "We stand in solidarity with Palestine!",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 30),
            Container(
              decoration: BoxDecoration(
                border: Border.all(
                  color: Colors.black,
                  width: 2,
                ),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.5),
                    spreadRadius: 5,
                    blurRadius: 7,
                    offset: Offset(0, 3),
                  ),
                ],
              ),
              child: Image.asset('images/suffer.jpg', width: 300),
            ),
            const SizedBox(height: 50),
            const Text(
              "اللهم العزيز الرحيم",
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 16, fontFamily: 'ArabicFont'),
            ),
            const Text(
              "نتوجه إليك في هذه الأوقات المليئة بالألم والصراع في فلسطين. امنح شعبنا القوة للاستمرار، والصبر لتحمل التحديات، والإيمان بمستقبل أفضل",
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 16, fontFamily: 'ArabicFont'),
            ),
            const Text(
              "نسألك، ربي، أن تهدي قادة العالم نحو السلام. أوح لهم حكمة في العثور على حلاً عادلاً ودائمًا لإنهاء معاناة الشعب الفلسطيني.",
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 16, fontFamily: 'ArabicFont'),
            ),
            const Text(
              "امنحنا القوة للبقاء متحدين في هذه الأوقات الصعبة. ساعدنا على دعم من هم في حاجة والمحافظة على كرامتنا كمسلمين.",
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 16, fontFamily: 'ArabicFont'),
            ),
            const Text(
              "نحن نؤمن برحمتك، يا الله، وبقدرتك على تغيير الأمور. لتسود العدالة، وتملك السلام، ويشرق الأمل على أرضنا الحبيبة. ",
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 16, fontFamily: 'ArabicFont'),
            ),
            const Text(
              "آمين",
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 16, fontFamily: 'ArabicFont'),
            ),
          ],
        ),
      ))
    );
  }
}

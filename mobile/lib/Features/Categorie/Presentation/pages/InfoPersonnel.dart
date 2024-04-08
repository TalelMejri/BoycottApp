import 'package:flutter/material.dart';
import 'package:com.talel.boycott/Features/Auth/data/datasource/user_local_data_source.dart';
import 'package:com.talel.boycott/Features/Auth/data/model/UserModelLogin.dart';
import 'package:com.talel.boycott/injection_container.dart';
import 'package:url_launcher/url_launcher.dart';

class InfoUser extends StatefulWidget {
  const InfoUser({super.key});

  @override
  State<InfoUser> createState() => _InfoUserState();
}

class _InfoUserState extends State<InfoUser> {
  final UserLocalDataSource userLocalDataSource = sl.get<UserLocalDataSource>();
  late UserModelLogin? user;

  @override
  void initState() {
    super.initState();
    getUser();
  }

  final Uri _url = Uri.parse('https://www.facebook.com/talel.mejri.140/');
  Future<void> _launchUrl() async {
    if (!await launchUrl(_url)) {
      throw Exception('Could not launch $_url');
    }
  }

  getUser() async {
    var res = await userLocalDataSource.getCachedUser();
    if (res != null) {
      setState(() {
        user = res;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            title: const Text("Boycott & Stand with Palestine",
                style: TextStyle(color: Colors.white)),
            backgroundColor: Colors.black),
        drawer: Drawer(
          child: Column(
            children: [
              const SizedBox(height: 20),
              ClipRRect(
                borderRadius: BorderRadius.circular(30),
                child: Image.asset("images/boycott.png", width: 120),
              ),
              const DrawerHeader(child: Text("BoycottBZ")),
              // Text(
              //   "Welcome " +
              //       user!.nom! +
              //       " " +
              //       user!.prenom!,
              //   style:
              //       const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              // ),
              const Text(
                "Thank You For Your Support ",
                style: TextStyle(fontSize: 18),
              ),
              const Spacer(),
              Padding(
                padding: const EdgeInsets.only(bottom: 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      "Created by Mejri Talel",
                      style: TextStyle(color: Colors.black, fontSize: 15),
                    ),
                    const SizedBox(width: 10),
                    IconButton(
                      onPressed: _launchUrl,
                      icon: const Icon(Icons.facebook),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        body: SingleChildScrollView(
            child: Padding(
          padding: const EdgeInsets.all(10),
          child: Column(
            children: [
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
                      offset: const Offset(0, 3),
                    ),
                  ],
                ),
                child: Image.asset('images/suffer.jpg', width: 300),
              ),
              const SizedBox(height: 10),
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
        )));
  }
}

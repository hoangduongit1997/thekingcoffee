import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:barcode_flutter/barcode_flutter.dart';
import 'package:thekingcoffee/src/app/core/components/lib/change_language/change_language.dart';
import 'package:thekingcoffee/src/app/core/components/widgets/draw_left/draw_left.dart';
import 'package:thekingcoffee/src/app/core/utils.dart';
import 'package:thekingcoffee/src/app/theme/styles.dart';

class EarnPoint extends StatefulWidget {
  _EarnPointState createState() => _EarnPointState();
}

class _EarnPointState extends State<EarnPoint> {
  int idUser;
  getIdUser() async {
    final pref = await SharedPreferences.getInstance();
    setState(() {
      idUser = pref.getInt('idUser');
    });
  }

  @override
  void initState() {
    getIdUser();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(allTranslations.text("your_code").toString(),
            style: StylesText.style20BrownBold),
        elevation: 0.5,
        backgroundColor: Colors.white,
        leading: FlatButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: Icon(
              Icons.arrow_back,
              color: Colors.brown,
            )),
      ),
      resizeToAvoidBottomInset: false,
      body: Center(
          child: Padding(
              padding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
              child: idUser == null
                  ? CircularProgressIndicator()
                  : BarCodeImage(
                      params: Code93BarCodeParams(
                        '$idUser',
                        lineWidth: 5.0,
                        barHeight: Dimension.getHeight(0.3),
                        withText: true,
                      ),
                      onError: (error) {
                        print('error = $error');
                      },
                    ))),
      drawer: Drawer(
        child: HomeMenu(),
      ),
    );
  }
}

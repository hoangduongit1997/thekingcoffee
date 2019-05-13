import 'package:flutter/material.dart';
import 'package:thekingcoffee/app/screens/map.dart';
import 'package:thekingcoffee/app/styles/styles.dart';
class Shopping_List extends StatefulWidget {
 Shopping_List({Key key}) : super(key: key);

   Shopping_ListState createState() =>  Shopping_ListState();
}

class  Shopping_ListState extends State <Shopping_List> {
  TextEditingController name=new TextEditingController(text: "Hoàng Dương");
  TextEditingController phone=new TextEditingController(text: "0798353751");
  TextEditingController address=new TextEditingController(text: "196/31/8, Tan Son Nhi");
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primaryColor: Colors.redAccent
      ),
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          centerTitle: true,
          title: Text("Your shopping list",style: StylesText.style18Black,),
        ),
        resizeToAvoidBottomInset: false,
        body:SingleChildScrollView(
            child: Container(
              color: Colors.white,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.all(5.0),
                    child: Text(
                      "Shipment Details",
                      style: StylesText.style18Black,
                    ),
                  ),
                   Padding(
                    padding: const EdgeInsets.all(5.0),
                    child: TextField(
                      decoration: InputDecoration(
                        icon: Icon(Icons.account_circle)
                      ),
                      controller: name,
                      style: StylesText.style16Brown,
                    )
                  ),
                   Padding(
                    padding: const EdgeInsets.all(5.0),
                    child: TextField(
                      decoration: InputDecoration(icon: Icon(Icons.phone)),
                      controller: phone,
                      style: StylesText.style16Brown,
                    )
                  ),
                  Padding(
                    padding: const EdgeInsets.all(5.0),
                    child: TextField(
                      onTap: (){
                        Navigator.push(context,  MaterialPageRoute(builder: (context) => MapPage()));
                      },
                       decoration: InputDecoration(icon: Icon(Icons.map)),
                      controller: address,
                      style: StylesText.style16Brown,
                    )
                  ),
                ],
              ),
            ),
        )
      ),
    );
  }
}
import 'package:flutter/material.dart';
import 'package:leansoft/screens/login_screen.dart';

import 'dart:io';
import 'package:odoo_rpc/odoo_rpc.dart';

main() async {
  runApp(MyApp());
}
/*void main(){
  runApp(MyApp());
}*/

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context){
    return MaterialApp(
      title:'Leansoft',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: LoginScreen(),
    );
  }
}
import 'package:flutter/material.dart';
import 'package:odoo_rpc/odoo_rpc.dart';
import 'package:leansoft/screens/login_screen.dart';

class ProductScreen extends StatefulWidget {
  const ProductScreen({Key? key}) : super(key: key);

  @override
  State<ProductScreen> createState() => _ProductScreenState();
}

class _ProductScreenState extends State<ProductScreen> {
  final client = OdooClient('https://ensa1.odoo.com');
  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: Text('Sales'),
        backgroundColor: Colors.blue[900],
      ),
      body: Center(
        child: FutureBuilder(
            future: data(),
            builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
              if (snapshot.hasData) {
                return ListView.builder(
                    itemExtent: 100.0,
                    itemCount: snapshot.data.length,
                    itemBuilder: (context, index) {
                      final record =
                      snapshot.data[index] as Map<String, dynamic>;
                      return ListTile(
                        leading: CircleAvatar(
                        backgroundColor: Colors.blue[900],
                        child: Text(record["id"].toString()),
                      ),
                        dense: true,
                        visualDensity: VisualDensity(vertical: 3),
                        title: Text(record['name']),
                        subtitle: Text(record['partner_id'][1].toString()),
                        trailing: Text(record['create_date']),
                      );
                    });
              } else {
                if (snapshot.hasError) return Text('Unable to fetch data');
                return CircularProgressIndicator();
              }
            }),
      ),
    );
  }
  Future<dynamic> data() async {
    final session = await client.authenticate(LoginScreen.dataController.text, LoginScreen.emailController.text, LoginScreen.passwordController.text);
    final uid = session.userId;
    var res = await client.callKw({
      'model': 'sale.order',
      'method': 'search_read',
      'args': [],
      'kwargs': {
        'context': {'bin_size': true},
        'domain': [
        ],
        'fields': ['id','name', 'create_date', 'partner_id', 'user_id'],
      },
    });
    return res;
    }
}
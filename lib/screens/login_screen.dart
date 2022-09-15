import 'package:flutter/material.dart';
import 'package:leansoft/screens/products_screen.dart';
import 'package:odoo_rpc/odoo_rpc.dart';
import 'package:fluttertoast/fluttertoast.dart';

class LoginScreen extends StatefulWidget {

  const LoginScreen({Key? key}) : super(key: key);
  static TextEditingController dataController = new TextEditingController();
  static TextEditingController emailController = new TextEditingController();
  static TextEditingController passwordController = new TextEditingController();

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {

  //key
  final _formKey = GlobalKey<FormState>();

  //odoo
  final orpc = OdooClient('https://ensa1.odoo.com/');


  @override
  Widget build(BuildContext context) {

    //data field

    final dataField = TextFormField(
      autofocus: false,
      controller: LoginScreen.dataController,
      validator: (value) {
        if(value!.isEmpty){
          return ("Please enter your database name");
        }
      },
      onSaved: (value)
      {
        LoginScreen.dataController.text = value!;
      },
      textInputAction: TextInputAction.next,
      decoration: InputDecoration(
        prefixIcon: Icon(Icons.storage),
        contentPadding: EdgeInsets.fromLTRB(20, 15, 20, 15),
        hintText: "odoo-db",
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),

        ),
      ),


    );
    //email field
    final emailField = TextFormField(
      autofocus: false,
      controller: LoginScreen.emailController,
      keyboardType: TextInputType.emailAddress,
      validator: (value) {
        if(value!.isEmpty){
          return ("Please enter your email");
        }
      },
      onSaved: (value)
      {
        LoginScreen.emailController.text = value!;
      },
      textInputAction: TextInputAction.next,
      decoration: InputDecoration(
        prefixIcon: Icon(Icons.mail),
        contentPadding: EdgeInsets.fromLTRB(20, 15, 20, 15),
        hintText: "Email",
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),

        ),
      ),


    );
    //password field
    final passwordField = TextFormField(
      autofocus: false,
      controller: LoginScreen.passwordController,
      obscureText: true,
      validator: (value) {
        if(value!.isEmpty){
          return ("Pssword is required for login");
        }
      },
      onSaved: (value)
      {
        LoginScreen.passwordController.text = value!;
      },
      textInputAction: TextInputAction.done,
      decoration: InputDecoration(
        prefixIcon: Icon(Icons.vpn_key),
        contentPadding: EdgeInsets.fromLTRB(20, 15, 20, 15),
        hintText: "Password",
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),

        ),
      ),


    );

    final loginButton = Material(
      elevation:5,
      borderRadius: BorderRadius.circular(30),
      color: Colors.blue[900],
      child: MaterialButton(
        padding: EdgeInsets.fromLTRB(20, 15, 20, 15),
        minWidth: MediaQuery.of(context).size.width,
        onPressed: () {
          signIn(LoginScreen.dataController.text, LoginScreen.emailController.text, LoginScreen.passwordController.text);
        },
        child: Text(
          "Login",
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 20, color: Colors.white, fontWeight: FontWeight.bold,
          ),

        ),
      ),
    );

    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: SingleChildScrollView(
          child: Container(
            color: Colors.white,
            child: Padding(
              padding: const EdgeInsets.all(36.0),
              child: Form(
                key: _formKey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    SizedBox(
                      height: 200,
                      child: Image.asset(
                        "assets/img.png",
                        fit: BoxFit.contain,
                      )
                    ),
                    SizedBox(height:45),
                    dataField,
                    SizedBox(height:25),
                    emailField,
                    SizedBox(height:25),
                    passwordField,
                    SizedBox(height:35),
                    loginButton,
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
  void signIn(String odoodb, String email, String password) async {
    print(odoodb);
    print('====================================');
    if (_formKey.currentState!.validate()) {
      await orpc
          .authenticate(odoodb, email, password)
          .then((value) =>{
            Fluttertoast.showToast(msg: "Login Successful"),
            Navigator.of(context).pushReplacement(
                MaterialPageRoute(builder: (context)=>ProductScreen())),

              })
          .catchError((e){
            Fluttertoast.showToast(msg: e!.message);

      });

    }
  }
}


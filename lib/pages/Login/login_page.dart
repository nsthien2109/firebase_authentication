import 'package:firebase_authentication/Services/authen_service.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class LoginPage extends StatefulWidget {

  Function? toggleScreen;
  LoginPage({this.toggleScreen});

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  late TextEditingController _emailController;
  late TextEditingController _passController;
  final formKey = GlobalKey<FormState>();


  @override
  void initState() {
    // TODO: implement initState
    _emailController = TextEditingController();
    _passController = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    _emailController.dispose();
    _passController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final _loginProvider = Provider.of<AuthService>(context);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(onPressed: (){}, icon: const Icon(Icons.arrow_back_ios_rounded,color: Colors.black,)),
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 20 , vertical: 15),
          child: Form(
            key: formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 15,),
                const Text("Welcome back", style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold)),
                const Text("Sign in to continue", style: TextStyle(fontSize: 18)),
                const SizedBox(height: 30,),
                TextFormField(
                  validator: (value) => value!.isEmpty ? "Please enter email" : null,
                  controller: _emailController,
                  decoration: InputDecoration(
                    suffixIcon : const Icon(Icons.mail_outline_rounded),
                    hintText: "Email or username",
                    label: const Text("Email or username"),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10)
                    )
                  ),
                ),
                const SizedBox(height: 30,),
                TextFormField(
                  validator: (value) => value!.length <= 6 ? "Password must longer 6 character" : null ,
                  controller: _passController,
                  obscureText: true,
                  decoration: InputDecoration(
                      suffixIcon : const Icon(Icons.remove_red_eye),
                      hintText: "Enter password",
                      label: const Text("Password"),
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10)
                      )
                  ),
                ),
                const SizedBox(height: 30,),
                Container(
                  width: double.infinity,
                  height: 60,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: Colors.green
                  ),
                  child: _loginProvider.isLoading ? ProgessBar() : TextButton(
                    onPressed: () async{
                      if(formKey.currentState!.validate()){
                        print("Email : " + _emailController.text);
                        print("Pass : " + _passController.text);
                        await _loginProvider.login(_emailController.text.trim(),_passController.text.trim());
                      }else{

                      }
                    },
                    child: const Text("Login",style: TextStyle(color: Colors.white,fontSize: 18),),
                  )
                ),
                const SizedBox(height: 30,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text("I dont have account"),
                    TextButton(onPressed: ()=> widget.toggleScreen!(), child: const Text("Register"))
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget ProgessBar(){
    return  Container(
          alignment: Alignment.center,
          child: const CircularProgressIndicator(
            color: Colors.orangeAccent,
            strokeWidth: 3,
          ),
        );
  }

}

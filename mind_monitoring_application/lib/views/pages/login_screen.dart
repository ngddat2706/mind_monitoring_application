import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../controllers/login_controller.dart';
import 'register_screen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

enum ButtonState { init, loading, done }

class _LoginScreenState extends State<LoginScreen> {
  DateTime pre_backpress = DateTime.now();
  bool isAnimating = true;
  ButtonState state = ButtonState.init;
  var _passwordError = ''.obs;
  var _nameError = ''.obs;
  var isHiddenPassword = true.obs;
  final LoginController controller = Get.find();
  bool remember = false;

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final isDone = state == ButtonState.done;
    final isStretched = isAnimating || state == ButtonState.init;

    return WillPopScope(
      onWillPop: () async {
        final timegap = DateTime.now().difference(pre_backpress);
        final cantExit = timegap >= Duration(seconds: 2);
        pre_backpress = DateTime.now();
        if (cantExit) {
          Get.closeAllSnackbars();
          Get.snackbar(
            "BrwS",
            "Nhấn lần nữa để thoát ứng dụng",
            isDismissible: true,
            duration: Duration(seconds: 2),
          );
          return false; // false will do nothing when back press
        } else {
          return true; // true will exit the app
        }
      },
      child: Scaffold(
          backgroundColor: Colors.white,
          body: SingleChildScrollView(
              keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
              child: Form(
                autovalidateMode: AutovalidateMode.onUserInteraction,
                child: Column(
                  children: [
// Tên ứng dụng
                    Container(
                      margin: EdgeInsets.only(left: 5, top: 150, right: 5),
                      child: Image.asset(
                        'assets/logo_app.png',
                        height: 90,
                      ),
                    ),
// Nhập tên đăng nhập
                    Container(
                      margin: EdgeInsets.only(left: 20, right: 20, top: 30),
                      padding: EdgeInsets.only(left: 20, right: 20),
                      width: width > 700 ? 450 : null,
                      height: _nameError.value == '' ? 50 : 70,
                      child:TextField(
                          controller: controller.userNameController,
                          style: TextStyle(
                            color: Color.fromARGB(255, 0, 8, 50),
                            fontSize: 15,
                          ),
                          onChanged: (value){
                            setState(() {
                              
                            });
                          },
                          decoration: InputDecoration(
                            prefixIcon: Icon(
                              Icons.account_circle_outlined,
                              color: Color.fromARGB(255, 0, 8, 50),
                            ),
                            labelText: "Enter your Username",
                            labelStyle: TextStyle(
                              color: Colors.grey[600],
                              fontSize: 15,
                            ),
                            border: InputBorder.none,
                            focusedErrorBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                    color: Color.fromARGB(255, 0, 8, 50))),
                            errorBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                    color: Color.fromARGB(255, 0, 8, 50))),
                            enabledBorder: OutlineInputBorder(
                                borderSide:
                                    BorderSide(color: Color(0xFFEEEEEE))),
                            focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                    color: Color.fromARGB(255, 0, 8, 50))),
                            filled: true,
                            suffixIcon: controller.userNameController.text.isNotEmpty
                                ? IconButton(
                                    onPressed: () {
                                      controller.userNameController.clear();
                                      setState(() {});
                                    },
                                    icon: Icon(
                                      Icons.cancel,
                                      color: Colors.grey,
                                    ),
                                  )
                                : null),
                          
                        ),
                    ),
// Mật khẩu
                    Container(
                      width: width > 700 ? 450 : null,
                      height: _passwordError.value == '' ? 50 : 70,
                      margin: EdgeInsets.only(left: 20, right: 20, top: 10),
                      padding: EdgeInsets.only(left: 20, right: 20),
                      child: Obx(
                        () => TextField(
                          controller: controller.passwordController,
                          style: TextStyle(
                            color: Color.fromARGB(255, 0, 8, 50),
                            fontSize: 15,
                          ),
                          decoration: InputDecoration(
                              prefixIcon: Icon(Icons.lock_outline_rounded,
                                  color: Color.fromARGB(255, 0, 8, 50)),
                              labelText: "Enter your Password",
                              labelStyle: TextStyle(
                                color: Colors.grey[600],
                                fontSize: 15,
                              ),
                              border: InputBorder.none,
                              focusedErrorBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                      color: Color.fromARGB(255, 0, 8, 50))),
                              errorBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                      color: Color.fromARGB(255, 0, 8, 50))),
                              enabledBorder: OutlineInputBorder(
                                  borderSide:
                                      BorderSide(color: Color(0xFFEEEEEE))),
                              focusedBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                      color: Color.fromARGB(255, 0, 8, 50))),
                              filled: true,
                              suffixIcon: InkWell(
                                onTap: () {
                                  isHiddenPassword.value =
                                      !isHiddenPassword.value;
                                },
                                child: Icon(
                                  isHiddenPassword.value
                                      ? Icons.visibility
                                      : Icons.visibility_off,
                                  color: Color.fromARGB(255, 0, 8, 50),
                                ),
                              )),
                          obscureText: isHiddenPassword.value,
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
// Đăng nhập
                    Container(
                        width: width > 700 ? 450 : null,
                        padding: const EdgeInsets.fromLTRB(40, 0, 40, 10),
                        child: AnimatedContainer(
                            duration: Duration(milliseconds: 500),
                            curve: Curves.easeIn,
                            height: 40,
                            width: state == ButtonState.init ? width : 50,
                            onEnd: () =>
                                setState(() => isAnimating = !isAnimating),
                            child: isStretched
                                ? ElevatedButton(
                                    onPressed: () async {
                                      FocusScope.of(context).unfocus();
                                        setState(() {
                                          state = ButtonState.loading;
                                        });
                                        if (await controller.checkLogin()) {
                                          if(remember){
                                            final preferences =
                                              await SharedPreferences
                                                  .getInstance();
                                          preferences.setString(
                                              'username',
                                              controller
                                                  .userNameController.text);
                                          preferences.setString(
                                              'password',
                                              controller
                                                  .passwordController.text);
                                          }
                                          setState(() {
                                            state = ButtonState.done;
                                          });

                                          Get.offNamed('/home');
                                        } else {
                                          setState(() {
                                            state = ButtonState.init;
                                          });
                                          Get.closeAllSnackbars();
                                          Get.snackbar(
                                            "Fail",
                                            "Login failed!",
                                            backgroundColor: Colors.red,
                                            colorText: Colors.white,
                                            isDismissible: true,
                                          );
                                        }
                                    },
                                    child: FittedBox(
                                      child: Text("LOGIN",
                                          style: TextStyle(
                                            fontSize: 17,
                                          )),
                                    ),
                                    style: ElevatedButton.styleFrom(
                                      primary: Color.fromARGB(255, 0, 8, 50),
                                    ))
                                : buildLoadingButton(isDone))),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Spacer(),
                        Checkbox(
                          activeColor: Color.fromARGB(255, 0, 8, 50),
                          value: remember,
                          onChanged: (value){
                            setState(() {
                              remember = !remember;
                            });
                          },
                        ),
                        InkWell(
                          onTap: (){
                            setState(() {
                              remember = !remember;
                            });
                          },
                          child: Text(
                            "Remember Me",
                            style: TextStyle(
                              color: Colors.grey,
                              fontSize: 15,
                            ),
                          ),
                        ),
                        Spacer(),
                        Text(
                          "No Account?",
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 15,
                          ),
                        ),
                        SizedBox(width: 5,),
                        TextButton(
                          onPressed: () {
                            Get.dialog(
                              Center(
                                  child: Stack(
                                children: [
                                  Container(
                                    constraints: BoxConstraints(maxWidth: 700, maxHeight: 500),
                                      margin: EdgeInsets.only(
                                          left: 5, right: 5, top: 40, bottom: 30),
                                      child: ClipRRect(
                                          borderRadius: BorderRadius.circular(20),
                                          child: RegisterScreen())),
                                ],
                              )),
                              barrierDismissible: false);
                          },
                          child: Text(
                            "REGISTER",
                            style: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.normal),
                          ),
                        ),
                        Spacer(),
                      ],
                    ),
                    SizedBox(height: 50,),
                    Container(
                      width: double.infinity,
                          height: MediaQuery.of(context).size.height-540,
                          padding: EdgeInsets.symmetric(horizontal: 10,vertical: 30),
                          color: Color.fromARGB(255, 38, 59, 65),
                          child: Column(
                            children: [
                              Text(
                                "Collect, Storage, Analysis, Extract and Predict information form your brainwave EEG data.",
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.normal),
                              ),
                              SizedBox(height: 5,),
                              Container(
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      DateTime.now().year.toString(),
                                      style: TextStyle(color: Colors.white),
                                    ),
                                    Text(
                                      " — KhaiND",
                                      style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                                    ),
                                  ],
                                ),)
                            ],
                          ),
                        )
                  ],
                ),
              ))),
    );
  }
}

Widget buildLoadingButton(bool isDone) {
  return Container(
    decoration: BoxDecoration(
      shape: BoxShape.circle,
      color: Color.fromARGB(255, 0, 8, 50),
    ),
    child: Center(
      child: isDone
          ? Icon(
              Icons.done,
              size: 30,
              color: Colors.white,
            )
          : CircularProgressIndicator(
              color: Colors.white,
            ),
    ),
  );
}

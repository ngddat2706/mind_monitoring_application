import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:status_alert/status_alert.dart';
import '../../controllers/home_controller.dart';
import '../../controllers/login_controller.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({Key? key}) : super(key: key);

  @override
  State<RegisterScreen> createState() =>
      _AddDeviceScreenState();
}

class _AddDeviceScreenState extends State<RegisterScreen> {
  ButtonState state = ButtonState.init;
  bool isAnimating = true;
  LoginController loginController = Get.find();
  @override
  void initState() {
    // TODO: implement initState
    loginController.nameRegisterController.clear();
    loginController.passwordRegisterController.clear();
    loginController.emailControler.clear();
    loginController.confirm.clear();
    loginController.emailControler.clear();
    super.initState();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isDone = state == ButtonState.done;
    final isStretched = isAnimating || state == ButtonState.init;
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 40,
        backgroundColor: Colors.white,
        automaticallyImplyLeading: false,
        leadingWidth: 0,
        title: Text(
          "REGISTER USER",
          style: TextStyle(
              color: Colors.black,
              fontSize: 22,
              fontWeight: FontWeight.bold),
        ),
      ),
      body: GestureDetector(
          onTap: (){
            FocusScope.of(context).unfocus();
          },
        child: SingleChildScrollView(
              keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
              child: Container(
                padding: EdgeInsets.symmetric(vertical: 20),
                color: Colors.white,
                
                child: Wrap(
                  runSpacing: 20,
                  children: [
                    Container(
                      margin: EdgeInsets.symmetric(horizontal: 14),
                      child: TextField(
                        readOnly: false,
                        textAlign: TextAlign.left,
                        controller: loginController.nameRegisterController,
                        maxLines: 1,
                        minLines: 1,
                        style: TextStyle(
                          color: Color.fromARGB(255, 0, 8, 50),
                          fontSize: 16,
                        ),
                        decoration: InputDecoration(
                            contentPadding: EdgeInsets.only(top: 2, bottom: 2, left: 10, right: 5),
                            labelText: "Username *",
                            labelStyle: TextStyle(
                              color: Colors.grey[600],
                              fontSize: 15,
                            ),
                            hintStyle: TextStyle(color: Colors.grey, fontSize: 16),
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
                            suffixIcon: loginController.nameRegisterController.text.isNotEmpty
                                ? IconButton(
                                    onPressed: () {
                                      loginController.nameRegisterController.clear();
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
                    Container(
                      margin: EdgeInsets.symmetric(horizontal: 14),
                      child: TextField(
                        readOnly: false,
                        textAlign: TextAlign.left,
                        controller: loginController.emailControler,
                        maxLines: 1,
                        minLines: 1,
                        style: TextStyle(
                          color: Color.fromARGB(255, 0, 8, 50),
                          fontSize: 16,
                        ),
                        keyboardType: TextInputType.emailAddress,
                        decoration: InputDecoration(
                            contentPadding: EdgeInsets.only(top: 2, bottom: 2, left: 10, right: 5),
                            hintText: "ex: abc@gmail.com",
                            labelText: "Email *",
                            labelStyle: TextStyle(
                              color: Colors.grey[600],
                              fontSize: 15,
                            ),
                            hintStyle: TextStyle(color: Colors.grey, fontSize: 16),
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
                            suffixIcon: loginController.emailControler.text.isNotEmpty
                                ? IconButton(
                                    onPressed: () {
                                      loginController.emailControler.clear();
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
                    Container(
                      margin: EdgeInsets.symmetric(horizontal: 14),
                      child: TextField(
                        readOnly: false,
                        textAlign: TextAlign.left,
                        controller: loginController.passwordRegisterController,
                        maxLines: 1,
                        minLines: 1,
                        style: TextStyle(
                          color: Color.fromARGB(255, 0, 8, 50),
                          fontSize: 16,
                        ),
                        decoration: InputDecoration(
                            contentPadding: EdgeInsets.only(top: 2, bottom: 2, left: 10, right: 5),
                            labelText: "Password *",
                            labelStyle: TextStyle(
                              color: Colors.grey[600],
                              fontSize: 15,
                            ),
                            hintStyle: TextStyle(color: Colors.grey, fontSize: 16),
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
                            suffixIcon: loginController.passwordRegisterController.text.isNotEmpty
                                ? IconButton(
                                    onPressed: () {
                                      loginController.passwordRegisterController.clear();
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
                    Container(
                      margin: EdgeInsets.symmetric(horizontal: 14),
                      child: TextField(
                        readOnly: false,
                        textAlign: TextAlign.left,
                        controller: loginController.confirm,
                        maxLines: 1,
                        minLines: 1,
                        style: TextStyle(
                          color: Color.fromARGB(255, 0, 8, 50),
                          fontSize: 16,
                        ),
                        decoration: InputDecoration(
                            contentPadding: EdgeInsets.only(top: 2, bottom: 2, left: 10, right: 5),
                            labelText: "Confirm Password *",
                            labelStyle: TextStyle(
                              color: Colors.grey[600],
                              fontSize: 15,
                            ),
                            hintStyle: TextStyle(color: Colors.grey, fontSize: 16),
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
                            suffixIcon: loginController.confirm.text.isNotEmpty
                                ? IconButton(
                                    onPressed: () {
                                      loginController.confirm.clear();
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
                    Container(
                      margin: EdgeInsets.symmetric(horizontal: 14),
                      child: TextField(
                        readOnly: false,
                        textAlign: TextAlign.left,
                        controller: loginController.fullName,
                        maxLines: 1,
                        minLines: 1,
                        style: TextStyle(
                          color: Color.fromARGB(255, 0, 8, 50),
                          fontSize: 16,
                        ),
                        decoration: InputDecoration(
                            contentPadding: EdgeInsets.only(top: 2, bottom: 2, left: 10, right: 5),
                            labelText: "Full Name *",
                            labelStyle: TextStyle(
                              color: Colors.grey[600],
                              fontSize: 15,
                            ),
                            hintStyle: TextStyle(color: Colors.grey, fontSize: 16),
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
                            suffixIcon: loginController.fullName.text.isNotEmpty
                                ? IconButton(
                                    onPressed: () {
                                      loginController.fullName.clear();
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
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Visibility(
                          visible: state == ButtonState.init,
                          child: Container(
                            height: 38,
                            width: 100,
                            child: ElevatedButton(
                              onPressed: () {
                                Get.back();
                              },
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.white,
                                foregroundColor: Colors.grey,),
                              child: Text(
                                "CLOSE",
                                style: TextStyle(color: Colors.black, fontSize: 15, fontWeight: FontWeight.normal),
                              ),
                            ),
                          ),
                        ),
                        Visibility(
                            visible: state == ButtonState.init,
                            child: SizedBox(
                              width: 20,
                            )),
                        AnimatedContainer(
                          duration: Duration(milliseconds: 500),
                          curve: Curves.easeIn,
                          height: 38,
                          width: state == ButtonState.init ? 100 : 50,
                          onEnd: () => setState(() => isAnimating = !isAnimating),
                          child: isStretched
                              ? ElevatedButton(
                                  onPressed: () async {
                                    FocusScope.of(context).unfocus();
                                    if(loginController.passwordRegisterController.text != loginController.confirm.text){
                                      Get.closeAllSnackbars();
                                          Get.snackbar(
                                            "Fail",
                                            "Password does not match",
                                            backgroundColor: Colors.red,
                                            colorText: Colors.white,
                                            isDismissible: true,
                                          );
                                      return;
                                    }
                                    setState(() {
                                          state = ButtonState.loading;
                                        });
                                      if(await loginController.register()){
                                        StatusAlert.show(
                                          context,
                                          duration: Duration(seconds: 1),
                                          subtitle: "Success!",
                                          configuration: IconConfiguration(icon: Icons.done, size: 60),
                                          maxWidth: 150,
                                        );
                                        setState(() {
                                          state = ButtonState.done;
                                        });
                                        Get.back();
                                      }else{
                                        StatusAlert.show(
                                          context,
                                          duration: Duration(seconds: 1),
                                          subtitle: "Failure!",
                                          configuration: IconConfiguration(icon: Icons.dangerous_outlined, size: 60),
                                          maxWidth: 150,
                                        );
                                        setState(() {
                                          state = ButtonState.init;
                                        });
                                      }
                                  },
                                  style: ElevatedButton.styleFrom(
                                      primary: Colors.indigo[900],),
                                  child: FittedBox(
                                    fit: BoxFit.scaleDown,
                                    child: Text(
                                      "SAVE",
                                      style: TextStyle(
                                          color: Colors.white, fontSize: 15),
                                    ),
                                  ),
                                )
                              : buildLoadingButton(isDone),
                        )
                      ],
                    ),
                  ],
                ),
              ),
            ),
      )
    );
  }
}

Widget buildLoadingButton(bool isDone) {
  return Container(
    decoration: BoxDecoration(
      shape: BoxShape.circle,
      color: Colors.indigo[900],
    ),
    child: Center(
      child: isDone
          ? Icon(
              Icons.done,
              size: 30,
              color: Colors.white,
            )
          : Container(
              height: 25,
              width: 25,
              child: CircularProgressIndicator(
                strokeWidth: 3.0,
                color: Colors.white,
              ),
            ),
    ),
  );
}

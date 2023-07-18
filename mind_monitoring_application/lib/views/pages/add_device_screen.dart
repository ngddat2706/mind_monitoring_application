import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:status_alert/status_alert.dart';

import '../../controllers/add_device_controller.dart';
import '../../controllers/home_controller.dart';

class AddDeviceScreen extends StatefulWidget {
  const AddDeviceScreen({Key? key}) : super(key: key);

  @override
  State<AddDeviceScreen> createState() =>
      _AddDeviceScreenState();
}

class _AddDeviceScreenState extends State<AddDeviceScreen> {
  ButtonState state = ButtonState.init;
  bool isAnimating = true;
  AddDeviceController addDeviceController = Get.put(AddDeviceController());
  @override
  void initState() {
    // TODO: implement initState
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
          "CREATE NEW DEVICE",
          style: TextStyle(
              color: Colors.indigo[900],
              fontSize: 18,
              fontWeight: FontWeight.bold),
        ),
      ),
      body: Obx(()=> GestureDetector(
          onTap: (){
            FocusScope.of(context).unfocus();
          },
        child: SingleChildScrollView(
              keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
              child: Container(
                color: Colors.white,
                height: MediaQuery.of(context).size.height-70,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    Container(
                      padding: EdgeInsets.only(top: 10, bottom: 5, left: 14),
                      child: Text(
                        "Name:",
                        style: TextStyle(color: Colors.black, fontSize: 18),
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.symmetric(vertical: 5, horizontal: 14),
                      child: TextField(
                        readOnly: false,
                        onChanged: (value) {
                          setState(() {});
                          addDeviceController.checkRegisterNameError();
                        },
                        textAlign: TextAlign.left,
                        controller: addDeviceController.name,
                        maxLines: 1,
                        minLines: 1,
                        style: TextStyle(
                          color: Colors.indigo[900],
                          fontSize: 16,
                        ),
                        decoration: InputDecoration(
                            contentPadding: EdgeInsets.only(top: 2, bottom: 2, left: 10, right: 5),
                            hintText: "Enter name",
                            errorText: addDeviceController.nameError.value==""
                              ?null
                              :addDeviceController.nameError.value,
                            hintStyle: TextStyle(color: Colors.grey, fontSize: 16),
                            border: InputBorder.none,
                            focusedErrorBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10),
                                    borderSide: BorderSide(color: Color(0xFF1A237E))),
                            enabledBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10),
                                    borderSide: BorderSide(color: Colors.grey)),
                            focusedBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10),
                                    borderSide: BorderSide(color: Color(0xFF1A237E))),
                            errorBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10),
                                    borderSide: BorderSide(color: Colors.grey)),
                            suffixIcon: addDeviceController.name.text.isNotEmpty
                                ? IconButton(
                                    onPressed: () {
                                      addDeviceController.name.clear();
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
                      padding: EdgeInsets.only(top: 10, bottom: 5, left: 14),
                      child: Text(
                        "Description:",
                        style: TextStyle(color: Colors.black, fontSize: 18),
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.symmetric(vertical: 5, horizontal: 14),
                      child: TextField(
                        readOnly: false,
                        onChanged: (value) {
                          setState(() {
                            
                          });
                        },
                        textAlign: TextAlign.left,
                        controller: addDeviceController.description,
                        maxLines: 10,
                        minLines: 1,
                        style: TextStyle(
                          color: Colors.indigo[900],
                          fontSize: 16,
                        ),
                        decoration: InputDecoration(
                            contentPadding: EdgeInsets.only(top: 2, bottom: 2, left: 10, right: 5),
                            hintText: "Enter description",
                            hintStyle: TextStyle(color: Colors.grey, fontSize: 16),
                            border: InputBorder.none,
                            focusedErrorBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10),
                                    borderSide: BorderSide(color: Color(0xFF1A237E))),
                            enabledBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10),
                                    borderSide: BorderSide(color: Colors.grey)),
                            focusedBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10),
                                    borderSide: BorderSide(color: Color(0xFF1A237E))),
                            errorBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10),
                                    borderSide: BorderSide(color: Colors.grey)),
                            suffixIcon: addDeviceController.description.text.isNotEmpty
                                ? IconButton(
                                    onPressed: () {
                                      addDeviceController.description.clear();
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
                      padding: EdgeInsets.only(top: 10, bottom: 5, left: 14),
                      child: Row(
                        children: [
                          Text(
                            "Status:",
                            style: TextStyle(color: Colors.black, fontSize: 18),
                          ),
                          SizedBox(width: 10,),
                          DropdownButton<String>(
                            value: addDeviceController.status.value,
                            borderRadius: BorderRadius.circular(10),
                            alignment: Alignment.center,
                            items: <String>['Active', 'Inactive']
                                .map<DropdownMenuItem<String>>((String value) {
                              return DropdownMenuItem<String>(
                                value: value,
                                child: Text(
                                  value,
                                  style: TextStyle(fontSize: 17),
                                ),
                              );
                            }).toList(),
                            // Step 5.
                            onChanged: (String? newValue) {
                              addDeviceController.status.value = newValue!;
                            },
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 40,),
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
                                  primary: Colors.grey,
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(15))),
                              child: Text(
                                "CLOSE",
                                style: TextStyle(color: Colors.white, fontSize: 15),
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
                                    if(!addDeviceController.checkRegisterNameError()){
                                      return;
                                    }
                                    if (state == ButtonState.init) {
                                      setState(() {
                                        state = ButtonState.loading;
                                      });
                                      if(await addDeviceController.addNewDevice()){
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
                                      Get.back();
                                    }
                                  },
                                  style: ElevatedButton.styleFrom(
                                      primary: Colors.blue[900],
                                      shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(15))),
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
                    SizedBox(height: 40,),
                  ],
                ),
              ),
            ),
      ),
      ),
    );
  }
}

Widget buildLoadingButton(bool isDone) {
  return Container(
    decoration: BoxDecoration(
      shape: BoxShape.circle,
      color: Colors.blue[900],
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

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../controllers/notification_controller.dart';

class NotificationScreen extends StatefulWidget {
  const NotificationScreen({Key? key}) : super(key: key);

  @override
  State<NotificationScreen> createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationScreen>
    with TickerProviderStateMixin {
  NotificationController notificationController = Get.put(NotificationController());
  late TabController _tabController;
  _showAlertDialog(BuildContext context) {
    showCupertinoModalPopup<void>(
      context: context,
      builder: (BuildContext context) => CupertinoAlertDialog(
        title: const Text('CONFIRM'),
        content: const Text('Viewed all notifications!'),
        actions: <CupertinoDialogAction>[
          CupertinoDialogAction(
            isDestructiveAction: true,
            onPressed: () {
              Navigator.pop(context);
            },
            child: const Text('Close'),
          ),
          CupertinoDialogAction(
            isDestructiveAction: false,
            onPressed: () async {
              // if (await notificationController.updateAllNotification()) {
              //   StatusAlert.show(
              //     context,
              //     duration: Duration(seconds: 1),
              //     subtitle: "Thành công!",
              //     configuration: IconConfiguration(icon: Icons.done, size: 60),
              //     maxWidth: 150,
              //   );
              // } else {
              //   StatusAlert.show(
              //     context,
              //     duration: Duration(seconds: 1),
              //     subtitle: "Thất bại!",
              //     configuration: IconConfiguration(
              //         icon: Icons.dangerous_outlined, size: 60),
              //     maxWidth: 150,
              //   );
              // }
             Navigator.pop(context);
            },
            child: const Text('Save'),
          ),
        ],
      ),
    );
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    notificationController.loadingScreen.value = false;
    notificationController.indexNotification.value = 0;
    _tabController = TabController(length: 2, vsync: this);
    _tabController.addListener(() {
      notificationController.indexNotification.value = _tabController.index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => DefaultTabController(
        length: 2,
        child: Scaffold(
          appBar: AppBar(
            toolbarHeight: 50,
            backgroundColor: Colors.white,
            automaticallyImplyLeading: false,
            elevation: 0,
            title: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SizedBox(
                  width: 40,
                  child: TextButton(
                    onPressed: () {
                      Get.back();
                    },
                    style: ButtonStyle(
                      overlayColor: MaterialStateProperty.all(Colors.white),
                      minimumSize: MaterialStateProperty.all(Size.zero),
                      foregroundColor: MaterialStateProperty.resolveWith<Color>(
                          (Set<MaterialState> states) {
                        if (states.contains(MaterialState.pressed))
                          return Colors.grey;
                        return Colors
                            .indigo[900]!; // Defer to the widget's default.
                      }),
                    ),
                    child: Tooltip(
                      message: "Back",
                      child: Icon(
                        Icons.arrow_back_ios,
                        size: 25,
                      ),
                    ),
                  ),
                ),
                Text(
                  "NOTIFICATION",
                  style: TextStyle(
                    color: Colors.indigo[900],
                    fontSize: 20,
                  ),
                ),
                TextButton(
                  onPressed: () {
                    _showAlertDialog(context);
                  },
                  style: ButtonStyle(
                    overlayColor: MaterialStateProperty.all(Colors.white),
                    minimumSize: MaterialStateProperty.all(Size.zero),
                    foregroundColor: MaterialStateProperty.resolveWith<Color>(
                        (Set<MaterialState> states) {
                      if (states.contains(MaterialState.pressed))
                        return Colors.grey;
                      return Colors
                          .indigo[900]!; // Defer to the widget's default.
                    }),
                  ),
                  child: Tooltip(
                    message: "Viewed all",
                    child: Icon(
                      Icons.assignment_turned_in_outlined,
                      size: 30,
                    ),
                  ),
                ),
              ],
            ),
          ),
          body: Column(
            children: [
              Container(
                width: double.infinity,
                padding: EdgeInsets.only(left: 5,right: 5),
                decoration: BoxDecoration(
                  color: Colors.white,
                ),
                child: Wrap(
                  spacing: 5,
                  children: [
                    Stack(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(right: 10, top: 10),
                          child: ChoiceChip(
                            label: Text("Unread"),
                            labelStyle: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.w500,
                                fontSize: 16),
                            selected: notificationController.indexNotification.value == 0,
                            selectedColor: Colors.blue[200],
                            onSelected: (value) {
                              _tabController.index = 0;
                            },
                          ),
                        ),
                        Positioned(
                          top: 5,
                          right: 5,
                          child: Container(
                            padding: EdgeInsets.all(4),
                            decoration: BoxDecoration(
                              color: Colors.red,
                              shape: BoxShape.circle
                            ),
                            child: Text(
                              "0",
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 16
                              ),
                            ),
                          ),
                        )
                      ],
                    ),
                    Stack(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(right: 10, top: 10),
                          child: ChoiceChip(
                            label: Text("All"),
                            labelStyle: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.w500,
                                fontSize: 16),
                            selected: notificationController.indexNotification.value == 1,
                            selectedColor: Colors.blue[200],
                            onSelected: (value) {
                              _tabController.index = 1;
                            },
                          ),
                        ),
                        Positioned(
                          top: 5,
                          right: 5,
                          child: Container(
                            padding: EdgeInsets.all(4),
                            decoration: BoxDecoration(
                              color: Colors.red,
                              shape: BoxShape.circle
                            ),
                            child: Text(
                              "2",
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 16
                              ),
                            ),
                          ),
                        )
                      ],
                    )
                  ],
                )),
              Expanded(
                child: TabBarView(
                  controller: _tabController,
                  children: [
                    ListNotificationFollowTab(false),
                    ListNotificationFollowTab(true),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  ListNotificationFollowTab(bool readedNotification) {
    Future<void> _refresh()async {
      notificationController.loadingScreen.value = true;
              await Future.delayed(Duration(milliseconds: 500));
              notificationController.loadingScreen.value = false;
      return Future.delayed(Duration(milliseconds: 0));
    }

    return RefreshIndicator(
                displacement: 100,
                onRefresh: _refresh,
                color: Colors.indigo[900],
      child: SingleChildScrollView(
                  physics: BouncingScrollPhysics(),
                  keyboardDismissBehavior:
                      ScrollViewKeyboardDismissBehavior.onDrag,
        child: Container(
                      child: notificationController.loadingScreen.value
                        ? Container(
                          height: MediaQuery.of(context).size.height-260,
                          child: Center(
                            child: CircularProgressIndicator(
                                color: Colors.indigo[900],
                              ),
                          ),
                        ):Container(
                          constraints: BoxConstraints(
                              minHeight: MediaQuery.of(context).size.height-100),
            child: ListView.builder(
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              itemCount: readedNotification
                  ? 2
                  : 0,
              itemBuilder: (context, index) {
                return Card(
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
                  shadowColor: Colors.indigo.withOpacity(0.4),
                  color: Colors.white,
                  elevation: 5.0,
                  child: Padding(
                    padding: const EdgeInsets.only(left: 10, right: 5),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Padding(
                              padding: readedNotification
                                  ? const EdgeInsets.symmetric(vertical: 15)
                                  : EdgeInsets.all(0),
                              child: Text("Thông báo " + 
                                (readedNotification
                                    ? index.toString()
                                    : (index + 4).toString()),
                                style: TextStyle(color: Colors.indigo[900]),
                              ),
                            ),
                            Spacer(),
                            Container(
                              child: readedNotification
                                  ? null
                                  : TextButton(
                                      onPressed: () async {
                                      },
                                      style: ButtonStyle(
                                        overlayColor:
                                            MaterialStateProperty.all(Colors.white),
                                        minimumSize:
                                            MaterialStateProperty.all(Size.zero),
                                        foregroundColor:
                                            MaterialStateProperty.resolveWith<Color>(
                                                (Set<MaterialState> states) {
                                          if (states.contains(MaterialState.pressed))
                                            return Colors.grey;
                                          return Colors
                                              .indigo[900]!; // Defer to the widget's default.
                                        }),
                                      ),
                                      child: Tooltip(
                                        message: "Đã xem",
                                        child: Icon(
                                          Icons.clear_rounded,
                                          size: 25,
                                        ),
                                      ),
                                    ),
                            ),
                          ],
                        ),
                        Text(
                          "Nội dung thông báo",
                          style: TextStyle(color: Colors.indigo[900]),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Text(
                         "Đang trong tình trạng ngủ",
                          style: TextStyle(color: Colors.indigo[900]),
                        ),
                        SizedBox(
                          height: 15,
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}

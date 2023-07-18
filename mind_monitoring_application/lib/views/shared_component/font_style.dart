import 'package:flutter/material.dart';

class CustomFontStyle{
  static String getDateAndTime(DateTime dateTime) {
    String date = "${dateTime.day < 10 ? '0' : ''}${dateTime.day}/${dateTime.month < 10 ? '0' : ''}${dateTime.month}/${dateTime.year}";

    String time = '${dateTime.hour < 10 ? '0' : ''}${dateTime.hour}:${dateTime.minute < 10 ? '0' : ''}${dateTime.minute}';
    return date + " - " + time;
  }
static Widget functionForAdmin(icon, name, childFunction, function) {
    return Container(
        margin: const EdgeInsets.all(10),
        alignment: Alignment.centerLeft,
        child: TextButton(
          onPressed: () {
            function();
          },
          style: TextButton.styleFrom(
            primary: Colors.indigo[300],
            backgroundColor: Colors.white,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15),
            ),
          ),
          child: Container(
            height: 40,
            padding:
                const EdgeInsets.only(left: 10, right: 10, top: 5, bottom: 5),
            child: Row(
              children: [
                icon,
                const SizedBox(
                  width: 20,
                ),
                Text(
                  name,
                  style: TextStyle(
                    fontSize: 20,
                    color: Colors.black,
                  ),
                ),
                const Spacer(),
                childFunction
              ],
            ),
          ),
        ));
  }

  static Widget buildLoadingButonHomeScreen(bool isDone) {
    return Container(
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: isDone ? Colors.green : Colors.indigo[900],
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

  static Widget indexInformationStation(icon, name, value) {
    return Container(
        padding: EdgeInsets.only(top: 5),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(bottom: 5),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Icon(
                    icon,
                    color: Colors.indigo[900],
                    size: 17,
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Container(
                    child: Text(
                      name,
                      style: TextStyle(
                        fontSize: 17,
                        color: Colors.indigo[900],
                      ),
                    ),
                  ),
// Địa chỉ trạm
                  Expanded(
                    child: Container(
                      alignment: Alignment.centerRight,
                      padding: EdgeInsets.only(left: 10),
                      child: Text(
                        value,
                        textAlign: TextAlign.end, // Điền địa chỉ vào
                        style: TextStyle(
                          fontSize: 17,
                          color: Colors.indigo[900],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Container(
              width: double.infinity,
              height: 0.5,
              color: Colors.grey[400],
            )
          ],
        ));
  }
}
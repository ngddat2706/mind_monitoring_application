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

  static Widget indexInformationStation(name, value) {
    return Container(
        margin: EdgeInsets.only(top: 2),
        color: Color.fromARGB(255, 0, 8, 50),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              padding: EdgeInsets.only(left: 8, top: 3, bottom: 3),
              width: 120,
              child: Text(
                name,
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ),
// Địa chỉ trạm
            Expanded(
              flex: 2,
              child: Container(
                padding: EdgeInsets.only(left: 8, top: 3, bottom: 3),
                decoration: BoxDecoration(
                  color: Colors.white,
                  border: Border.all(color: Color.fromARGB(255, 0, 8, 50))
                ),
                child: Text(
                  value,
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
              ),
            ),
          ],
        ));
  }
  static Widget indexInformationDevice(name, value) {
    return Container(
        margin: EdgeInsets.only(top: 2),
        color: Color.fromARGB(255, 0, 8, 50),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              padding: EdgeInsets.only(left: 8, top: 3, bottom: 3),
              width: 120,
              child: Text(
                name,
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ),
// Địa chỉ trạm
            Expanded(
              flex: 2,
              child: Container(
                padding: EdgeInsets.only(left: 8, top: 3, bottom: 3),
                decoration: BoxDecoration(
                  color: Colors.white,
                  border: Border.all(color: Color.fromARGB(255, 0, 8, 50))
                ),
                child: Text(
                  value,
                  style: TextStyle(
                    fontSize: 15,
                    color: Colors.grey[800],
                  ),
                ),
              ),
            ),
          ],
        ));
  }
}
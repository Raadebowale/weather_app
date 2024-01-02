import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:weather_app/controller/global_controller.dart';

class HeaderWidget extends StatefulWidget {
  const HeaderWidget({super.key});

  @override
  State<HeaderWidget> createState() => _HeaderWidgetState();
}

class _HeaderWidgetState extends State<HeaderWidget> {
  String city = "";
  String date = DateFormat(DateFormat.YEAR_MONTH_DAY).format(DateTime.now());
  // DateFormat("yMMMMd").format(DateTime.now());
  //  DateTime.now().toString();

  final GlobalController globalController = Get.put(
    GlobalController(),
    permanent: true,
  );
  @override
  initState() {
    getAddress(
      globalController.getLatitude().value,
      globalController.getLongitude().value,
    );
    super.initState();
  }

  getAddress(latt, long) async {
    List<Placemark> placemark = await placemarkFromCoordinates(latt, long);
    // print(placemark);
    Placemark place = placemark[0];
    setState(() {
      city = place.locality!;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      // crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          alignment: Alignment.topLeft,
          margin: const EdgeInsets.symmetric(
            horizontal: 20,
          ),
          child: Text(
            city,
            style: const TextStyle(
              fontSize: 35,
              height: 2,
            ),
          ),
        ),
        Container(
          alignment: Alignment.topLeft,
          margin: const EdgeInsets.only(
            left: 20,
            right: 20,
            bottom: 20,
          ),
          child: Text(
            date,
            style: TextStyle(
              fontSize: 14,
              color: Colors.grey[700],
              height: 1.5,
            ),
          ),
        ),
      ],
    );
  }
}

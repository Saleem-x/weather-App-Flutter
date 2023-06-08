import 'dart:developer';
import 'package:dio/dio.dart';
import 'package:geolocator/geolocator.dart';
import 'package:note_app/constents/constents.dart';
import 'package:http/http.dart' as http;

Dio dio = Dio();
@override
getMain() async {
  log('in maindb');
  // final result = await dio.get(domain);
  Position position = await Geolocator.getCurrentPosition(
      desiredAccuracy: LocationAccuracy.low, forceAndroidLocationManager: true);

  if (position != null) {
    log('lat${position.latitude},lng${position.longitude}');
    getcurrentcity(position);
  } else {
    log('no data');
  }
}

findposition() async {
  Position position = await Geolocator.getCurrentPosition(
      desiredAccuracy: LocationAccuracy.low, forceAndroidLocationManager: true);
  getcurrentcity(position);
  if (position != null) {
    log('lat${position.latitude},lng${position.longitude}');
  } else {
    log('no data');
  }
}

getcurrentcity(Position position) async {
  var uri =
      '${domain}lat=${position.latitude}&lon=${position.longitude}&appid=$apikey';
  var url = Uri.parse(uri);
  var response = await http.get(url);
  if (response.statusCode == 200) {
    var data = response;
    log(data.toString());
    // WhetherModel wh = WhetherModel.fromJson(response);

    // log(wh.toString());
  } else {
    return response.statusCode;
  }
}

getcityweather(String cityname) async {}

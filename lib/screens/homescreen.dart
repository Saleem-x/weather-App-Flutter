import 'dart:convert';
import 'dart:developer';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:note_app/constents/constents.dart';
import 'package:note_app/model/weather_model/weather_model.dart';
// import 'package:note_app/model/whether_model/whether_model.dart';
import 'package:note_app/widgets/climatewidget.dart';
import 'package:note_app/widgets/detailswidget.dart';
import 'package:note_app/widgets/iconcode.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  WeatherModel? weatherData;
  @override
  void initState() {
    getcurrentlocation();
    setState(() {});
    super.initState();
  }

  bool isLoaded = false;
  String cityname = '';

  final searchcontroller = TextEditingController();
  @override
  Widget build(BuildContext context) {
    log(isLoaded ? 'true' : 'false');
    final size = MediaQuery.of(context).size;
    return SafeArea(
      child: Scaffold(
          appBar: PreferredSize(
            preferredSize: const Size.fromHeight(100),
            child: Container(
              height: 60,
              width: double.infinity,
              decoration: const BoxDecoration(),
              child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    IconButton(
                      onPressed: () {},
                      icon: const Icon(
                        Icons.menu,
                        color: kwhite,
                      ),
                    ),
                    IconButton(
                      onPressed: () {
                        getcurrentlocation();
                        isLoaded = false;
                        setState(() {});
                      },
                      icon: const Icon(
                        Icons.location_on,
                        color: kwhite,
                      ),
                    ),
                  ]),
            ),
          ),
          backgroundColor: kbgcolor,
          body: Visibility(
            visible: isLoaded,
            replacement: const Center(child: CircularProgressIndicator()),
            child: Stack(
              children: [
                Column(
                  children: [
                    SizedBox(
                      height: 50,
                      child: Padding(
                          padding: const EdgeInsets.only(left: 20, right: 20),
                          child: CupertinoSearchTextField(
                            controller: searchcontroller,
                            onSubmitted: (value) {
                              isLoaded = false;
                              setState(() {
                                cityname = value;
                                getcityweather(cityname);
                                searchcontroller.clear();
                              });
                            },
                            placeholder: 'Search place',
                            prefixIcon: Icon(
                              CupertinoIcons.search,
                              color: kwhite.withOpacity(0.5),
                            ),
                          )),
                    ),
                    kheight50,
                    Text(
                      '${weatherData!.name}/ ${weatherData!.sys!.country}',
                      style: const TextStyle(
                          fontSize: 22, fontWeight: FontWeight.bold),
                    ),
                    kheight50,
                    Builder(builder: (context) {
                      String iconCode = weatherData!.weather![0].icon!;
                      Icon weatherIcon = getWeatherIcon(iconCode);
                      return Container(
                          height: 150,
                          width: 150,
                          decoration: const BoxDecoration(
                            color: Colors.transparent,
                          ),
                          child: weatherIcon);
                    }),
                    Text(
                      ' ${weatherData!.main!.temp!.toInt() - 271}°C',
                      style: const TextStyle(
                          fontSize: 30, fontWeight: FontWeight.bold),
                    ),
                    kheight10,
                    Text(
                      weatherData!.weather![0].description ?? '',
                      style: const TextStyle(
                        fontSize: 17,
                      ),
                    ),
                    kheight50,
                    Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          DetailsWidget(
                              title: DateTime.fromMillisecondsSinceEpoch(
                                      weatherData!.sys!.sunrise! * 1000)
                                  .toString(),
                              icon: Icons.sunny),
                          DetailsWidget(
                              title: DateTime.fromMillisecondsSinceEpoch(
                                      weatherData!.sys!.sunset! * 1000)
                                  .toString(),
                              icon: Icons.nightlight_round),
                        ]),
                    const Spacer(),
                    SizedBox(
                      height: size.height / 4,
                      child: ListView(
                        scrollDirection: Axis.horizontal,
                        children: [
                          ClimateWidget(
                            icon: Icons.wind_power,
                            title: 'wind speed',
                            value: weatherData!.wind!.speed!.toInt(),
                          ),
                          ClimateWidget(
                            icon: Icons.water_drop,
                            title: 'Humidity',
                            value: weatherData!.main!.humidity!.toInt(),
                          ),
                          ClimateWidget(
                            icon: Icons.power_input,
                            title: 'pressure',
                            value: weatherData!.main!.pressure!.toInt(),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                  ],
                ),
              ],
            ),
          )),
    );
  }

  getcurrentlocation() async {
    Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high,
        forceAndroidLocationManager: true);
    fetchWeatherData(position);
  }

  permission() async {
    LocationPermission permission = await Geolocator.checkPermission();
    log(permission.name);
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return Future.error('Location permissions are denied');
      }
    }
  }

  getcityweather(String cityname) async {
    final response =
        await http.get(Uri.parse('${domain}q=$cityname&appid=$apikey'));

    if (response.statusCode == 200) {
      var data = response.body;
      var decodedata = json.decode(data);

      setState(() {
        weatherData = WeatherModel.fromJson(decodedata);
        log(weatherData!.name.toString());
        isLoaded = true;
      });
    } else {
      return response.statusCode;
    }
  }

  Future<void> fetchWeatherData(Position position) async {
    final response = await http.get(Uri.parse(
        '${domain}lat=${position.latitude}&lon=${position.longitude}&appid=$apikey'));
    log('${domain}lat=${position.latitude}&lon=${position.longitude}&appid=$apikey');
    if (response.statusCode == 200) {
      final jsonMap = json.decode(response.body);
      setState(() {
        weatherData = WeatherModel.fromJson(jsonMap);
        log(weatherData!.name.toString());
        isLoaded = true;
      });
    }
  }
}

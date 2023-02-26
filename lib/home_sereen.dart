import 'dart:convert';

import 'package:himanish/Data/city_model.dart';
import 'package:himanish/Data/data_model.dart';
import 'package:intl/intl.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
class HomeScreen extends StatefulWidget {
  final String cityName;

  const HomeScreen({Key? key, required this.cityName}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _getData();
  }

  DataModel? dataFromAPI;
  CityModel? cityDataFromAPI;

  _getData() async {
    String url =
        "https://geocoding-api.open-meteo.com/v1/search?name=${widget.cityName}";
    http.Response res = await http.get(Uri.parse(url));
    cityDataFromAPI = CityModel.fromJson(json.decode(res.body));
    num latitude = cityDataFromAPI!.results![0].latitude!;
    num longitude = cityDataFromAPI!.results![0].longitude!;
    url =
        "https://api.open-meteo.com/v1/forecast?latitude=$latitude&longitude=$longitude&hourly=temperature_2m";
    res = await http.get(Uri.parse(url));
    dataFromAPI = DataModel.fromJson(json.decode(res.body));
    // debugPrint(dataFromAPI!.hourly!.time);
    _isLoading = false;
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.cityName),
      ),
      body: _isLoading
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : ListView.builder(
              scrollDirection: Axis.vertical,
              itemBuilder: (context, index) {
                DateTime temp =
                    DateTime.parse(dataFromAPI!.hourly!.time![index]);
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(DateFormat('dd-MM-yyyy HH:mm a').format(temp)),
                      const Spacer(),
                      Text(dataFromAPI!.hourly!.temperature2m![index]
                          .toString()),
                    ],
                  ),
                );
              },
              itemCount: dataFromAPI!.hourly!.time!.length,
            ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          debugPrint("Button is pressed");
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
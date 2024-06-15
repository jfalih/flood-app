
import 'dart:developer';

import 'package:flood/data/models/response_model.dart';
import 'package:flood/data/models/shcedule_model.dart';
import 'package:flood/data/services/network.dart';
import 'package:flood/ui/screens/receipt_screen.dart';
import 'package:flood/ui/widgets/custom_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:intl/intl.dart';

import '../../data/urls.dart';

class DetailScreen extends StatefulWidget {
  final String url;
  final int id;
  final String email;
  final String title;
  final String phone;
  final String address;
  final String description;
  final String latitude;
  final String longitude;
  final String label;

  const DetailScreen({
    Key? key,
    required this.id,
    required this.url,
    required this.email,
    required this.phone,
    required this.address,
    required this.latitude,
    required this.longitude,
    required this.title,
    required this.description,
    required this.label,
  });

  @override
  _DetailScreenState createState() => _DetailScreenState();
}

class _DetailScreenState extends State<DetailScreen> {
  bool _bookingLoading = false;

  @override
  void initState() {
    super.initState();
  }

  Future<void> booking() async {
    _bookingLoading = false;

    DateTime now = DateTime.now(); // Get the current date and time
    String formattedDate = DateFormat("d/m/y").format(now);
    Map<String, dynamic> requestBody = {
      "date": formattedDate,
    };
    
    final NetworkResponse response = await NetworkCaller().postRequest(Urls.bookingUrl(widget.id.toString()), requestBody);

    
    if (mounted) {
      setState(() {});
    }
    if (response.isSuccess) {
      if (mounted) {
          ScheduleResponse model = ScheduleResponse.fromJson(response.body!);
          Navigator.push(context,
            MaterialPageRoute(builder: (context) {
              return ReceiptScreen(id: model.data?.id ?? 0);
            }
          ));
      }
    } else {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Server error, Gagal booking donor!')));
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final bottomPadding = MediaQuery.of(context).padding.bottom;

    return Scaffold(
        appBar: AppBar(
          iconTheme: IconThemeData(color: Colors.black),
          title: Text("Place Detail",
              style: Theme.of(context)
                  .textTheme
                  .titleMedium!
                  .copyWith(color: Colors.black, fontWeight: FontWeight.bold)),
          backgroundColor: Colors.white,
          scrolledUnderElevation: 0.0, // <-- this
        ),
        body: Column(children: [
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Hero(
                      tag: 'place-${widget.id}',
                      child: Container(
                          child: Material(
                        child: Container(
                          width: double.infinity,
                          height: 350,
                          padding: const EdgeInsets.all(30),
                          decoration: BoxDecoration(
                            image: DecorationImage(
                              image: NetworkImage(widget.url),
                              fit: BoxFit.cover,
                              colorFilter: ColorFilter.mode(
                                  Colors.black.withOpacity(0.4),
                                  BlendMode.darken),
                            ),
                            borderRadius: const BorderRadius.only(
                                bottomLeft: Radius.circular(10),
                                bottomRight: Radius.circular(10)),
                            color: Colors.white,
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.end,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 20, vertical: 8),
                                decoration: BoxDecoration(
                                  color: Colors.red,
                                  borderRadius: BorderRadius.circular(20),
                                ),
                                child: Text(
                                  widget.label,
                                  style: TextStyle(color: Colors.white),
                                ),
                              ),
                              const SizedBox(height: 10),
                              Text(
                                widget.title,
                                style: const TextStyle(
                                    fontSize: 24,
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold),
                                    maxLines: 2,
                              overflow: TextOverflow.ellipsis),
                              const SizedBox(height: 10),
                              Text(widget.address,
                                  style: const TextStyle(
                                      fontSize: 18, color: Colors.white), overflow: TextOverflow.ellipsis),
                            ],
                          ),
                        ),
                      ))),
                  const SizedBox(height: 20),
                  SizedBox(
                    height: 50,
                    child: ListView(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      scrollDirection: Axis.horizontal,
                      children: [
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 30),
                          decoration: BoxDecoration(
                              color: const Color(0xFFEEEEEE),
                              borderRadius: BorderRadius.circular(30)),
                          child: Row(
                            children: [
                              Icon(Icons.email),
                              SizedBox(width: 20),
                              Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text("Email",
                                      style: Theme.of(context)
                                          .textTheme!
                                          .bodyLarge!
                                          .copyWith(
                                              fontWeight: FontWeight.bold)),
                                  Text(widget.email)
                                ],
                              )
                            ],
                          ),
                        ),
                        const SizedBox(width: 10),
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 30),
                          decoration: BoxDecoration(
                              color: const Color(0xFFEEEEEE),
                              borderRadius: BorderRadius.circular(30)),
                          child: Row(
                            children: [
                              Icon(Icons.phone),
                              SizedBox(width: 20),
                              Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text("Phone",
                                      style: Theme.of(context)
                                          .textTheme!
                                          .bodyLarge!
                                          .copyWith(
                                              fontWeight: FontWeight.bold)),
                                  Text(widget.phone)
                                ],
                              )
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 20),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 30),
                    child: Text("Deskripsi",
                        style: Theme.of(context)
                            .textTheme
                            .titleLarge!
                            .copyWith(fontWeight: FontWeight.bold)),
                  ),
                  const SizedBox(height: 5),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 30),
                    child: Text(widget.description),
                  ),
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 30, vertical: 20),
                    width: double.infinity,
                    height: 200,
                    child: IgnorePointer( child: FlutterMap(
                        options: MapOptions(
                          initialCenter:
                              LatLng(double.parse(widget.latitude), double.parse(widget.longitude)),
                          initialZoom: 11,
                        ),
                        children: [
                          openStreetMapTileLayer,
                          MarkerLayer(
                             markers: [
                              Marker(
                                width: 80.0,
                                height: 80.0,
                                point: LatLng(double.parse(widget.latitude), double.parse(widget.longitude)),
                                child: Container(
                                  child: Icon(
                                    Icons.location_on,
                                    color: Colors.red,
                                    size: 40.0,
                                  ),
                                ),
                              ),
                            ],
                          )
                        ])),
                  ),
                ],
              ),
            ),
          ),
          Container(
            width: double.infinity,
            padding: EdgeInsets.only(
                bottom: bottomPadding, left: 20, right: 20, top: 20),
            child: Visibility(
                  visible: _bookingLoading == false,
                  replacement: const Center(child: CircularProgressIndicator()),
                  child: CustomButton(
                    text: "Donor Sekarang",
                    onPress: () {
                      booking();
                    },
                  ),
                ),
            decoration: const BoxDecoration(
                border: Border(
              top: BorderSide(
                color: Color(0xFFEEEEEE), // Specify the color of the border
                width: 1.0, // Specify the width of the border
              ),
            )),
          )
        ]));
  }

  TileLayer get openStreetMapTileLayer => TileLayer(
        urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
        userAgentPackageName: 'dev.fleaflet.flutter_map.example',
      );
}

import 'dart:developer';
import 'dart:io';

import 'package:flood/data/models/login_model.dart';
import 'package:flood/data/models/response_model.dart';
import 'package:flood/ui/widgets/status_label.dart';
import 'package:flutter/material.dart';
import 'package:flood/data/models/receipt_model.dart';
import 'package:flood/data/services/network.dart';
import 'package:flood/data/urls.dart';
import 'package:flood/ui/widgets/custom_button.dart';
import 'package:flood/data/utils/auth_utils.dart';
import 'package:url_launcher/url_launcher.dart';

class ReceiptScreen extends StatefulWidget {
  final int id;

  const ReceiptScreen({super.key, required this.id});

  @override
  _ReceiptScreenState createState() => _ReceiptScreenState();
}

class _ReceiptScreenState extends State<ReceiptScreen> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  Data userInfo = AuthUtility.userInfo.data!;
  ReceiptModel _receiptModel = ReceiptModel();
  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    getReceipt();
  }

  Future<void> getReceipt() async {
    setState(() {
      isLoading = true;
    });

    final NetworkResponse response = await NetworkCaller().getRequest(Urls.receiptUrl(widget.id.toString()));

    if (response.isSuccess) {
      _receiptModel = ReceiptModel.fromJson(response.body!);
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Failed to load data!"),
        ),
      );
    }

    setState(() {
      isLoading = false;
    });
  }

  String _getMapUrl(double latitude, double longitude, String name, String address) {
    if (Platform.isIOS) {
      return 'maps:$latitude,$longitude?q=$name,$address';
    } else {
      return 'geo:$latitude,$longitude?q=$name';
    }
  }

  void _openMap() async {
    final latitude = _receiptModel.data?.place?.latitude ?? "";
    final longitude = _receiptModel.data?.place?.longitude ?? "";
    final name = _receiptModel.data?.place?.name ?? "";
    final address = _receiptModel.data?.place?.address ?? "";

    final mapUrl = _getMapUrl(double.parse(latitude), double.parse(longitude), name, address);
    log(mapUrl);

    if (await canLaunchUrl(Uri.parse(mapUrl))) {
      await launchUrl(Uri.parse(mapUrl));
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Could not open the map.')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        iconTheme: const IconThemeData(color: Colors.black),
        title: Text("Donor Detail",
            style: Theme.of(context)
                .textTheme
                .titleMedium!
                .copyWith(color: Colors.black, fontWeight: FontWeight.bold)),
        backgroundColor: Colors.white,
        scrolledUnderElevation: 0.0,
      ),
      body: Visibility(
        visible: !isLoading,
        child: Container(
          padding: EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("Hi ${userInfo.name}!", style: Theme.of(context).textTheme.bodyLarge!.copyWith(fontWeight: FontWeight.bold, fontSize: 18)),
              const SizedBox(height: 8),
              Text("Berikut ini detail pendaftaran donor kamu. Kami tunggu ditempat ya..! 😄"),
              const SizedBox(height: 20),
              Container(
                width: double.infinity,
                decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(20)),
                padding: EdgeInsets.all(20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("Donor Summary", style: Theme.of(context).textTheme.bodyLarge!.copyWith(fontWeight: FontWeight.bold)),
                    const SizedBox(height: 20),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text("Tanggal"),
                        Text(_receiptModel.data?.createdAt ?? "")
                      ],
                    ),
                    const SizedBox(height: 10),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text("Status"),
                        StatusLabel(status: _receiptModel.data?.status ?? "pending")
                      ],
                    ),
                    const SizedBox(height: 20),
                    const Divider(height: 0.5, color: Colors.black),
                    const SizedBox(height: 20),
                    Text("Place Detail", style: Theme.of(context).textTheme.bodyLarge!.copyWith(fontWeight: FontWeight.bold)),
                    const SizedBox(height: 8),
                    Row(
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(10),
                          child: Image.network(
                            "${Urls.assetUrl}${_receiptModel.data?.place?.image1}",
                            width: 90,
                            height: 80,
                            fit: BoxFit.cover,
                          ),
                        ),
                        const SizedBox(width: 8),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                _receiptModel.data?.place?.name ?? "",
                                overflow: TextOverflow.ellipsis,
                                maxLines: 2,
                              ),
                              Text(
                                _receiptModel.data?.place?.address ?? "",
                                overflow: TextOverflow.ellipsis,
                                maxLines: 2,
                              ),
                            ],
                          ),
                        )
                      ],
                    ),
                    const SizedBox(height: 10),
                    CustomButton(onPress: () => {
                      _openMap()
                    }, text: "Lihat Peta")
                  ],
                ),
              )
            ],
          ),
        ),
        replacement: Center(child: CircularProgressIndicator()), // Display this when isLoading is true
      ),
    );
  }
}

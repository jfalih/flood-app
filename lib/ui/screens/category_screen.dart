import 'package:flutter/material.dart';
import 'package:flood/data/models/detail_model.dart';
import 'package:flood/data/services/network.dart';
import 'package:flood/data/urls.dart';
import 'package:flood/ui/screens/detail_screen.dart';
import 'package:flood/ui/widgets/place_card.dart';

class CategoryScreen extends StatefulWidget {
  final int id;
  final String name;

  const CategoryScreen({
    Key? key,
    required this.id,
    required this.name,
  }) : super(key: key);

  @override
  _CategoryScreenState createState() => _CategoryScreenState();
}

class _CategoryScreenState extends State<CategoryScreen> {
  bool isLoading = false;
  DetailModel _detailModel = DetailModel();

  @override
  void initState() {
    super.initState();
    getDetail();
  }

  Future<void> getDetail() async {
    setState(() {
      isLoading = true;
    });

    final response = await NetworkCaller().getRequest(Urls.detailCategory(widget.id.toString()));

    if (response.isSuccess) {
      setState(() {
        _detailModel = DetailModel.fromJson(response.body!);
        isLoading = false;
      });
    } else {
      setState(() {
        isLoading = false;
      });
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Failed to load data!")),
      );
    }
  }
  @override
Widget build(BuildContext context) {
  return Scaffold(
    appBar: AppBar(
      title: Text(widget.name, style: TextStyle(color: Colors.black)),
      iconTheme: IconThemeData(color: Colors.black),
      centerTitle: false,
      backgroundColor: Colors.white,
      elevation: 0,
    ),
    body: Padding(
      padding: const EdgeInsets.all(8.0),
      child: RefreshIndicator(
        onRefresh: getDetail,
        child: isLoading
            ? const Center(child: CircularProgressIndicator())
            : _detailModel.data == null || _detailModel.data!.isEmpty
                ? Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.hourglass_empty, size: 50, color: Colors.grey),
                        SizedBox(height: 20),
                        Text(
                          "No items found.",
                          style: TextStyle(fontSize: 18, color: Colors.grey),
                        ),
                      ],
                    ),
                  )
                : GridView.builder(
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      crossAxisSpacing: 10.0,
                      mainAxisSpacing: 10.0,
                      childAspectRatio: 0.7, // Adjust aspect ratio as needed
                    ),
                    itemCount: _detailModel.data!.length,
                    itemBuilder: (context, index) {
                      var item = _detailModel.data![index];
                      return PlaceCard(
                        id: item.id ?? 0,
                        width: 100,
                        height: 200,
                        label: widget.name,
                        title: item.name ?? '',
                        subtitle: item.address ?? '',
                        imageUrl: "${Urls.assetUrl}${item.image1}",
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => DetailScreen(
                                id: item.id ?? 0,
                                email: item.email ?? "",
                                address: item.address ?? "",
                                title: item.name ?? "",
                                latitude: item.latitude ?? "",
                                phone: item.phone ?? "",
                                longitude: item.longitude ?? "",
                                url: "${Urls.assetUrl}${item.image1}",
                                description: item.description ?? 'Description',
                                label: widget.name,
                              ),
                            ),
                          );
                        },
                      );
                    },
                  ),
      ),
    ),
  );
}


}

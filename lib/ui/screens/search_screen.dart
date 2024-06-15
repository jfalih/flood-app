import 'package:flutter/material.dart';
import 'package:flood/data/models/search_model.dart';
import 'package:flood/data/services/network.dart';
import 'package:flood/data/urls.dart';
import 'package:flood/ui/screens/detail_screen.dart';
import 'package:flood/ui/widgets/place_card.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({Key? key}) : super(key: key);

  @override
  _SearchScreenState createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  bool isLoading = false;
  SearchModel _searchModel = SearchModel();
  TextEditingController _searchController = TextEditingController();
  String searchQuery = '';

  @override
  void initState() {
    super.initState();
    getAll();
  }

  Future<void> getAll() async {
    setState(() {
      isLoading = true;
    });

    final response = await NetworkCaller().getRequest(Urls.placesUrl);

    if (response.isSuccess) {
      setState(() {
        _searchModel = SearchModel.fromJson(response.body!);
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

  void filterSearchResults(String query) {
    setState(() {
      searchQuery = query;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: TextField(
          controller: _searchController,
          decoration: InputDecoration(
            hintText: 'Search...',
            border: InputBorder.none,
            hintStyle: TextStyle(color: Colors.grey),
            contentPadding: EdgeInsets.symmetric(vertical: 10.0),
          ),
          onChanged: (value) {
            filterSearchResults(value);
          },
        ),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.search),
            onPressed: () {
              filterSearchResults(_searchController.text);
            },
          ),
        ],
        iconTheme: IconThemeData(color: Colors.black),
        centerTitle: false,
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: RefreshIndicator(
          onRefresh: getAll,
          child: isLoading
              ? const Center(child: CircularProgressIndicator())
              : GridView.builder(
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: 10.0,
                    mainAxisSpacing: 10.0,
                    childAspectRatio: 0.7, // Adjust aspect ratio as needed
                  ),
                  itemCount: _searchModel.data
                      ?.where((item) => item.name!.toLowerCase().contains(searchQuery.toLowerCase()))
                      .length ?? 0,
                  itemBuilder: (context, index) {
                    var item = _searchModel.data
                        ?.where((item) => item.name!.toLowerCase().contains(searchQuery.toLowerCase()))
                        .toList()[index];
                    return PlaceCard(
                      id: item?.id ?? 0,
                      width: 100,
                      height: 200,
                      label: item?.category?.name ?? '',
                      title: item?.name ?? '',
                      subtitle: item?.address ?? '',
                      imageUrl: "${Urls.assetUrl}${item?.image1}",
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => DetailScreen(
                              id: item?.id ?? 0,
                              email: item?.email ?? "",
                              address: item?.address ?? "",
                              title: item?.name ?? "",
                              latitude: item?.latitude ?? "",
                              phone: item?.phone ?? "",
                              longitude: item?.longitude ?? "",
                              url: "${Urls.assetUrl}${item?.image1}",
                              description: item?.description ?? 'Description',
                              label: item?.category?.name ?? '',
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

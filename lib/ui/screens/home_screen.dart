import 'package:flood/data/models/carousel_model.dart';
import 'package:flood/data/models/category_model.dart';
import 'package:flood/data/models/response_model.dart';
import 'package:flood/data/models/search_model.dart';
import 'package:flood/data/services/network.dart';
import 'package:flood/data/urls.dart';
import 'package:flood/ui/screens/category_screen.dart';
import 'package:flood/ui/screens/detail_screen.dart';
import 'package:flood/ui/screens/search_screen.dart';
import 'package:flood/ui/widgets/custom_button.dart';
import 'package:flood/ui/widgets/custom_text_form_field.dart';
import 'package:flood/ui/widgets/icon_category.dart';
import 'package:flood/ui/widgets/place_card.dart';
import 'package:flood/ui/widgets/search_text_form_field.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:lottie/lottie.dart';
import 'package:animations/animations.dart'; // Import the animations package

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final List<String> items = List.generate(20, (index) => 'Item ${index + 1}');
  final List<CarouselModel> carousels = [
    CarouselModel(
        url:
            "https://plus.unsplash.com/premium_photo-1676325101744-ce4a45a331c7?q=80&w=2670&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D",
        title: "Share the Gift of Life!",
        description:
            "Donating blood is one of the simplest ways to make a big impact."),
    CarouselModel(
        url:
            "https://images.unsplash.com/photo-1615461065624-21b562ee5566?q=80&w=2840&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D",
        title: "Your Blood, Their Hope!",
        description: "Turn your kindness into hope for those in need."),
    CarouselModel(
        url:
            "https://images.unsplash.com/photo-1495653797063-114787b77b23?q=80&w=2670&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D",
        title: "Be a Hero, Donate Blood!",
        description:
            "Every drop counts. Become a hero by donating blood through our app.")
  ];
  final _searchController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  final List<Map<String, String>> places = [
    {
      'title': 'Place 1',
      'subtitle': 'Description of Place 1',
      'imageUrl': 'http://flood.asia/storage/images/17141922301.jpeg'
    },
    {
      'title': 'Place 2',
      'subtitle': 'Description of Place 2',
      'imageUrl': 'http://flood.asia/storage/images/17141922303.jpeg'
    },
    // Add more places as needed
  ];

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      getTask();
      getRecommendation();
    });
  }

  CategoryModel _categoryModel = CategoryModel();
  SearchModel _recommendationModel = SearchModel();
  bool isLoading = false;
  bool isLoadingRecommendation = false;

  Future<void> getTask() async {
    if (mounted) {
      setState(() {
        isLoading = true;
      });
    }

    final NetworkResponse response =
        await NetworkCaller().getRequest(Urls.categoryUrl);

    if (response.isSuccess) {
      _categoryModel = CategoryModel.fromJson(response.body!);
    } else {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text("Failed to load data!"),
          ),
        );
      }
    }
    if (mounted) {
      setState(() {
        isLoading = false;
      });
    }
  }

  Future<void> getRecommendation() async {
    if (mounted) {
      setState(() {
        isLoadingRecommendation = true;
      });
    }

    final NetworkResponse response =
        await NetworkCaller().getRequest(Urls.placesRecommendationUrl);

    if (response.isSuccess) {
      _recommendationModel = SearchModel.fromJson(response.body!);
    } else {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text("Failed to load data!"),
          ),
        );
      }
    }
    if (mounted) {
      setState(() {
        isLoadingRecommendation = false;
      });
    }
  }

  Widget getGridView() {
    if (_categoryModel.data == null || _categoryModel.data!.isEmpty) {
      return const Center(
        child: Text("No Data Found"),
      );
    }

    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 4, // Number of columns
        crossAxisSpacing: 10.0, // Horizontal spacing
        mainAxisSpacing: 10.0, // Vertical spacing
      ),
      padding: const EdgeInsets.all(20), // Adding padding for clarity
      itemCount: _categoryModel.data!.length, // Total number of items
      itemBuilder: (context, index) {
        final category = _categoryModel.data![index];
        return AnimationConfiguration.staggeredGrid(
          position: index,
          columnCount: 4,
          duration: const Duration(milliseconds: 375),
          child: FadeInAnimation(
            child: ScaleAnimation(
              child: SizedBox(
                height: 80,
                child: GestureDetector(
                    onTap: () {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) {
                        return CategoryScreen(
                            id: _categoryModel.data![index].id!,
                            name: _categoryModel.data![index].name!);
                      }));
                    },
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          alignment: Alignment.center,
                          height: 60,
                          width: 60,
                          decoration: BoxDecoration(
                            color: Colors.red[(index % 9 + 1) * 100],
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: IconCategory(iconName: category.icon ?? ""),
                        ),
                        Text(
                          category.name ?? 'No Name',
                          style: Theme.of(context).textTheme.labelSmall!.copyWith(fontSize: 10, fontWeight: FontWeight.w500),
                          textAlign: TextAlign.center,
                        ),
                      ],
                    )),
              ),
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
        onWillPop: null,
        child: Scaffold(
            appBar: AppBar(
              backgroundColor: const Color.fromRGBO(250, 250, 250, 1),
              automaticallyImplyLeading: false,
              title: Row(
                children: [
                  Image.asset("assets/images/flood.png",
                      width: 100, fit: BoxFit.contain),
                ],
              ),
              centerTitle: false,
              elevation: 0,
              actions: [
                Container(
                  margin: const EdgeInsets.all(0),
                  child: IconButton(
                      icon: const Icon(Icons.search),
                      iconSize: 25.0,
                      color: Colors.black,
                      onPressed: () => {
                            Navigator.push(context,
                                MaterialPageRoute(builder: (context) {
                              return const SearchScreen();
                            }))
                          }),
                ),
              ],
            ),
            body: SingleChildScrollView(
              padding: EdgeInsets.only(bottom: 40),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 20),
                  CarouselSlider(
                    options: CarouselOptions(height: 180.0, autoPlay: true),
                    items: carousels.map((item) {
                      return Builder(
                        builder: (BuildContext context) {
                          return Container(
                              padding: const EdgeInsets.all(20),
                              alignment: Alignment.bottomLeft,
                              width: MediaQuery.of(context).size.width,
                              margin:
                                  const EdgeInsets.symmetric(horizontal: 5.0),
                              decoration: BoxDecoration(
                                  color: Colors.grey,
                                  image: DecorationImage(
                                    image: NetworkImage(item.url),
                                    fit: BoxFit.cover,
                                    colorFilter: ColorFilter.mode(
                                        Colors.black.withOpacity(0.4),
                                        BlendMode.darken),
                                  ),
                                  borderRadius: BorderRadius.circular(10)),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.end,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    item.title,
                                    style: const TextStyle(
                                        fontSize: 16.0,
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  SizedBox(height: 10),
                                  Text(
                                    item.description,
                                    style: const TextStyle(
                                        fontSize: 12.0, color: Colors.white),
                                  )
                                ],
                              ));
                        },
                      );
                    }).toList(),
                  ),
                  const SizedBox(height: 20),
                  Container(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: Text("Kategori",
                          style: Theme.of(context)
                              .textTheme
                              .titleMedium!
                              .copyWith(
                                  fontWeight: FontWeight.bold, fontSize: 20))),
                  getGridView(),
                  Container(
                    padding: EdgeInsets.all(20),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: Colors.white),
                    margin: EdgeInsets.symmetric(horizontal: 20),
                    child: Row(children: [
                      Lottie.asset("assets/lottie/donation.json",
                          width: 100, height: 100, fit: BoxFit.contain),
                      SizedBox(width: 10),
                      Expanded(
                        child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text("Jadi Pendonor?",
                                  style: Theme.of(context)
                                      .textTheme
                                      .titleMedium!
                                      .copyWith(fontWeight: FontWeight.bold)),
                              Text(
                                  "Tahukah kamu dengan menjadi pendonor aktif, jantung kamu jadi lebih sehat?",
                                  style: Theme.of(context).textTheme.bodySmall),
                              SizedBox(height: 10),
                              CustomButton(
                                  onPress: () => {
                                        Navigator.push(context,
                                            MaterialPageRoute(
                                                builder: (context) {
                                          return const SearchScreen();
                                        }))
                                      },
                                  height: 40,
                                  text: "Donor Sekarang"),
                            ]),
                      )
                    ]),
                  ),
                  const SizedBox(height: 20),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Text("Tempat Terdekat",
                        style: Theme.of(context)
                            .textTheme
                            .titleMedium!
                            .copyWith(
                                fontWeight: FontWeight.bold, fontSize: 20)),
                  ),
                  const SizedBox(height: 20),
                  isLoadingRecommendation
                      ? Center(child: CircularProgressIndicator())
                      : SizedBox(
                          height: 280,
                          child: ListView.builder(
                            scrollDirection: Axis.horizontal,
                            itemCount: _recommendationModel.data?.length ?? 0,
                            padding: EdgeInsets.symmetric(horizontal: 20),
                            itemBuilder: (context, index) {
                              var place = _recommendationModel.data![index];
                              return Padding(
                                padding: const EdgeInsets.only(right: 10),
                                child: PlaceCard(
                                  id: index,
                                  width: 200,
                                  label: place.category!.name!,
                                  onTap: () => Navigator.push(context,
                                      MaterialPageRoute(builder: (context) {
                                    return DetailScreen(
                                      id: index,
                                      address: place.address ?? "",
                                      email: place.email ?? "",
                                      latitude: place.latitude ?? "",
                                      longitude: place.longitude ?? "",
                                      phone: place.phone ?? "",
                                      url: "${Urls.assetUrl}${place.image1!}",
                                      title: place.name!,
                                      description: place.description!,
                                      label: place.category!.name!,
                                    );
                                  })),
                                  title: place.name!,
                                  subtitle: place.address!,
                                  imageUrl: "${Urls.assetUrl}${place.image1!}",
                                ),
                              );
                            },
                          ),
                        )
                ],
              ),
            )));
  }
}

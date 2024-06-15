import 'package:flood/ui/screens/receipt_screen.dart';
import 'package:flood/ui/widgets/status_label.dart';
import 'package:flutter/material.dart';
import 'package:flood/data/models/history_model.dart';
import 'package:flood/data/services/network.dart';
import 'package:flood/data/urls.dart';

class HistoryScreen extends StatefulWidget {
  const HistoryScreen({super.key});

  @override
  _HistoryScreenState createState() => _HistoryScreenState();
}

class _HistoryScreenState extends State<HistoryScreen> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  bool isLoading = false;
  List<SubmissionData>? historyData;
  String filter = "all";

  int pendingCount = 0;
  int allCount = 0;
  int activeCount = 0;
  int expiredCount = 0;

  @override
  void initState() {
    super.initState();
    getDetail();
  }

  Future<void> getDetail() async {
    setState(() {
      isLoading = true;
    });

    final response = await NetworkCaller().getRequest(Urls.historyUrl);

    if (response.isSuccess) {
      HistoryModel historyModel = HistoryModel.fromJson(response.body!);
      setState(() {
        historyData = historyModel.data;
        isLoading = false;

        pendingCount = historyModel.data?.where((item) => item.status == "pending").length ?? 0;
        allCount = historyModel.data?.length ?? 0;
        activeCount = historyModel.data?.where((item) => item.status == "active").length ?? 0;
        expiredCount = historyModel.data?.where((item) => item.status == "expired").length ?? 0;

        if (filter != "all") {
          historyData = historyData?.where((item) => item.status == filter).toList();
        }
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

  void updateFilter(String status) {
    setState(() {
      filter = status;
      getDetail();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      backgroundColor: Colors.white,
      body: SafeArea(child:  Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            decoration: BoxDecoration(
              color: Colors.white,
              border: Border(
                bottom: BorderSide(width: 2, color: Color(0xFFEEEEEE)),
              ),
            ),
            child: Padding(
              padding: const EdgeInsets.only(left: 20, right: 20, bottom: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  GestureDetector(
                    onTap: () => updateFilter("all"),
                    child: _buildStatusIndicator(
                      Icons.all_inbox, "All", allCount, active: filter == "all",
                    ),
                  ),
                  GestureDetector(
                    onTap: () => updateFilter("pending"),
                    child: _buildStatusIndicator(
                      Icons.timer, "Pending", pendingCount, active: filter == "pending",
                    ),
                  ),
                  GestureDetector(
                    onTap: () => updateFilter("active"),
                    child: _buildStatusIndicator(
                      Icons.play_arrow, "Active", activeCount, active: filter == "active",
                    ),
                  ),
                  GestureDetector(
                    onTap: () => updateFilter("expired"),
                    child: _buildStatusIndicator(
                      Icons.lock_clock, "Expired", expiredCount, active: filter == "expired",
                    ),
                  ),
                ],
              ),
            ),
          ),
          Expanded(
            child:
            Container(
              color: Colors.white30,
              child:
             isLoading
                ? Center(child: CircularProgressIndicator())
                : historyData == null || historyData!.isEmpty
                    ? Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(Icons.info, size: 50, color: Colors.grey),
                            SizedBox(height: 10),
                            Text("No data available", style: TextStyle(fontSize: 16, color: Colors.grey)),
                          ],
                        ),
                      )
                    : ListView.builder(
                        itemCount: historyData!.length,
                        itemBuilder: (context, index) {
                          final submission = historyData![index];
                          return GestureDetector(
                            onTap: () {
                              Navigator.push(context, MaterialPageRoute(builder: (context) {
                                return ReceiptScreen(id: submission.id ?? 0);
                              }));
                            },
                            child: Card(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20.0),
                                side: BorderSide(color: Color(0xFFF4F4F4), width: 1),
                              ),
                              margin: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                              child: Padding(
                                padding: const EdgeInsets.all(20.0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          "Tanggal",
                                          style: Theme.of(context).textTheme.bodyText1,
                                        ),
                                        Text(
                                          submission.donorDate ?? "",
                                          style: Theme.of(context).textTheme.bodyText1,
                                        ),
                                      ],
                                    ),
                                    SizedBox(height: 8),
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          "Status",
                                          style: Theme.of(context).textTheme.bodyText1,
                                        ),
                                        StatusLabel(status: submission.status ?? "pending"),
                                      ],
                                    ),
                                    SizedBox(height: 10),
                                    Divider(height: 1, color: Colors.black),
                                    SizedBox(height: 10),
                                    ClipRRect(
                                      borderRadius: BorderRadius.circular(10),
                                      child: Image.network(
                                        "${Urls.assetUrl}${submission.place?.image1}",
                                        height: 80,
                                        width: double.infinity,
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                    SizedBox(height: 10),
                                    Container(
                                      width: double.infinity,
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            submission.place?.name ?? "",
                                            style: Theme.of(context).textTheme.bodySmall,
                                            overflow: TextOverflow.ellipsis,
                                            maxLines: 2,
                                          ),
                                          Text(
                                            submission.place?.address ?? "",
                                            style: Theme.of(context).textTheme.bodySmall,
                                            overflow: TextOverflow.ellipsis,
                                            maxLines: 2,
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          );
                        },
                      ),
          )
          ),
        ],
      ),
    ));
  }

  Widget _buildStatusIndicator(IconData icon, String label, int count, {bool active = false}) {
    return Container(
      color: Colors.white,
      child: Column(
        children: [
          Icon(icon, color: active ? Colors.red : Colors.grey),
          SizedBox(height: 8),
          Text("$label ($count)", style: TextStyle(fontSize: 12)),
        ],
      ),
    );
  }

}

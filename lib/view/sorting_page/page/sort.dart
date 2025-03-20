import 'package:airport_search_project/view/sorting_page/model/airport_model.dart';
import 'package:airport_search_project/view/sorting_page/service/airport_service.dart';
import 'package:flutter/material.dart';

class AirportListPage extends StatefulWidget {
  const AirportListPage({super.key});

  @override
  State<AirportListPage> createState() => _AirportListPageState();
}

class _AirportListPageState extends State<AirportListPage> {
  bool isAscending = true;
  List<Source> airports = [];

  void sortAirports(bool ascending) {
    setState(() {
      if (ascending) {
        airports.sort((a, b) => a.countryname!.compareTo(b.countryname!));
      } else {
        airports.sort((a, b) => b.countryname!.compareTo(a.countryname!));
      }
    });
  }

  void fetchAirports() async {
    final airportModel = await airportListService();
    setState(() {
      airports = airportModel.hits?.hits?.map((hit) => hit.source!).toList() ?? [];
    });
  }

  @override
  void initState() {
    super.initState();
    fetchAirports();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Sort'),
        elevation: 10,
        shadowColor: Colors.black87,
        backgroundColor: Colors.white,
      ),
      body: Column(
        children: [
          SizedBox(height: 15),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              ElevatedButton(
                onPressed: fetchAirports,
                style: ElevatedButton.styleFrom(
                  side: const BorderSide(
                    color: Colors.black,
                    width: 1,
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                child: const Text('All Airport', style: TextStyle(color: Colors.black)),
              ),
              SizedBox(width: 10),
              ElevatedButton(
                onPressed: () => sortAirports(true),
                style: ElevatedButton.styleFrom(
                  side: const BorderSide(
                    color: Colors.black,
                    width: 1,
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                child: const Text('A to Z', style: TextStyle(color: Colors.black)),
              ),
              ElevatedButton(
                onPressed: () => sortAirports(false),
                style: ElevatedButton.styleFrom(
                  side: const BorderSide(
                    color: Colors.black,
                    width: 1,
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                child: const Text('Z to A', style: TextStyle(color: Colors.black)),
              ),
            ],
          ),
          Expanded(
            child: ListView.builder(
              itemCount: airports.length,
              itemBuilder: (context, index) {
                final airport = airports[index];
                return Column(
                  children: [
                    SizedBox(height: 3),
                    Divider(thickness: 1),
                    ListTile(
                      title: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          SizedBox(width: 15),
                          Text(
                            "${airport.code} ",
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                          SizedBox(width: 13),
                          Text(
                            "${airport.city} - ${airport.countryname}",
                            style: TextStyle(fontSize: 16),
                          ),
                        ],
                      ),
                    ),
                  ],
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
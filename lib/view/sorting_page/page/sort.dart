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
  bool isLoading = false;
  String selectedButton = 'All Airport';
  List<Source> airports = [];

  void sortAirports(bool ascending) {
    setState(() {
      isAscending = ascending;
      selectedButton = ascending ? 'A to Z' : 'Z to A';
      if (ascending) {
        airports.sort((a, b) => a.countryname!.compareTo(b.countryname!));
      } else {
        airports.sort((a, b) => b.countryname!.compareTo(a.countryname!));
      }
    });
  }

  void fetchAirports() async {
    setState(() {
      isLoading = true;
      selectedButton = 'All Airport';
    });
    try {
      final airportModel = await airportListService();
      setState(() {
        airports = airportModel.hits?.hits?.map((hit) => hit.source!).toList() ?? [];
      });
    } finally {
      setState(() => isLoading = false);
    }
  }

  @override
  void initState() {
    super.initState();
    fetchAirports();
  }

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    final bool isPortrait = screenSize.height > screenSize.width;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Sort'),
        elevation: 10,
        shadowColor: Colors.black87,
        backgroundColor: Colors.white,
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: screenSize.width * 0.05),
        child: Column(
          children: [
            const SizedBox(height: 15),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                _buildButton('All Airport', fetchAirports, screenSize),
                const SizedBox(width: 10),
                _buildButton('A to Z', () => sortAirports(true), screenSize),
                _buildButton('Z to A', () => sortAirports(false), screenSize),
              ],
            ),
            Expanded(
              child: isLoading
                  ? const Center(child: CircularProgressIndicator())
                  : ListView.builder(
                      itemCount: airports.length,
                      itemBuilder: (context, index) {
                        final airport = airports[index];
                        return Column(
                          children: [
                            const SizedBox(height: 3),
                            const Divider(thickness: 1),
                            ListTile(
                              contentPadding: EdgeInsets.symmetric(
                                horizontal: isPortrait ? 15 : 40,
                              ),
                              title: Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Text(
                                    "${airport.code} ",
                                    style: const TextStyle(fontWeight: FontWeight.bold),
                                  ),
                                  const SizedBox(width: 13),
                                  Flexible(
                                    child: Text(
                                      "${airport.city} - ${airport.countryname}",
                                      style: const TextStyle(fontSize: 16),
                                      overflow: TextOverflow.ellipsis,
                                    ),
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
      ),
    );
  }

  Widget _buildButton(String title, VoidCallback onPressed, Size screenSize) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        backgroundColor: selectedButton == title
            ? const Color.fromARGB(214, 240, 238, 238)
            : Colors.white,
        side: const BorderSide(
          color: Colors.black,
          width: 1,
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
        minimumSize: Size(screenSize.width * 0.25, 40),
      ),
      child: Text(title, style: const TextStyle(color: Colors.black)),
    );
  }
}
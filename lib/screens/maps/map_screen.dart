import 'package:flutter/material.dart';

class MapScreen extends StatelessWidget {
  const MapScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("SmartNav Maps"),
        backgroundColor: Colors.green,
      ),

      body: SingleChildScrollView(
        child: Column(
          children: [

            // MAP CONTAINER
            Container(
              height: 250,
              width: double.infinity,
              color: Colors.green.shade100,
              child: const Center(
                child: Icon(
                  Icons.map,
                  size: 100,
                  color: Colors.green,
                ),
              ),
            ),

            const SizedBox(height: 15),

            // CURRENT LOCATION CARD
            Card(
              margin: const EdgeInsets.all(10),
              child: ListTile(
                leading: const Icon(Icons.my_location),
                title: const Text("Current Location"),
                subtitle: const Text("Village Main Road"),
              ),
            ),

            // EMERGENCY BUTTON
            Padding(
              padding: const EdgeInsets.all(10),
              child: SizedBox(
                width: double.infinity,
                child: ElevatedButton.icon(
                  onPressed: () {},
                  icon: const Icon(Icons.warning),
                  label: const Text("Emergency"),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.red,
                    padding: const EdgeInsets.all(15),
                  ),
                ),
              ),
            ),

            // NEARBY PLACES
            const Padding(
              padding: EdgeInsets.all(10),
              child: Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  "Nearby Places",
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),

            ListTile(
              leading: const Icon(Icons.local_hospital),
              title: const Text("Hospital"),
              subtitle: const Text("2 km away"),
            ),

            ListTile(
              leading: const Icon(Icons.local_police),
              title: const Text("Police Station"),
              subtitle: const Text("3 km away"),
            ),

            ListTile(
              leading: const Icon(Icons.local_gas_station),
              title: const Text("Petrol Bunk"),
              subtitle: const Text("1 km away"),
            ),

            // ROUTE DETAILS CARD
            Card(
              margin: const EdgeInsets.all(10),
              child: const ListTile(
                leading: Icon(Icons.route),
                title: Text("Route Details"),
                subtitle: Text("Estimated Time: 15 mins"),
              ),
            ),

            // NAVIGATION BUTTON
            Padding(
              padding: const EdgeInsets.all(10),
              child: SizedBox(
                width: double.infinity,
                child: ElevatedButton.icon(
                  onPressed: () {},
                  icon: const Icon(Icons.navigation),
                  label: const Text("Start Navigation"),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.green,
                    padding: const EdgeInsets.all(15),
                  ),
                ),
              ),
            ),

            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}
import 'package:flutter/material.dart';

class RideSelectionScreen extends StatefulWidget {
  @override
  _RideSelectionScreenState createState() => _RideSelectionScreenState();
}

class _RideSelectionScreenState extends State<RideSelectionScreen> {
  String? _selectedOption;

  @override
  void initState() {
    super.initState();
    _showRideSelectionDialog();
  }

  void _showRideSelectionDialog() {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Choose Ride Type'),
          content: SingleChildScrollView(
            child: ListBody(
              children: [
                ListTile(
                  title: Text('Driver'),
                  onTap: () {
                    setState(() {
                      _selectedOption = 'Driver';
                    });
                    Navigator.pop(context);
                  },
                ),
                ListTile(
                  title: Text('Passenger'),
                  onTap: () {
                    setState(() {
                      _selectedOption = 'Passenger';
                    });
                    Navigator.pop(context);
                  },
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Ride Selection'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Selected Option:',
              style: TextStyle(fontSize: 20),
            ),
            SizedBox(height: 10),
            Text(
              _selectedOption ?? 'None',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ),
    );
  }
}

void main() {
  runApp(MaterialApp(
    home: RideSelectionScreen(),
  ));
}

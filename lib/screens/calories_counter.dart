import 'dart:convert';

import 'package:elevate_fit/Widgets/custom_app_bar.dart';
import 'package:elevate_fit/Widgets/custom_drawer_widgets.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class CaloriesCounterScreen extends StatefulWidget {
  const CaloriesCounterScreen({super.key});

  @override
  _FoodSearchScreenState createState() => _FoodSearchScreenState();
}

class _FoodSearchScreenState extends State<CaloriesCounterScreen> {
  final TextEditingController _searchController = TextEditingController();
  String _calorieCount = '';
  String _errorMessage = '';
  bool _isLoading = false; // Track loading state

  // Function to make the first API request (Instant Endpoint)
  Future<String?> _fetchBrandId(String query) async {
    setState(() {
      _isLoading = true;
      _errorMessage = ''; // Clear previous errors
      _calorieCount = '';    //Clear previous result
    });
    final Uri url = Uri.parse('https://trackapi.nutritionix.com/v2/search/instant?query=$query');
    final Map<String, String> headers = {
      'Content-Type': 'application/json',
      'x-app-id': '835f21ae', // Replace with your App ID
      'x-app-key': 'd2a444ec76276dc3c0ed8e870d9f14f4', // Replace with your App Key
    };

    try {
      final http.Response response = await http.get(url, headers: headers);
      print(response.statusCode);
      if (response.statusCode == 200) {
        final Map<String, dynamic> data = jsonDecode(response.body);
        if (data['branded'] != null && (data['branded'] as List).isNotEmpty) {
          // Access the 'branded' array
          final List<dynamic> brandedFoods = data['branded'];
          // Access the first element of the 'branded' array.
          final Map<String, dynamic> firstBrandedFood = brandedFoods[0];
          // Extract the nix_brand_id
          final String? brandId = firstBrandedFood['nix_item_id'];
          if (brandId != null) {
            print(brandId);
            return brandId;
          }
          else{
            _errorMessage = 'nix_brand_id is null in the first branded food item.';
            return null;
          }

        } else {
          _errorMessage = 'No branded foods found for this search.';
          return null;
        }
      } else {
        _errorMessage = 'Error: ${response.statusCode} - ${response.body}';
        return null;
      }
    } catch (error) {
      _errorMessage = 'Error: $error';
      return null;
    } finally {
      setState(() {
        _isLoading = false; // Update loading state
      });
    }
  }

  // Function to make the second API request (Search-Item Endpoint)
  Future<void> _fetchCalorieCount(String brandId) async {
    setState(() {
      _isLoading = true; // Keep loading state true for the second request
    });
    final Uri url = Uri.parse('https://trackapi.nutritionix.com/v2/search/item?nix_item_id=$brandId');
    final Map<String, String> headers = {
      'Content-Type': 'application/json',
      'x-app-id': '835f21ae', // Replace with your App ID
      'x-app-key': 'd2a444ec76276dc3c0ed8e870d9f14f4', // Replace with your App Key
    };

    try {
      final http.Response response = await http.get(url, headers: headers);
      print(response.statusCode);
      if (response.statusCode == 200) {
        final Map<String, dynamic> data = jsonDecode(response.body);
        if (data['foods'] != null && (data['foods'] as List).isNotEmpty) {
          final Map<String, dynamic> firstFood = (data['foods'] as List)[0];
          final int? calories = firstFood['nf_calories']; // Use double?
          if(calories != null){
            setState(() {
              _calorieCount = calories.toString();
            });
          }
          else{
            setState(() {
              _errorMessage = "Calories not found";
              _calorieCount = '';
            });
          }
        } else {
          setState(() {
            _errorMessage = 'No food item found with that ID.';
            _calorieCount = '';
          });
        }
      } else {
        setState(() {
          _errorMessage = 'Error: ${response.statusCode} - ${response.body}';
          _calorieCount = '';
        });
      }
    } catch (error) {
      setState(() {
        _errorMessage = 'Error: $error';
        _calorieCount = '';
      });
    } finally {
      setState(() {
        _isLoading = false; // Update loading state
      });
    }
  }

  // Function to handle the search process
  Future<void> _handleSearch() async {
    final String query = _searchController.text.trim();
    if (query.isEmpty) {
      setState(() {
        _errorMessage = 'Please enter a search term.';
        _calorieCount = '';
      });
      return;
    }

    final String? brandId = await _fetchBrandId(query);
    if (brandId != null) {
      await _fetchCalorieCount(brandId);
    }
    //_fetchCalorieCount will handle errors.
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF141313)
      ,
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.white),
        backgroundColor: Colors.transparent,
        flexibleSpace: CustomAppBar(),
        title: Center(
          child: Text(
            "Calories Counter",
            style: TextStyle(fontSize: 30, color: Colors.white),
          ),
        ),
        actions: [
          IconButton(
            onPressed: () {
              //Navigator.pushReplacementNamed(context, 'profilescreen');
              Navigator.pushNamed(context, 'profilescreen');
            },
            icon: Icon(Icons.person, color: Colors.white, size: 35),
          ),

        ],
        bottom: PreferredSize(
          preferredSize: Size.fromHeight(1.0),
          child: Container(color: Colors.grey, height: 1.0),
        ),
      ),
      drawer: Drawertap(),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            TextField(
              style: TextStyle(color: Colors.white),
              controller: _searchController,
              decoration: InputDecoration(

                labelText: 'Search for food...',
                suffixIcon: IconButton(
                  icon: const Icon(Icons.clear),
                  onPressed: () {
                    _searchController.clear();
                    setState(() {
                      _calorieCount = '';
                      _errorMessage = '';
                    });
                  },
                ),
                border: const OutlineInputBorder(),
              ),
              onSubmitted: (_) => _handleSearch(),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Color(0xFF009688),
              ),
              onPressed: _isLoading ? null : _handleSearch, // Disable button during loading
              child: _isLoading
                  ? const CircularProgressIndicator() // Show loading indicator
                  : const Text('Search',style:TextStyle(color: Colors.white,fontSize: 18),),
            ),
            const SizedBox(height: 20),
            if (_errorMessage.isNotEmpty) // Show error message,
              Text(
                _errorMessage,
                style: const TextStyle(color: Colors.red),
                textAlign: TextAlign.center,
              ),
            if (_calorieCount.isNotEmpty)
              Text(
                'Calories: $_calorieCount',
                style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold,color: Colors.white),
                textAlign: TextAlign.center,
              ),
          ],
        ),
      ),
    );
  }
}



import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:elevate_fit/Widgets/custom_app_bar.dart';
import 'package:elevate_fit/Widgets/custom_drawer_widgets.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class UserProfile extends StatelessWidget {
  const UserProfile({super.key});

  @override
  Widget build(BuildContext context) {
    final user = FirebaseAuth.instance.currentUser;

    if (user == null) {
      return Scaffold(
        backgroundColor: Color(0xFF141313),
        body: Center(child: Text('Please log in to view your profile',style: GoogleFonts.montserrat(fontSize: 25,color: Colors.white ),)),
      );
    }

    return Scaffold(
      backgroundColor: Color(0xFF141313),
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.white),
        backgroundColor: Colors.transparent,
        flexibleSpace: CustomAppBar(),
        title: Center(
          child: Text(
            "Profile",
            style: GoogleFonts.montserrat(fontSize: 30, color: Colors.white),
          ),
        ),
        actions: [
          IconButton(
            onPressed: () {
            },
            icon: Icon(Icons.edit, color: Colors.white, size: 35),
          ),
        ],
        bottom: PreferredSize(
          preferredSize: Size.fromHeight(1.0),
          child: Container(color: Colors.grey, height: 1.0),
        ),
      ),
      //drawer: Drawertap(),
      //method futurebuilder 3lshan tgeeb el data mn firestore
      body: FutureBuilder<DocumentSnapshot>(
        future: FirebaseFirestore.instance.collection('users').doc(user.uid).get(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return
              Center(child: CircularProgressIndicator());
          }
          if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}',style: GoogleFonts.montserrat(fontSize: 20,color: Colors.white),));
          }
          if (!snapshot.hasData || !snapshot.data!.exists) {
            return Center(child: Text('No user data found',style: GoogleFonts.montserrat(fontSize: 20,color: Colors.white),));
          }

          final data = snapshot.data!.data() as Map<String, dynamic>;
          final imageUrl = data['imageUrl']?.isNotEmpty == true
              ? data['imageUrl']
              : 'https://via.placeholder.com/150'; // Default image
          final displayName = data['firstName'] ?? 'Unknown';
          final username = data['username'] ?? 'Unknown';
          final email = data['email'] ?? 'Unknown';
          final phone = data['phone'] ?? 'Unknown';

          return Column(
            children: [
              Container(
                height: 200,
                decoration: const BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [
                      Color(0xFF1E3C72),
                      Color(0xFF2A5298),
                      Color(0xFF121212),
                    ],
                  ),
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(30),
                    bottomRight: Radius.circular(30),
                  ),
                ),
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      CircleAvatar(
                        radius: 50,
                        backgroundImage: NetworkImage(imageUrl),
                      ),
                      const SizedBox(height: 10),
                      Text(
                        displayName,
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        username,
                        style: const TextStyle(
                          color: Colors.white70,
                          fontSize: 16,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 30),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Column(
                  children: [
                    buildProfileCard(Icons.email, 'Email', email),
                    const SizedBox(height: 15),
                    buildProfileCard(Icons.phone, 'Phone', phone),
                  ],
                ),
              ),
            ],
          );
        },
      ),
    );
  }

  Widget buildProfileCard(IconData icon, String title, String subtitle) {
    return Card(
      color: Colors.grey.shade500,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
      ),
      elevation: 5,
      child: ListTile(
        leading: Icon(icon, color: Colors.teal),
        title: Text(
          title,
          style:
          GoogleFonts.montserrat(
            fontWeight: FontWeight.bold,
          ),
        ),
        subtitle: Text(subtitle),
      ),
    );
  }
}
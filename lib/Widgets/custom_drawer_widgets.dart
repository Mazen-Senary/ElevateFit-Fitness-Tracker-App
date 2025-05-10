import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../ViewModel/loginViewModel.dart';
import 'custom_elevated_button.dart';

class Drawertap extends StatelessWidget {
  const Drawertap({super.key});

  @override
  Widget build(BuildContext context) {
    LoginViewModel loginViewModel = LoginViewModel();
    return Drawer(
      child:Container(
        color: Color(0xFF141313),
        child: ListView(
          children: [
            DrawerHeader(child: Center(
              child: Text("Elevate-Fit",
                style:GoogleFonts.fugazOne(
                  fontSize: 40,
                  color: Colors.white
                ),
              ),
            )),
            ListTile(
              leading: Icon(Icons.person, size: 35, color: Colors.white),
              title: Text(
                "Profile",
                style: GoogleFonts.montserrat(fontSize: 25, color: Colors.white),
              ),
              onTap: () {
                Navigator.pushReplacementNamed(context, '/profile');
              },
            ),
            ListTile(
              leading: Icon(Icons.track_changes,size: 35,color: Colors.white,),
              title: Text("goal",
                  style: GoogleFonts.montserrat(fontSize: 25,color: Colors.white,)
              ),

            ),
            ListTile(
              leading: Icon(Icons.help_outline,size: 35,color: Colors.white,),
              title: Text("Help & Support",
                  style: GoogleFonts.montserrat(fontSize: 25,color: Colors.white,)
              ),

            ),
            ListTile(
              leading: Icon(Icons.settings,size: 35,color: Colors.white,),
              title: Text("Settings",
                  style: GoogleFonts.montserrat(fontSize: 25,color: Colors.white,)
              ),
            ),
             SizedBox(height: 300,) ,
            CustomElevatedbutton(
              onPressed: () async {
                await FirebaseAuth.instance.signOut();
                loginViewModel.navigation(context, 'login');
              },
              text: "Logout",
              color: Color(0xFFE30B5C),
            ),

          ],

        ),
      )


    );
  }
}

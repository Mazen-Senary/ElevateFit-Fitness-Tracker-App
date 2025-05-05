// // import 'package:elevate_fit/Widgets/custom_app_bar.dart';
// // import 'package:elevate_fit/screens/dashboard_screen.dart';
// // import 'package:elevate_fit/screens/home_screen.dart';
// // import 'package:elevate_fit/screens/login_screen.dart';
// // import 'package:firebase_auth/firebase_auth.dart';
// // import 'package:flutter/material.dart';
// // import 'package:flutter/services.dart';
// // import 'package:google_fonts/google_fonts.dart';
// //
// // class SplashScreen extends StatefulWidget {
// //   const SplashScreen({super.key});
// //
// //   @override
// //   State<SplashScreen> createState() => _SplashScreenState();
// // }
// //
// // class _SplashScreenState extends State<SplashScreen> with SingleTickerProviderStateMixin{
// //   @override
// //   void initState() {
// //     super.initState();
// //     SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersive);
// //     Future.delayed(Duration(seconds: 5), () {
// //       final user = FirebaseAuth.instance.currentUser;
// //       if (user == null) {
// //         Navigator.of(context).pushReplacement(
// //           MaterialPageRoute(builder: (_) => const LoginScreen()),
// //         );
// //       } else {
// //         Navigator.of(context).pushReplacement(
// //           MaterialPageRoute(builder: (_) => const HomeScreen()), // or HomeScreen
// //         );
// //       }
// //     });
// //   }
// //   @override
// //   void dispose() {
// //     // TODO: implement dispose
// //     SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual,overlays: SystemUiOverlay.values);
// //     super.dispose();
// //   }
// //
// //   @override
// //   Widget build(BuildContext context) {
// //     return Scaffold(
// //       body: Container(
// //         width: double.infinity,
// //         height: double.infinity,
// //         decoration: BoxDecoration(
// //           gradient: LinearGradient(
// //             begin: Alignment.topLeft,
// //             end: Alignment.bottomRight,
// //             colors: [
// //               Color(0xFF1E3C72),
// //               // Color(0xff008080),
// //               Color(0xFF2A5298),
// //               Color(0xFF121212),
// //             ],
// //           ),
// //
// //         ),
// //         child: Center(
// //           child: Column(
// //             mainAxisAlignment: MainAxisAlignment.center,
// //             children: [
// //               Image.asset("images/logo.png", height: 350),
// //               //SizedBox(height: 25,width: 30,),
// //           Text("Elevate-Fit",
// //             style:GoogleFonts.fugazOne(
// //                 fontSize: 50,
// //                 color: Colors.white
// //             ),
// //           ),
// //               SizedBox(height: 25,),
// //               Text(" Rise to Your Potential",
// //                 style:GoogleFonts.montserrat(
// //                     fontSize: 20,
// //                     color: Colors.white
// //                 ),
// //               ),
// //               SizedBox(height: 20,),
// //
// //             CircularProgressIndicator(
// //                 color: Colors.white, // or any color you like
// //                 strokeWidth: 4.0,
// //               ),
// //
// //
// //             ]
// //           ),
// //         ),
// //
// //       ),
// //     );
// //   }
// // }
// import 'package:elevate_fit/screens/login_screen.dart';
// import 'package:elevate_fit/screens/home_screen.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
//
// class SplashScreen extends StatefulWidget {
//   const SplashScreen({super.key});
//
//   @override
//   State<SplashScreen> createState() => _SplashScreenState();
// }
//
// class _SplashScreenState extends State<SplashScreen> {
//   @override
//   void initState() {
//     super.initState();
//     SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersive);
//
//     // Listen to Firebase Auth state changes to ensure proper session handling
//     FirebaseAuth.instance.authStateChanges().listen((user) {
//       if (user == null) {
//         // If no user, navigate to login
//         Navigator.of(context).pushReplacement(
//           MaterialPageRoute(builder: (_) => const LoginScreen()),
//         );
//       } else {
//         // If user exists, navigate to HomeScreen
//         Navigator.of(context).pushReplacement(
//           MaterialPageRoute(builder: (_) => const HomeScreen()),
//         );
//       }
//     });
//
//     // Add a delay for splash screen appearance
//     Future.delayed(Duration(seconds: 5), () {
//       // The navigation will happen based on the auth state change listener
//     });
//   }
//
//   @override
//   void dispose() {
//     // Reset the system UI mode on dispose
//     SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual, overlays: SystemUiOverlay.values);
//     super.dispose();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Container(
//         width: double.infinity,
//         height: double.infinity,
//         decoration: BoxDecoration(
//           gradient: LinearGradient(
//             begin: Alignment.topLeft,
//             end: Alignment.bottomRight,
//             colors: [
//               Color(0xFF1E3C72),
//               Color(0xFF2A5298),
//               Color(0xFF121212),
//             ],
//           ),
//         ),
//         child: Center(
//           child: Column(
//             mainAxisAlignment: MainAxisAlignment.center,
//             children: [
//               Image.asset("images/logo.png", height: 350),
//               Text(
//                 "Elevate-Fit",
//                 style: TextStyle(
//                   fontSize: 50,
//                   color: Colors.white,
//                   fontFamily: 'FugazOne', // Adjust with your preferred font
//                 ),
//               ),
//               SizedBox(height: 25),
//               Text(
//                 "Rise to Your Potential",
//                 style: TextStyle(
//                   fontSize: 20,
//                   color: Colors.white,
//                   fontFamily: 'Montserrat', // Adjust with your preferred font
//                 ),
//               ),
//               SizedBox(height: 20),
//               CircularProgressIndicator(
//                 color: Colors.white, // or any color you like
//                 strokeWidth: 4.0,
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
//
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:elevate_fit/screens/login_screen.dart';
import 'package:elevate_fit/screens/home_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> with SingleTickerProviderStateMixin {
  @override
  void initState() {
    super.initState();
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersive);
    Future.delayed(Duration(seconds: 3), () {
      final user = FirebaseAuth.instance.currentUser;
      if (user == null) {
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (_) => const LoginScreen()),
        );
      } else {
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (_) => const HomeScreen()),
        );
      }
    });
  }

  @override
  void dispose() {
    super.dispose();
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual, overlays: SystemUiOverlay.values);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              Color(0xFF1E3C72),
              Color(0xFF2A5298),
              Color(0xFF121212),
            ],
          ),
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset("images/logo.png", height: 350),
              SizedBox(height: 25),
              Text(
                "Elevate-Fit",
                style: GoogleFonts.fugazOne(fontSize: 50, color: Colors.white),
              ),
              SizedBox(height: 25),
              Text(
                "Rise to Your Potential",
                style: GoogleFonts.montserrat(fontSize: 20, color: Colors.white),
              ),
              SizedBox(height: 20),
              CircularProgressIndicator(
                color: Colors.white, // Customize the color as needed
                strokeWidth: 4.0,
              ),
            ],
          ),
        ),
      ),
    );
  }
}


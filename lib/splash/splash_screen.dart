import 'package:flutter/material.dart';
import 'package:passport/home/home_page.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1500),
    );
    _animation = CurvedAnimation(
      parent: _controller,
      curve: Curves.easeIn,
    );
    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    // bool isAuthed = StorageRepository.getString(StorageKeys.TOKEN).isNotEmpty;
    Widget page = HomePage();
    Future.delayed(const Duration(seconds: 2)).then((value) =>
        Navigator.pushAndRemoveUntil(context,
            MaterialPageRoute(builder: (_) => page), (route) => false));
    return Scaffold(
      backgroundColor: const Color(0xFF00DBE1),
      body: Center(
        child: SizedBox(
          width: size.width,
          height: size.height,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              FadeTransition(
                opacity: _animation,
                child: Container(
                  height: size.height * 0.2,
                  width: size.height * 0.2,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
                      image: const DecorationImage(
                        image: AssetImage(
                          'assets/logo.png',
                        ),
                        fit: BoxFit.cover,
                      )),
                ),
              )
              //   child: Text(
              //     'AGROTA MARKET',
              //     style: TextStyle(
              //       color: const Color(0xFF232677),
              //       fontSize: 18,
              //     ),
              //   ),
              // ),
            ],
          ),
        ),
      ),
    );
  }
}

// class SplashScreen extends StatelessWidget {
//   const SplashScreen({
//     Key? key,
//   }) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     Size size = MediaQuery.of(context).size;
//     Future.delayed(const Duration(seconds: 3)).then((value) =>
//         Navigator.pushAndRemoveUntil(context,
//             MaterialPageRoute(builder: (_) => const Home()), (route) => false));
//     return Scaffold(
//       backgroundColor: Colors.white,
//       body: Center(
//         child: SizedBox(
//           width: size.width,
//           height: size.height,
//           child: Column(
//             mainAxisAlignment: MainAxisAlignment.center,
//             crossAxisAlignment: CrossAxisAlignment.center,
//             children: [
//               SizedBox(
//                 width: size.width / 1.8,
//                 child:
//                     Image.asset('assets/images/Educationbox_logo_splash2.png'),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }

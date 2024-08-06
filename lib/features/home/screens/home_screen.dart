import 'package:amortization_calculator_app/features/home/controller/home_controller.dart';
import 'package:amortization_calculator_app/features/leasing/screens/leasing_screen.dart';
import 'package:amortization_calculator_app/widgets/custom_appBar_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';


class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late Future<String> nameFuture;
  final HomeController _homeController = HomeController();

  @override
  void initState() {
    super.initState();
    nameFuture = _homeController.loadUserInfo();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            FutureBuilder<String>(
              future: nameFuture,
              builder: (context, snapshot) {
                  return RichText(
                    text: TextSpan(
                      text: 'Welcome ',
                      style: const TextStyle(
                        fontSize: 22,
                        color: Color(0xFF970032),
                        fontWeight: FontWeight.bold,
                      ),
                      children: <TextSpan>[
                        TextSpan(
                          text: snapshot.data,
                          style: const TextStyle(
                            fontSize: 20,
                            color: Colors.black,
                          ),
                        ),
                      ],
                    ),
                  );
              },
            ),
            const SizedBox(height: 20),
            Center(
              child: RichText(
                text: const TextSpan(
                  text: 'Calc ',
                  style: TextStyle(
                    fontSize: 18,
                    color: Color(0xFF970032),
                    fontWeight: FontWeight.bold,
                  ),
                  children: <TextSpan>[
                    TextSpan(
                      text: 'Amortization',
                      style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.normal,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 20),
            const Center(
              child: Divider(
                height: 20,
                thickness: 2,
                indent: 150,
                endIndent: 150,
                color: Color(0xFF94364a),
              ),
            ),
            const SizedBox(height: 10),
            const Text(
              'Choose From Our Services',
              style: TextStyle(fontSize: 22),
            ),
            const SizedBox(height: 20),
            InkWell(
              onTap: () {
                Get.to(() => LeasingScreen());
              },
              borderRadius: BorderRadius.circular(15.0),
              child: Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15.0),
                ),
                elevation: 2,
                child: Padding(
                  padding: const EdgeInsets.all(30.0),
                  child: Column(
                    children: [
                      Image.asset(
                        'lib/assets/leasing.png',
                      ),
                      const SizedBox(height: 10),
                      const Text(
                        'Leasing',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

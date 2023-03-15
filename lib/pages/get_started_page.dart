import 'package:flutter/material.dart';
import 'package:app/widgets/buttons/signInGoogle_button.dart';
import '../widgets/buttons/button.dart';
import 'package:app/auth/auth.dart';

import 'home/home_page.dart';

class GetStarted extends StatefulWidget {
  const GetStarted({super.key});

  @override
  State<GetStarted> createState() => _GetStartedState();
}

class _GetStartedState extends State<GetStarted> {
  bool loadingGoogle = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder(
        stream: Auth().authStateChanges,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.active) {
            final user = snapshot.data;
            if (user == null) {
              return _getStartedWidget(context);
            }
            return HomePage();
          }
          return const Scaffold(
            body: Center(
              child: CircularProgressIndicator(),
            ),
          );
        },
      ),
    );
  }

  Widget _getStartedWidget(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 20),
          constraints: BoxConstraints(
            minHeight: MediaQuery.of(context).size.height,
            minWidth: MediaQuery.of(context).size.width,
          ),
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage("assets/background_get_started.jpg"),
              fit: BoxFit.cover,
            ),
          ),
          child: loadingGoogle
              ? const Center(
                  child: CircularProgressIndicator(),
                )
              : Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    const Image(
                      image: AssetImage("assets/lockey.png"),
                      height: 300,
                      width: 300,
                    ),
                    Container(
                      child: Column(
                        children: [
                          Container(
                            width: 250,
                            height: 50,
                            child: ButtonWidget(
                              textContent: 'Continua con Lockey',
                              onPressed: () {
                                Navigator.pushNamed(context, '/login');
                              },
                              fontColor: Colors.black,
                              backgroundColor: Colors.white,
                            ),
                          ),
                          const SizedBox(height: 20),
                          Container(
                            width: 250,
                            child: Row(
                              children: [
                                const Expanded(
                                  child: Divider(
                                    color: Colors.white,
                                    thickness: 2,
                                  ),
                                ),
                                Container(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 10),
                                  child: const Text(
                                    'O',
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 16,
                                    ),
                                  ),
                                ),
                                const Expanded(
                                  child: Divider(
                                    color: Colors.white,
                                    thickness: 2,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(height: 20),
                          GoogleSignButton(
                            changeLoading: (value) {
                              setState(() {
                                loadingGoogle = value;
                              });
                            },
                          ),
                        ],
                      ),
                    ),
                  ],
                )),
    );
  }
}

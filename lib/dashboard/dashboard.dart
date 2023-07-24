import 'package:beta_projek/dashboard/api_history.dart';
import 'package:beta_projek/dashboard/history.dart';
import 'package:beta_projek/dashboard/visual.dart';
import 'package:beta_projek/user/profil.dart';
import 'package:beta_projek/user/user.dart';
import 'package:beta_projek/views/record.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

class dasbor extends StatefulWidget {
  const dasbor({super.key});

  @override
  State<dasbor> createState() => _dasborState();
}

class _dasborState extends State<dasbor> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        padding: EdgeInsets.zero,
        children: [
          Container(
            decoration: BoxDecoration(
              color: Theme.of(context).primaryColor,
              borderRadius: const BorderRadius.only(
                bottomRight: Radius.circular(50),
              ),
            ),
            child: Column(
              children: [
                const SizedBox(height: 50),
                InkWell(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => Profil()),
                    );
                  },
                  child: ListTile(
                    contentPadding: const EdgeInsets.symmetric(horizontal: 30),
                    title: Text('Hello People!',
                        style: Theme.of(context)
                            .textTheme
                            .headlineSmall
                            ?.copyWith(color: Colors.white)),
                    subtitle: Text('Good Morning',
                        style: Theme.of(context)
                            .textTheme
                            .titleMedium
                            ?.copyWith(color: Colors.white54)),
                    trailing: const CircleAvatar(
                      radius: 30,
                      backgroundImage: AssetImage('assets/logoasli.png'),
                    ),
                  ),
                ),
                const SizedBox(height: 30)
              ],
            ),
          ),
          Container(
            color: Theme.of(context).primaryColor,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 30),
              decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius:
                      BorderRadius.only(topLeft: Radius.circular(200))),
              child: GridView.count(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                crossAxisCount: 2,
                crossAxisSpacing: 40,
                mainAxisSpacing: 30,
                children: [
                  Card(
                    margin: const EdgeInsets.all(8),
                    child: InkWell(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => Recording()));
                      },
                      splashColor: Colors.blue,
                      child: Center(
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: const <Widget>[
                            Icon(
                              Icons.spatial_tracking_outlined,
                              size: 70,
                              color: Colors.blueAccent,
                            ),
                            Text("Deteksi", style: TextStyle(fontSize: 17.0)),
                          ],
                        ),
                      ),
                    ),
                  ),
                  Card(
                    margin: const EdgeInsets.all(8),
                    child: InkWell(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => HistoryParkir()));
                      },
                      splashColor: Colors.blue,
                      child: Center(
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: const <Widget>[
                            Icon(
                              Icons.history,
                              size: 70,
                              color: Colors.redAccent,
                            ),
                            Text("Histori", style: TextStyle(fontSize: 17.0)),
                          ],
                        ),
                      ),
                    ),
                  ),
                  Card(
                    margin: const EdgeInsets.all(8),
                    child: InkWell(
                      onTap: () {
                        Navigator.push(context,
                            MaterialPageRoute(builder: (context) => Chart()));
                      },
                      splashColor: Colors.blue,
                      child: Center(
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: const <Widget>[
                            Icon(
                              Icons.add_chart,
                              size: 70,
                              color: Colors.greenAccent,
                            ),
                            Text("Visualisasi",
                                style: TextStyle(fontSize: 17.0)),
                          ],
                        ),
                      ),
                    ),
                  ),
                  Card(
                    margin: const EdgeInsets.all(8),
                    child: InkWell(
                      onTap: () {},
                      splashColor: Colors.blue,
                      child: Center(
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: const <Widget>[
                            Icon(
                              Icons.person_outline_sharp,
                              size: 70,
                              color: Colors.blueGrey,
                            ),
                            Text("About", style: TextStyle(fontSize: 17.0)),
                          ],
                        ),
                      ),
                    ),
                  ),
                  // Card(
                  //   margin: const EdgeInsets.all(8),
                  //   child: InkWell(
                  //     onTap: (){},
                  //     splashColor: Colors.blue,
                  //     child: Center(
                  //       child: Column(
                  //         mainAxisSize: MainAxisSize.min,
                  //         children: const <Widget>[
                  //           Icon(Icons.home, size: 70, color: Colors.blueAccent,),
                  //           Text("Home", style: TextStyle(fontSize: 17.0)),
                  //         ],
                  //       ),
                  //     ),
                  //   ),
                  // ),
                  // Card(
                  //   margin: const EdgeInsets.all(8),
                  //   child: InkWell(
                  //     onTap: (){},
                  //     splashColor: Colors.blue,
                  //     child: Center(
                  //       child: Column(
                  //         mainAxisSize: MainAxisSize.min,
                  //         children: const <Widget>[
                  //           Icon(Icons.home, size: 70, color: Colors.blueAccent,),
                  //           Text("Home", style: TextStyle(fontSize: 17.0)),
                  //         ],
                  //       ),
                  //     ),
                  //   ),
                  // ),
                  // Card(
                  //   margin: const EdgeInsets.all(8),
                  //   child: InkWell(
                  //     onTap: (){},
                  //     splashColor: Colors.blue,
                  //     child: Center(
                  //       child: Column(
                  //         mainAxisSize: MainAxisSize.min,
                  //         children: const <Widget>[
                  //           Icon(Icons.home, size: 70, color: Colors.blueAccent,),
                  //           Text("Home", style: TextStyle(fontSize: 17.0)),
                  //         ],
                  //       ),
                  //     ),
                  //   ),
                  // ),
                  // Card(
                  //   margin: const EdgeInsets.all(8),
                  //   child: InkWell(
                  //     onTap: (){},
                  //     splashColor: Colors.blue,
                  //     child: Center(
                  //       child: Column(
                  //         mainAxisSize: MainAxisSize.min,
                  //         children: const <Widget>[
                  //           Icon(Icons.home, size: 70, color: Colors.blueAccent,),
                  //           Text("Home", style: TextStyle(fontSize: 17.0)),
                  //         ],
                  //       ),
                  //     ),
                  //   ),
                  // ),

                  // itemDashboard('Profile',CupertinoIcons.person_alt, Colors.purple),
                  // itemDashboard('Team', CupertinoIcons.group, Colors.green),
                  // itemDashboard('About', CupertinoIcons.question_circle, Colors.blue),
                  // itemDashboard('Comments', CupertinoIcons.chat_bubble_2, Colors.brown),
                  // itemDashboard('Revenue', CupertinoIcons.money_dollar_circle, Colors.indigo),
                  // itemDashboard('Upload', CupertinoIcons.add_circled, Colors.teal),
                  // itemDashboard('Contact', CupertinoIcons.phone, Colors.pinkAccent),
                ],
              ),
            ),
          ),
          const SizedBox(height: 20)
        ],
      ),
    );
  }

  itemDashboard(String title, IconData iconData, Color background) => Container(
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(10),
            boxShadow: [
              BoxShadow(
                  offset: const Offset(0, 5),
                  color: Theme.of(context).primaryColor.withOpacity(.2),
                  spreadRadius: 2,
                  blurRadius: 5)
            ]),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: background,
                  shape: BoxShape.circle,
                ),
                child: Icon(iconData, color: Colors.white)),
            const SizedBox(height: 8),
            Text(title.toUpperCase(),
                style: Theme.of(context).textTheme.titleMedium)
          ],
        ),
      );
}

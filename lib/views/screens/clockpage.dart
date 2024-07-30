
import 'dart:math';
import 'package:flutter/material.dart';

class Clockpage extends StatefulWidget {
  const Clockpage({super.key});

  @override
  State<Clockpage> createState() => _ClockpageState();
}

class _ClockpageState extends State<Clockpage> {
  
  int h=0,m=0,s=0;
  void startclock() {
    h = DateTime.now().hour;
    m = DateTime.now().minute;
    s = DateTime.now().second;
    setState(() {});
    Future.delayed(
      Duration(seconds: 1),
      () {
        startclock();
      }
    );
  }
  @override
  void initState() {
    startclock();
    super.initState();
  }
  bool isAnalog = true;
  bool isStrap = false;
  bool isTimer = false;
  bool isReverseTime = false;
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.sizeOf(context);
    return Scaffold(
      drawer:  Drawer(
          child: Column(
            children: [
              UserAccountsDrawerHeader(
                currentAccountPicture: CircleAvatar(
                  foregroundImage: NetworkImage("https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRS-bz3w3YbiCPW23zQNWR0sjH7WNZFmCV_6Q&s"),
                ),
                accountName: Text("User"),
                accountEmail: Text("user@gmail.com"),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text("Analog"),
                  Switch(
                    value: isAnalog,
                    onChanged: (val){
                      isStrap = false;
                      isTimer = false;
                      isAnalog = val;
                      setState(() {
                      });
                    },
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text("Strap"),
                  Switch(
                    value: isStrap,
                    onChanged: (val){
                      isAnalog = false;
                      isTimer = false;
                      isStrap = val;
                      setState(() {
                      });
                    },
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text("Digital"),
                  Switch(
                    value: isTimer,
                    onChanged: (val){
                      isAnalog = false;
                      isStrap = false;
                      isTimer = val;
                      setState(() {});
                    },
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text("Reverse Timer"),
                  Switch(
                    value: isReverseTime,
                    onChanged: (val){
                      isAnalog = false;
                      isStrap = false;
                      isTimer = false;
                      isReverseTime = val;
                      setState(() {});
                    },
                  ),
                ],
              ),
            ],
           
          ),
        ),
        
      appBar: AppBar(
        title: const Text("Clock demo"),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          //Analog
          Visibility(
            visible: isAnalog,
            child: Stack(
            alignment: Alignment.center,
              children: [
                Container(
                  width: size.width * 0.9,
                  height: size.width * 0.9,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                  ),
                  child: Image.network(
                    'data:image/png;base64,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',
                    fit: BoxFit.fitWidth,
                  ),
                ),
                //Second
                Transform.rotate(
                  angle: s *(pi*2) /60,
                  child: Transform.rotate(
                    angle: pi/2,
                    child: Divider(
                      color: Colors.red,
                      indent: 90,
                      thickness: 2,
                      endIndent: size.width * 0.5,//-16
                    ),
                  ),
                ),
                //Minute
                Transform.rotate(
                  angle: m *(pi*2) /60,
                  child: Transform.rotate(
                    angle: pi/2,
                    child: Divider(
                      color: Colors.black,
                      indent: 110,
                      thickness: 3,
                      endIndent: size.width * 0.5 ,
                    ),
                  ),
                ),
                //Hour
                Transform.rotate(
                  angle: h *(pi*2) /12,
                  child: Transform.rotate(
                    angle: pi/2,
                    child: Divider(
                      color: Colors.black,
                      indent: 160,
                      thickness: 4,
                      endIndent: size.width * 0.5 ,
                    ),
                  ),
                ),
              ],
            ),
          ), 
          //Strap
          Center(
            child: Visibility(
              visible: isStrap,
              child: Stack(
              alignment: Alignment.center,
                children: [
                  //Second
                  Transform.scale(
                    scale: 6,                    
                    child: CircularProgressIndicator(
                      value: s/60,
                      color: Colors.red,
                      strokeWidth: 1,
                    ),
                  ),
                  //Minute
                  Transform.scale(
                    scale: 5,
                    child: CircularProgressIndicator(
                      value: m/60,
                      color: Colors.black45,
                      strokeWidth: 3,
                    ),
                  ),
                  //Hour
                  Transform.scale(
                    scale: 3.7,
                    child: CircularProgressIndicator(
                      value: (h%12)/12,
                      color: Colors.black,
                      strokeWidth: 6,
                    ),
                  ),
                ],
              ),
            ),
          ), 
          //Digital Timer
          Visibility(
            visible: isTimer,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                //Hour
                Container(
                  height: size.height * 0.12,
                  width: size.width * 0.16,
                  margin: EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: Colors.black26,
                    borderRadius: BorderRadius.circular(10),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey,
                        blurRadius: 5,
                        offset: Offset(5, 5),
                      ),                      
                    ],
                  ),
                  child: Center(
                    child: Text(
                      "${h%12}",
                      style: TextStyle(
                        fontSize: 40,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
                Column(
                  children: [
                    CircleAvatar(
                      radius: 10,
                      backgroundColor: Colors.black,
                    ),
                    Padding(padding: EdgeInsets.all(6)),
                    CircleAvatar(
                      radius: 10,
                      backgroundColor: Colors.black,
                    ),
                  ],
                ),
                
                //Minute
                Container(
                  height: size.height * 0.12,
                  width: size.width * 0.16,
                  margin: EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: Colors.black26,
                    borderRadius: BorderRadius.circular(10),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey,
                        blurRadius: 5,
                        offset: Offset(5, 5),
                      ),                      
                    ],
                  ),
                  child: Center(
                    child: Text(
                      "${m}",
                      style: TextStyle(
                        fontSize: 40,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
                Column(
                  children: [
                    CircleAvatar(
                      radius: 10,
                      backgroundColor: Colors.black,
                    ),
                    Padding(padding: EdgeInsets.all(6)),
                    CircleAvatar(
                      radius: 10,
                      backgroundColor: Colors.black,
                    ),
                  ],
                ),
                //Second
                Container(
                  height: size.height * 0.12,
                  width: size.width * 0.16,
                  margin: EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: Colors.black26,
                    borderRadius: BorderRadius.circular(10),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey,
                        blurRadius: 5,
                        offset: Offset(5, 5),
                      ),                      
                    ],
                  ),
                  child: Center(
                    child: Text(
                      "${s}",
                      style: TextStyle(
                        fontSize: 40,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
                // Text("${m}",),
                // Text(":",),
                // Text("${s}",),
              ],
            ),
          ),
          //Reverse Timer
          
        ],
      ),
    );
  }
}

        // child: Align(
        //   child: Stack(
        //     alignment: Alignment.center,
        //     children: [
        //       //Second
        //       Transform.rotate(
        //         angle: s*(pi*2)/60,
        //         child: Transform.rotate(
        //           angle: pi/2,
        //           child: Divider(
        //             color: Colors.red,
        //             thickness: 3,
        //             indent: 50,
        //             endIndent: size.width *0.5,
        //           ),
        //         ),
        //       ),
        //       //Minute
        //       Transform.rotate(
        //         angle: m*(pi*2)/60,
        //         child: Transform.rotate(
        //           angle: pi/2,
        //           child: Divider(
        //             color: Colors.black,
        //             thickness: 3,
        //             indent: 40,
        //             endIndent: size.width *0.5,
        //           ),
        //         ),
        //       ),
        //       //Hour
        //       Transform.rotate(
        //         angle: h*(pi*2)/12,
        //         child: Transform.rotate(
        //           angle: pi/2,
        //           child: Divider(
        //             color: Colors.black,
        //             thickness: 6,
        //             indent: 60,
        //             endIndent: size.width *0.5,
        //           ),
        //         ),
        //       ),
        //     ],
        //   ),
        // ),
      

    // int x =10;
    // int y = 10;
    // child: Center(
    //       child: Column(
    //         mainAxisAlignment: MainAxisAlignment.spaceEvenly,
    //         children: [
    //           LinearProgressIndicator(),              
    //           Transform.scale(
    //             scaleX: 4,
    //             child: CircularProgressIndicator(
    //               value: 1,
    //             ),
    //           ),
    //           Transform.translate(
    //             offset: Offset(x.toDouble(), y.toDouble()),
    //             child: CircularProgressIndicator()
    //           ),
    //           Transform.rotate(
    //             angle: 0,
    //             child: Divider(
    //               color: Colors.black,
    //               thickness: 3,
    //               indent: 50,
    //               endIndent: MediaQuery.sizeOf(context).width * 0.5 - 16
    //             ),
    //           ),
    //         ],            
    //       ),
    //     ),
    
    // floatingActionButton: Row(
    //   mainAxisAlignment: MainAxisAlignment.spaceEvenly,
    //   children: [
    //     FloatingActionButton(
    //       onPressed: () {
    //         y -= 10;
    //         setState(() {});
    //       },
    //       child: Icon(Icons.arrow_upward_rounded),
    //     ),
    //     FloatingActionButton(
    //       onPressed: () {
    //         y += 10;
    //         setState(() {});
    //       },
    //       child: Icon(Icons.arrow_downward_rounded),
    //     ),
    //     FloatingActionButton(
    //       onPressed: () {
    //         x -= 10;
    //         setState(() {});
    //       },
    //       child: Icon(Icons.arrow_back_rounded),
    //     ),
    //     FloatingActionButton(
    //       onPressed: () {
    //         x += 10;
    //         setState(() {});
    //       },
    //       child: Icon(Icons.arrow_forward_rounded),
    //     ),
    //   ],
    // ),
  
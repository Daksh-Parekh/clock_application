import 'dart:math';
import 'package:clock_app/views/screens/extension.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class Clockpage extends StatefulWidget {
  const Clockpage({super.key});

  @override
  State<Clockpage> createState() => _ClockpageState();
}

class _ClockpageState extends State<Clockpage> {
  int h = 0, m = 0, s = 0;
  final minController = TextEditingController();
  final secController = TextEditingController();
  int usermin = 0;
  int usersec = 0;

  void startTimer() {
    Future.delayed(const Duration(seconds: 1), () {
      usersec--;
      setState(() {
        if (usersec < 0) {
          usermin--;
          usersec = 59;
        }
        if (usersec > 0 || usermin > 0) {
          startTimer();
        }
      });
    });
  }

  void startclock() {
    h = DateTime.now().hour;
    m = DateTime.now().minute;
    s = DateTime.now().second;
    setState(() {});
    Future.delayed(Duration(seconds: 1), () {
      startclock();
    });
  }

  int min = 0, sec = 0;
  bool isrunn = true;
  bool ispause = false;
  void StartStopWatch() {
    isrunn = true;
    // ispause = true;
    Future.delayed((Duration(seconds: 1)), () {
      if (isrunn && ispause) {
        setState(() {
          sec++;
          if (sec >= 60) {
            min++;
            sec = 0;
          }
          StartStopWatch();
          // ispause = !ispause;
        });
      }
    });
  }

  void resetStopWatch() {
    min = 0;
    sec = 0;
    laps.clear();
    setState(() {});
    ispause = false;
    isrunn = false;
  }

  List laps = [];
  void addLap() {
    laps.add(min.toString() + ':' + sec.toString().padLeft(2, '0'));
    setState(() {});
  }

  @override
  void initState() {
    startclock();
    currentDial = dials[0];
    super.initState();
  }

  bool isAnalog = true;
  bool isStrap = false;
  bool isTimer = false;
  bool isReverseTime = false;
  bool isStopWatch = false;
  String currentDial = "";

  List<String> dials = [
    'lib/assets/images/dial1.png',
    'lib/assets/images/blackdial.png',
    'lib/assets/images/dial2.jpg',
    'lib/assets/images/dial3.png',
    'lib/assets/images/dial4.png',
  ];

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.sizeOf(context);

    return Scaffold(
      backgroundColor: Colors.white,
      drawer: Drawer(
        child: Column(
          children: [
            UserAccountsDrawerHeader(
              currentAccountPicture: CircleAvatar(
                foregroundImage: NetworkImage(
                    "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRS-bz3w3YbiCPW23zQNWR0sjH7WNZFmCV_6Q&s"),
              ),
              accountName: Text("User"),
              accountEmail: Text("user@gmail.com"),
            ),
            Padding(
              padding: EdgeInsets.only(left: 16),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text("Analog Watch"),
                      Switch(
                        value: isAnalog,
                        onChanged: (val) {
                          isAnalog = true;
                          isStrap = false;
                          isTimer = false;
                          isReverseTime = false;
                          isStopWatch = false;
                          isAnalog = val;
                          setState(() {});
                        },
                      ),
                    ],
                  ),
                  Visibility(
                    visible: isAnalog,
                    child: Column(
                      children: [
                        Text(
                          "Slect Dial",
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: dials
                                .map(
                                  (e) => GestureDetector(
                                    onTap: () {
                                      currentDial = e;
                                      setState(() {});
                                    },
                                    child: Container(
                                      height: 100,
                                      width: 100,
                                      padding: EdgeInsets.all(8),
                                      margin: EdgeInsets.only(
                                        right: 8,
                                        top: 8,
                                        bottom: 8,
                                      ),
                                      decoration: BoxDecoration(
                                        image: DecorationImage(
                                            image: AssetImage(e)),
                                        border: e == currentDial
                                            ? Border.all(
                                                width: 5,
                                                strokeAlign: 0.8,
                                                color: Colors.purple,
                                              )
                                            : null,
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                    ),
                                  ),
                                )
                                .toList(),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text("Strap Watch"),
                      Switch(
                        value: isStrap,
                        onChanged: (val) {
                          isAnalog = false;
                          isTimer = false;
                          isReverseTime = false;
                          isStopWatch = false;
                          isStrap = val;
                          setState(() {});
                        },
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text("Digital Watch"),
                      Switch(
                        value: isTimer,
                        onChanged: (val) {
                          isAnalog = false;
                          isStrap = false;
                          isReverseTime = false;
                          isStopWatch = false;
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
                        onChanged: (val) {
                          isAnalog = false;
                          isStrap = false;
                          isTimer = false;
                          isStopWatch = false;
                          isReverseTime = val;
                          setState(() {});
                        },
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text("Stop Watch"),
                      Switch(
                        value: isStopWatch,
                        onChanged: (val) {
                          // isStopWatch = true;
                          isAnalog = false;
                          isTimer = false;
                          isStrap = false;
                          isReverseTime = false;

                          isStopWatch = val;
                          setState(() {});
                        },
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: const Text(
          "Clock App",
          style: TextStyle(
            fontSize: 25,
            fontWeight: FontWeight.w600,
          ),
        ),
        centerTitle: true,
      ),
      body: Column(
        children: [
          //Analog
          Visibility(
            visible: isAnalog,
            child: Column(
              children: [
                Text(
                  "Analog Clock",
                  style: TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Stack(
                  alignment: Alignment.center,
                  children: [
                    Container(
                      width: size.width * 0.9,
                      height: size.height * 0.7,
                      decoration: BoxDecoration(
                        shape: BoxShape.rectangle,
                        image: DecorationImage(
                          image: AssetImage(currentDial),
                          fit: BoxFit.contain,
                        ),
                      ),
                    ),
                    //Second
                    Transform.rotate(
                      angle: s * (pi * 2) / 60,
                      child: Transform.rotate(
                        angle: pi / 2,
                        child: Divider(
                          color: Colors.red,
                          indent: 60,
                          thickness: 3,
                          endIndent: size.width * 0.5, //-16
                        ),
                        // child: Image.network(
                        //   'https://w7.pngwing.com/pngs/691/968/png-transparent-clock-face-minute-clock-hand-monochrome-time.png',
                        //   height: size.width * 0.5, // Adjust the size as needed
                        //   fit: BoxFit.contain,
                        //   alignment: Alignment.topCenter, // Align image top center
                        // ),
                      ),
                    ),
                    //Minute
                    Transform.rotate(
                      angle: m * (pi * 2) / 60,
                      child: Transform.rotate(
                        angle: pi / 2,
                        child: Divider(
                          color:
                              currentDial == 'lib/assets/images/blackdial.png'
                                  ? Colors.white
                                  : Colors.black,
                          indent: 75,
                          thickness: 5,
                          endIndent: size.width * 0.5,
                        ),
                      ),
                    ),
                    //Hour
                    Transform.rotate(
                      angle: h * (pi * 2) / 12,
                      child: Transform.rotate(
                        angle: pi / 2,
                        child: Divider(
                          color:
                              currentDial == 'lib/assets/images/blackdial.png'
                                  ? Colors.white
                                  : Colors.black,
                          indent: 110,
                          thickness: 6,
                          endIndent: size.width * 0.5,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          //Strap
          Visibility(
            visible: isStrap,
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Text(
                "Strap Watch",
                style: TextStyle(
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
          Visibility(
            visible: isStrap,
            child: Expanded(
              child: Center(
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    Container(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          h > 12
                              ? Text(
                                  "PM",
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    fontSize: 20,
                                    color: Colors.black,
                                    fontWeight: FontWeight.w500,
                                  ),
                                )
                              : Text(
                                  "AM",
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    fontSize: 20,
                                    color: Colors.black,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                          Text(
                            "${(h % 12).toString().padLeft(2, '0')} : ${m.toString().padLeft(2, '0')}",
                            style: TextStyle(
                              fontSize: 22,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ],
                      ),
                    ),
                    //Second
                    Transform.scale(
                      scale: 4,
                      child: CircularProgressIndicator(
                        value: s / 60,
                        color: Colors.purple,
                        strokeWidth: 1,
                      ),
                    ),
                    //Minute
                    Transform.scale(
                      scale: 5.5,
                      child: CircularProgressIndicator(
                        value: m / 60,
                        color: Colors.lightBlueAccent,
                        strokeWidth: 2,
                      ),
                    ),
                    //Hour
                    Transform.scale(
                      scale: 7.5,
                      child: CircularProgressIndicator(
                        value: (h % 12) / 12,
                        color: Colors.indigo[900],
                        strokeWidth: 2.8,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          //Digital Timer
          Visibility(
            visible: isTimer,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "Digital Clock",
                  style: TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                200.h,
                Row(
                  // crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    //Hour
                    Container(
                      height: size.height * 0.12,
                      width: size.width * 0.20,
                      alignment: Alignment.center,
                      margin: EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        // shape: BoxShape.circle,
                        border: Border.all(
                          color: Colors.black.withOpacity(0.6),
                          width: 4,
                        ),
                        borderRadius: BorderRadius.circular(16),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.indigo.withOpacity(0.8),
                            blurRadius: 3,
                            offset: Offset(4, 4),
                          ),
                          BoxShadow(
                            color: Colors.indigo.withOpacity(0.4),
                            blurRadius: 5,
                            offset: Offset(-3, -4),
                          ),
                        ],
                      ),
                      // decoration: BoxDecoration(
                      //   color: Colors.white,
                      //   borderRadius: BorderRadius.circular(10),
                      //   boxShadow: [
                      //     BoxShadow(
                      //       color: Colors.indigo,
                      //       blurRadius: 5,
                      //       offset: Offset(5, 5),
                      //     ),
                      //   ],
                      // ),
                      child: Text(
                        "${h % 12}",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 40,
                          fontWeight: FontWeight.bold,
                          // color: Colors.white,
                        ),
                      ),
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        CircleAvatar(
                          radius: 10,
                          backgroundColor: Colors.black,
                        ),
                        Padding(padding: EdgeInsets.all(4)),
                        CircleAvatar(
                          radius: 10,
                          backgroundColor: Colors.black,
                        ),
                      ],
                    ),

                    //Minute
                    Container(
                      height: size.height * 0.12,
                      width: size.width * 0.20,
                      margin: EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        // shape: BoxShape.circle,
                        border: Border.all(
                          color: Colors.black.withOpacity(0.6),
                          width: 4,
                        ),
                        borderRadius: BorderRadius.circular(16),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.indigo.withOpacity(0.8),
                            blurRadius: 5,
                            offset: Offset(4, 5),
                          ),
                          BoxShadow(
                            color: Colors.indigo.withOpacity(0.4),
                            blurRadius: 5,
                            offset: Offset(-3, -5),
                          ),
                        ],
                      ),
                      child: Center(
                        child: Text(
                          "${m}",
                          style: TextStyle(
                            fontSize: 40,
                            fontWeight: FontWeight.bold,
                            // color: Colors.white,
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
                        Padding(padding: EdgeInsets.all(4)),
                        CircleAvatar(
                          radius: 10,
                          backgroundColor: Colors.black,
                        ),
                      ],
                    ),
                    //Second
                    Container(
                      height: size.height * 0.12,
                      width: size.width * 0.20,
                      margin: EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        // shape: BoxShape.circle,
                        border: Border.all(
                          color: Colors.black.withOpacity(0.6),
                          width: 4,
                        ),
                        borderRadius: BorderRadius.circular(16),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.indigo.withOpacity(0.8),
                            blurRadius: 5,
                            offset: Offset(4, 5),
                          ),
                          BoxShadow(
                            color: Colors.indigo.withOpacity(0.4),
                            blurRadius: 5,
                            offset: Offset(-3, -5),
                          ),
                        ],
                      ),
                      child: Center(
                        child: Text(
                          "${s}",
                          style: TextStyle(
                            fontSize: 40,
                            fontWeight: FontWeight.bold,
                            // color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                    // Text("${m}",),
                    // Text(":",),
                    // Text("${s}",),
                  ],
                ),
              ],
            ),
          ),
          //Reverse Timer
          Visibility(
            visible: isReverseTime,
            child: Expanded(
              child: SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Reverse Timer",
                      style: TextStyle(
                        fontSize: 30,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Container(
                      height: size.height * 0.4,
                      width: size.width * 0.55,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        shape: BoxShape.circle,
                        border: Border.all(
                          color: Colors.black.withOpacity(0.6),
                          width: 4,
                        ),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.indigo.withOpacity(0.8),
                            blurRadius: 5,
                            offset: Offset(4, 5),
                          ),
                          BoxShadow(
                            color: Colors.indigo.withOpacity(0.4),
                            blurRadius: 5,
                            offset: Offset(-3, -5),
                          ),
                        ],
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "$usermin".padLeft(2, '0'),
                            style: TextStyle(
                              fontSize: 50,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          8.w,
                          Text(
                            ":",
                            style: TextStyle(
                              fontSize: 50,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          8.w,
                          Text(
                            "$usersec".padLeft(2, '0'),
                            style: TextStyle(
                              fontSize: 50,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ),
                    20.h,
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SizedBox(
                          width: 100,
                          child: TextField(
                            controller: minController,
                            keyboardType: TextInputType.number,
                            textInputAction: TextInputAction.next,
                            inputFormatters: [
                              FilteringTextInputFormatter.digitsOnly,
                            ],
                            decoration: InputDecoration(
                              hintText: 'Minutes',
                              border: OutlineInputBorder(),
                            ),
                          ),
                        ),
                        20.w,
                        SizedBox(
                          width: 100,
                          child: TextField(
                            controller: secController,
                            keyboardType: TextInputType.number,
                            inputFormatters: [
                              FilteringTextInputFormatter.digitsOnly,
                            ],
                            decoration: InputDecoration(
                              hintText: 'Seconds',
                              border: OutlineInputBorder(),
                            ),
                          ),
                        ),
                      ],
                    ),
                    20.h,
                    ElevatedButton(
                      onPressed: () {
                        setState(() {
                          usermin = int.tryParse(minController.text) ?? 0;
                          usersec = int.tryParse(secController.text) ?? 0;
                          startTimer();
                        });
                      },
                      child: Text("Start"),
                    ),
                  ],
                ),
              ),
            ),
          ),
          //Stop Watch
          Visibility(
            visible: isStopWatch,
            child: Column(
              children: [
                Text(
                  "Stop Watch",
                  style: TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Container(
                  height: size.height * 0.4,
                  width: size.width * 0.55,
                  // alignment: Alignment.center,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    shape: BoxShape.circle,
                    border: Border.all(
                      color: Colors.black.withOpacity(0.6),
                      width: 4,
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.indigo.withOpacity(0.8),
                        blurRadius: 5,
                        offset: Offset(4, 5),
                      ),
                      BoxShadow(
                        color: Colors.indigo.withOpacity(0.4),
                        blurRadius: 5,
                        offset: Offset(-3, -5),
                      ),
                    ],
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "${min.toString().padLeft(2, '0')} : ${sec.toString().padLeft(2, '0')}",
                        style: TextStyle(
                          fontSize: 38,
                          fontWeight: FontWeight.w500,
                          color: Colors.black,
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Text(
                            "min\t",
                            style: TextStyle(
                              fontSize: 20,
                              color: Colors.grey.shade500,
                            ),
                          ),
                          Text(
                            "sec",
                            style: TextStyle(
                              fontSize: 20,
                              color: Colors.grey.shade500,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    ElevatedButton(
                      onPressed: () {
                        // if (isrunn && ispause) {
                        StartStopWatch();

                        ispause = !ispause;
                        // ispause = false;
                      },
                      child: !ispause ? Text("Start") : Text("Pause"),
                    ),
                    //10.w,
                    Container(
                      height: size.height * 0.1,
                      width: size.width * 0.1,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.blue,
                      ),
                      child: IconButton(
                        onPressed: () {
                          addLap();
                        },
                        icon: Icon(
                          Icons.flag_rounded,
                          color: Colors.white,
                        ),
                      ),
                    ),
                    ElevatedButton(
                      onPressed: () {
                        resetStopWatch();
                      },
                      child: Text("Stop"),
                    ),
                  ],
                ),
                Container(
                  padding: EdgeInsets.all(16),
                  margin: EdgeInsets.all(16),
                  color: Colors.white,
                  height: size.height * 0.27,
                  width: double.infinity,
                  alignment: Alignment.centerLeft,
                  child: SingleChildScrollView(
                    child: Column(
                      children: List.generate(
                        laps.length,
                        (index) => Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "# ${index + 1}  Lap",
                              style: TextStyle(
                                fontSize: 17,
                              ),
                            ),
                            Text(
                              "${laps[index]}",
                              style: TextStyle(
                                fontSize: 17,
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),

          // Visibility(
          //   visible: isStopWatch,
          //   child: Column(
          //     children: [
          //       Container(
          //         height: size.height * 0.5,
          //         width: size.width * 0.55,
          //         // alignment: Alignment.center,
          //         decoration: BoxDecoration(
          //           color: Colors.white,
          //           shape: BoxShape.circle,
          //           border: Border.all(
          //             color: Colors.black.withOpacity(0.6),
          //             width: 4,
          //           ),
          //           boxShadow: [
          //             BoxShadow(
          //               color: Colors.indigo.withOpacity(0.8),
          //               blurRadius: 5,
          //               offset: Offset(4, 5),
          //             ),
          //             BoxShadow(
          //               color: Colors.indigo.withOpacity(0.4),
          //               blurRadius: 5,
          //               offset: Offset(-3, -5),
          //             ),
          //           ],
          //         ),
          //         child: Column(
          //           mainAxisAlignment: MainAxisAlignment.center,
          //           children: [
          //             Text(
          //               "${min.toString().padLeft(2, '0')} : ${sec.toString().padLeft(2, '0')}",
          //               style: TextStyle(
          //                 fontSize: 38,
          //                 fontWeight: FontWeight.w500,
          //                 color: Colors.black,
          //               ),
          //             ),
          //             Row(
          //               mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          //               children: [
          //                 Text(
          //                   "min\t",
          //                   style: TextStyle(
          //                     fontSize: 20,
          //                     color: Colors.grey.shade500,
          //                   ),
          //                 ),
          //                 Text(
          //                   "sec",
          //                   style: TextStyle(
          //                     fontSize: 20,
          //                     color: Colors.grey.shade500,
          //                   ),
          //                 ),
          //               ],
          //             ),
          //           ],
          //         ),
          //       ),
          //       Row(
          //         mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          //         children: [
          //           ElevatedButton(
          //             onPressed: () {
          //               // if (isrunn && ispause) {
          //               StartStopWatch();
          //               ispause = !ispause;
          //               // ispause = false;
          //             },
          //             child: !ispause ? Text("Start") : Text("Pause"),
          //           ),
          //           //10.w,
          //           Container(
          //             height: size.height * 0.1,
          //             width: size.width * 0.1,
          //             alignment: Alignment.center,
          //             decoration: BoxDecoration(
          //               shape: BoxShape.circle,
          //               color: Colors.blue,
          //             ),
          //             child: IconButton(
          //               onPressed: () {
          //                 addLap();
          //               },
          //               icon: Icon(
          //                 Icons.flag_rounded,
          //                 color: Colors.white,
          //               ),
          //             ),
          //           ),

          // ElevatedButton(
          //   onPressed: () {
          //     resetStopWatch();
          //   },
          //   child: Text("Stop"),
          // ),
          //         ],
          //       ),
          //       Container(
          //         padding: EdgeInsets.all(16),
          //         color: Colors.white,
          //         height: double.infinity,
          //         width: double.infinity,
          //         alignment: Alignment.centerLeft,
          //         child: SingleChildScrollView(
          //           child: Column(
          //             children: List.generate(
          //               laps.length,
          //               (index) => Row(
          //                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
          //                 children: [
          //                   Text(
          //                     "# ${index + 1}  Lap",
          //                     style: TextStyle(
          //                       fontSize: 16,
          //                     ),
          //                   ),
          //                   Text(
          //                     "${laps[index]}",
          //                     style: TextStyle(
          //                       fontSize: 16,
          //                     ),
          //                   )
          //                 ],
          //               ),
          //             ),
          //           ),
          //         ),
          //       ),
          //     ],
          //   ),
          // ),
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

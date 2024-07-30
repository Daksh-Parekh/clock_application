import 'package:flutter/material.dart';

import '../Components/button_tile.dart';

class Buttonpage extends StatelessWidget {
  const Buttonpage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        drawer: const Drawer(
          child: Column(
            children: [
              UserAccountsDrawerHeader(
                currentAccountPicture: CircleAvatar(
                  foregroundImage: NetworkImage("https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRS-bz3w3YbiCPW23zQNWR0sjH7WNZFmCV_6Q&s"),
                ),
                accountName: Text("User"),
                accountEmail: Text("user@gmail.com"),
              ),
            ],
          ),
        ),
        appBar: AppBar(
          title: const Text("Buttons Page"),
        ),
        body: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [
              ButtonTile(
                title: "Text",
                child: TextButton(
                  onPressed: (){},
                  child: const Text("Text"),
                ),
              ),
              ButtonTile(
                title: "Text Icon",
                child: TextButton.icon(
                  onPressed: (){},
                  icon: const Icon(Icons.person),
                  label: const Text("Text"),
                  //style: ButtonStyle(animationDuration: Duration(minutes: 1)),
                ),
              ),
              ButtonTile(
                title: "Icon",
                child: IconButton(
                  onPressed: (){},
                  icon: const Icon(Icons.add),
                ), 
              ),
              ButtonTile(
                title: "Elevated",
                child: ElevatedButton(
                  onPressed: (){},
                  child: const Text("Elevated"), 
                ),
              ),
              ButtonTile(
                title: "Elevated Icon",
                child: ElevatedButton.icon(
                  onPressed: (){},
                  icon: const Icon(Icons.person_2),
                  label: const Text("Elevated"),
                ) 
              ),
              ButtonTile(
                title: "Outlined",
                child: OutlinedButton(
                  onPressed: (){},
                  child: const Text("Outlined"), 
                )
              ),
              ButtonTile(
                title: "Outlined Icon",
                child: OutlinedButton.icon(
                  onPressed: (){},
                  icon: const Icon(Icons.outlet_outlined),
                  label: const Text("Icon"),
                ),
              ),
            ],
          ),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            Navigator.of(context).pushNamed('clock_page');
          },
          child: const Icon(Icons.add),
        ),
      );
    
  }
}
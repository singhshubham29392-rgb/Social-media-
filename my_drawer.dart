import 'package:flutter/material.dart';

class MyDrawer extends StatelessWidget {
  const MyDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: Theme.of(context).colorScheme.surface,
      child:Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Column(
            children: [
              // drawer header
              DrawerHeader(
                  child: Icon(
                    Icons.favorite,
                    size: 80,
                    color: Theme.of(context).colorScheme.inversePrimary,
                  )
              ),
              //home tile
              Padding(
                padding: const EdgeInsets.only(left: 25.0),
                child: ListTile(
                  leading: Icon(Icons.home),
                  title: Text("H O M E"),
                  onTap: () {
                    Navigator.pop(context);
                  },
                ),
              ),
              const SizedBox(height: 25,),
              //profile tile
              Padding(
                padding: const EdgeInsets.only(left: 25.0),
                child: ListTile(
                  leading: Icon(Icons.person),
                  title: Text("P R O F I L E"),
                  onTap: () {
                    Navigator.pushNamed(context, '/profile_page');
                  },
                ),
              ),
              const SizedBox(height: 25,),
              //users tile
              Padding(
                padding: const EdgeInsets.only(left: 25.0),
                child: ListTile(
                  leading: Icon(Icons.group),
                  title: Text("U S E R S"),
                  onTap: () {
                    Navigator.pushNamed(context, '/user_page');
                  },
                ),
              ),
              const SizedBox(height: 25,),
              //settings tile
              Padding(
                padding: const EdgeInsets.only(left: 25.0),
                child: ListTile(
                  leading: Icon(Icons.settings),
                  title: Text("S E T T I N G"),
                  onTap: () {
                    Navigator.pushNamed(context, '/setting_page');
                  },
                ),
              ),
            ],
          ),
          //logout tile
          Padding(
            padding: const EdgeInsets.only(left: 25.0, bottom: 25),
            child: ListTile(
              leading: Icon(Icons.logout),
              title: Text("L O G O U T"),
              onTap: () {
              },
            ),
          ),
        ],
      )
    );
  }
}

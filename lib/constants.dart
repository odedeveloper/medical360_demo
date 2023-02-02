import 'package:flutter/material.dart';

const String appLogo = "assets/images/app-logo.svg";
const String logo = "assets/images/logo.png";

var myDrawer = Drawer(
    child: ListView(padding: EdgeInsets.zero, children: [
  UserAccountsDrawerHeader(
    accountName: Text('John Doe'),
    accountEmail: Text('johndoe@gmail.com'),
    currentAccountPicture: CircleAvatar(
      child: ClipOval(
        child: Image.network(
          "https://media.istockphoto.com/id/1189198083/photo/smiling-attractive-young-lady-looking-talking-to-camera-at-home.jpg?s=612x612&w=0&k=20&c=rQv-HePZ9th7bvdpIkK4Sxk3p_Q9LwNId5P2GiqJGc4=",
          width: 90,
          height: 90,
          fit: BoxFit.cover,
        ),
      ),
    ),
    decoration: const BoxDecoration(
        color: Colors.teal,
        image: DecorationImage(
          image: NetworkImage(
            'https://oflutter.com/wp-content/uploads/2021/02/profile-bg3.jpg',
          ),
          fit: BoxFit.cover,
        )),
  ),
  ListTile(
    leading: Icon(Icons.favorite),
    title: Text('Favorites'),
    onTap: () => null,
  ),
  ListTile(
    leading: Icon(Icons.people),
    title: Text('Friends'),
    onTap: () => null,
  ),
  ListTile(
    leading: Icon(Icons.share),
    title: Text('Share'),
    onTap: () => null,
  ),
  ListTile(
    leading: Icon(Icons.notifications),
    title: Text('Request'),
    onTap: () => null,
  ),
  Divider(),
  ListTile(
    leading: Icon(Icons.settings),
    title: Text('Settings'),
    onTap: () => null,
  ),
  ListTile(
    leading: Icon(Icons.description),
    title: Text('Policies'),
    onTap: () => null,
  ),
  Divider(),
  ListTile(
    leading: Icon(Icons.exit_to_app),
    title: Text('Exit'),
    onTap: () => null,
  ),
]));

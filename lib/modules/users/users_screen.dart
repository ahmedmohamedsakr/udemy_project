import 'package:flutter/material.dart';

import '../../models/user_model.dart';


class UserScreen extends StatelessWidget {
  List<UserModel>users=[
    UserModel(id: 1, name: 'Mohamed Sakr', phone: 01013451614),
    UserModel(id: 2, name: 'Ahmed Sakr', phone: 01013451614),
    UserModel(id: 3, name: 'Ebrahim Sakr', phone: 01013451614),
    UserModel(id: 4, name: 'Abdo Sakr', phone: 01013451614),
    UserModel(id: 5, name: 'Asmaa Sakr', phone: 01013451614),
    UserModel(id: 1, name: 'Mohamed Sakr', phone: 01013451614),
    UserModel(id: 2, name: 'Ahmed Sakr', phone: 01013451614),
    UserModel(id: 3, name: 'Ebrahim Sakr', phone: 01013451614),
    UserModel(id: 4, name: 'Abdo Sakr', phone: 01013451614),
    UserModel(id: 5, name: 'Asmaa Sakr', phone: 01013451614),
    UserModel(id: 1, name: 'Mohamed Sakr', phone: 01013451614),
    UserModel(id: 2, name: 'Ahmed Sakr', phone: 01013451614),
    UserModel(id: 3, name: 'Ebrahim Sakr', phone: 01013451614),
    UserModel(id: 4, name: 'Abdo Sakr', phone: 01013451614),
    UserModel(id: 5, name: 'Asmaa Sakr', phone: 01013451614),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: ListView.separated(
          itemBuilder: (context,index)=>buildUserItem(users[index]),
          separatorBuilder: (context,index)=>Container(
            width: double.infinity,
            height: 1,
            color: Colors.grey[300],
          ),
          itemCount: users.length,
        ),
    );
  }

  Widget buildUserItem(UserModel user) => Padding(
    padding: const EdgeInsets.all(20.0),
    child: Row(
          children: [
            CircleAvatar(
              radius: 30.0,
              child: Text(
                '${user.id}',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                  fontSize: 30.0,
                ),
              ),
            ),
            SizedBox(
              width: 15.0,
            ),
            Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '${user.name}',
                  style: TextStyle(
                    fontSize: 30.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  '${user.phone}',
                  style: TextStyle(
                    color: Colors.grey[300],
                  ),
                )
              ],
            )
          ],
        ),
  );
}

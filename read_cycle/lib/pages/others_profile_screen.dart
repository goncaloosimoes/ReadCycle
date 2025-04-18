import 'package:flutter/material.dart';
import 'package:read_cycle/classes/user.dart';

class OthersProfileScreen extends StatefulWidget {
  final User user;
  const OthersProfileScreen({super.key, required this.user});

  @override
  State<OthersProfileScreen> createState() => _OthersProfileScreen();
}


class _OthersProfileScreen extends State<OthersProfileScreen> {

  @override
  Widget build(BuildContext context) {
    final User user = widget.user;

    return Scaffold(
      appBar: AppBar(
        elevation: 0,
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.only(left: 20, right: 20, bottom: 20,),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CircleAvatar(
                  radius: 50,
                  backgroundColor: Colors.black,
                  child: CircleAvatar(
                    radius: 48,
                    backgroundImage: AssetImage(
                      user.profileImagePath,
                    ),
                  ),
                ),
                const SizedBox(width: 8,),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        user.name,
                        style: TextStyle(
                          fontSize: 25,
                        ),
                      ),
                      Row(
                        children: [
                          Text(
                            user.rating,
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                              fontSize: 20
                            ),
                          ),
                          Icon(
                            Icons.star,
                              color: Colors.amber,
                              size: 25,
                          )
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
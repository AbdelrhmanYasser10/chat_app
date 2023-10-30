import 'package:chat_application_it/models/user_model.dart';
import 'package:flutter/material.dart';

class ChatDetailsScreen extends StatelessWidget {
  final UserModel receiver;
  const ChatDetailsScreen({Key? key,required this.receiver}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        title: Row(
          children: [
            Stack(
              alignment: Alignment.bottomRight,
              children: [
                CircleAvatar(
                  radius: 24.0,
                  backgroundImage: NetworkImage(
                      receiver.imgLink,
                  ),
                ),
                CircleAvatar(
                  radius: 5.0,
                  backgroundColor: receiver.online ? Colors.green:Colors.red,
                ),
              ],
            ),
            const SizedBox(
              width: 15.0,
            ),
            Text(
              receiver.name,
              style: const TextStyle(
                fontSize: 18.0,
                color: Colors.black,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
        leading: IconButton(
          onPressed: (){
            Navigator.pop(context);
          },
          icon: const Icon(
            Icons.arrow_back_ios_outlined,
            color: Colors.black,
          ),
        ),
        elevation: 0.0,
      ),
    );
  }
}

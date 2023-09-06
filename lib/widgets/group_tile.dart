import 'package:chat_app/widgets/routes.dart';
import 'package:flutter/material.dart';
import '../ui/chat_page.dart';


class GroupTile extends StatefulWidget {
  final String userName;
  final String groupId;
  final String groupName;
  const GroupTile({super.key, required this.userName, required this.groupName, required this.groupId,});

  @override
  State<GroupTile> createState() => _GroupTileState();
}

class _GroupTileState extends State<GroupTile> {
  @override
  Widget build(BuildContext context) {
  return GestureDetector(
    onTap: (){
      nextScreen(context,  ChatPage(
        groupId: widget.groupId,
        groupName: widget.groupName,
        userName: widget.userName,
      ),
      );
      
    },

    child: Container(
      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 5),
      child: ListTile(
        leading: CircleAvatar(
          radius: 30,
          backgroundColor: Colors.orange.shade500,
          child: Text(
            widget.groupName.substring(0,1).toLowerCase(),
            textAlign: TextAlign.center,
            style: const TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold
            ),
          ),
        ),
        title: Text(widget.groupName,style: const TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: 18.0,
        ),
        ),
        subtitle: Text("Join the Conversation as ${widget.userName}",
          style: TextStyle(
            fontSize: 13.0,
          ),
        ),
      ),
    ),
  );
  }
}


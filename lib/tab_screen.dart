import 'package:comet_chat_task/messages_screen.dart';
// import 'package:cometchat_calls_uikit/cometchat_calls_uikit.dart';
import 'package:cometchat_chat_uikit/cometchat_chat_uikit.dart';
import 'package:flutter/material.dart';

class TabsScreen extends StatefulWidget {
  const TabsScreen({super.key});

  @override
  State<TabsScreen> createState() => _TabsScreenState();
}

class _TabsScreenState extends State<TabsScreen> {
  int _selectedIndex = 0;
  final PageController _pageController = PageController();

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
    _pageController.jumpToPage(index);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView(
        controller: _pageController,
        onPageChanged: (index) => setState(() => _selectedIndex = index),
        children: [
          CometChatConversations(
            showBackButton: false,
            onItemTap: (conversation) {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => MessagesScreen(
                    user: conversation.conversationWith is User
                        ? conversation.conversationWith as User
                        : null,
                    group: conversation.conversationWith is Group
                        ? conversation.conversationWith as Group
                        : null,
                  ),
                ),
              );
            },
          ),
          // const CometChatCallLogs(),
          const CometChatUsers(),
          const CometChatGroups(),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.chat, color: Colors.black),
            label: "Chat",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.call, color: Colors.black),
            label: "Calls",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person, color: Colors.black),
            label: "Users",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.group, color: Colors.black),
            label: "Groups",
          ),
        ],
      ),
    );
  }
}

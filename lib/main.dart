// // new one
// import 'package:comet_chat_task/tab_screen.dart';
// import 'package:flutter/material.dart';
// import 'package:cometchat_chat_uikit/cometchat_chat_uikit.dart';
// import 'cometchat_config.dart';
// import 'messages_screen.dart';

// void main() => runApp(const MyApp());

// class MyApp extends StatelessWidget {
//   const MyApp({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       title: 'CometChat Demo',
//       theme: ThemeData(primarySwatch: Colors.indigo),
//       home: const Home(),
//     );
//   }
// }

// class Home extends StatelessWidget {
//   const Home({super.key});

//   Future<void> _initCometChat() async {
//     final settings = UIKitSettingsBuilder()
//       ..subscriptionType = CometChatSubscriptionType.allUsers
//       ..autoEstablishSocketConnection = true
//       ..region = CometChatConfig.region
//       ..appId = CometChatConfig.appId
//       ..authKey = CometChatConfig.authKey
//       ..extensions = CometChatUIKitChatExtensions.getDefaultExtensions();

//     await CometChatUIKit.init(uiKitSettings: settings.build());
//     await CometChatUIKit.login(
//       'cometchat-uid-1',
//       onSuccess: (user) => debugPrint("✅ Logged in: ${user.name}"),
//       onError: (e) => debugPrint("❌ Login error: $e"),
//     );
//   }

//   @override
//   Widget build(BuildContext context) {
//     return FutureBuilder(
//       future: _initCometChat(),
//       builder: (ctx, snapshot) {
//         if (snapshot.connectionState != ConnectionState.done) {
//           return const Scaffold(
//             body: Center(child: CircularProgressIndicator()),
//           );
//         }
//         return const ConversationsPage();
//       },
//     );
//   }
// }

// class ConversationsPage extends StatelessWidget {
//   const ConversationsPage({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: SafeArea(
//         child: CometChatConversations(
//           showBackButton: false,
//           onItemTap: (conversation) {
//             final target = conversation.conversationWith;
//             Navigator.push(
//               context,
//               MaterialPageRoute(
//                 builder: (_) => MessagesScreen(
//                   user: target is User ? target : null,
//                   group: target is Group ? target : null,
//                 ),
//               ),
//             );
//           },
//         ),
//       ),
//     );
//   }
// }

// got shit
import 'package:comet_chat_task/tab_screen.dart';
import 'package:flutter/material.dart';
import 'package:cometchat_chat_uikit/cometchat_chat_uikit.dart';
// import 'package:cometchat_calls_uikit/cometchat_calls_uikit.dart';
import 'cometchat_config.dart';
// import 'messages_screen.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'CometChat UI Kit',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const Home(),
    );
  }
}

class Home extends StatelessWidget {
  const Home({super.key});

  Future<void> _initializeAndLogin() async {
    final settings = UIKitSettingsBuilder()
      ..subscriptionType = CometChatSubscriptionType.allUsers
      ..autoEstablishSocketConnection = true
      ..appId = CometChatConfig.appId
      ..region = CometChatConfig.region
      ..authKey = CometChatConfig.authKey
      ..extensions = CometChatUIKitChatExtensions.getDefaultExtensions();
    // ..callingExtension = CometChatCallingExtension();

    await CometChatUIKit.init(uiKitSettings: settings.build());
    await CometChatUIKit.login(
      'cometchat-uid-1', // demo user
      onSuccess: (_) => debugPrint('✅ Login Successful'),
      onError: (err) => throw Exception('Login Failed: $err'),
    );
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<void>(
      future: _initializeAndLogin(),
      builder: (ctx, snapshot) {
        if (snapshot.connectionState != ConnectionState.done) {
          return const Scaffold(
            body: SafeArea(child: Center(child: CircularProgressIndicator())),
          );
        }
        if (snapshot.hasError) {
          return Scaffold(
            body: SafeArea(
              child: Center(child: Text("Error: ${snapshot.error}")),
            ),
          );
        }
        return const TabsScreen();
      },
    );
  }
}

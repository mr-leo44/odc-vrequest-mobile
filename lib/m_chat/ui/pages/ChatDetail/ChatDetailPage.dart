import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:odc_mobile_project/m_chat/ui/pages/ChatDetail/ChatDetailCtrl.dart';

class ChatDetailPage extends ConsumerStatefulWidget {
  @override
  ConsumerState<ChatDetailPage> createState() => _ChatDetailPageState();
}

class _ChatDetailPageState extends ConsumerState<ChatDetailPage> {

  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      var ctrl = ref.read(chatDetailCtrlProvider.notifier);
      ctrl.getPassagers();
    });
  }

  @override
  Widget build(BuildContext context) {
    var state = ref.watch(chatDetailCtrlProvider);
    print(state.passager?.initiateur);

    return Scaffold(
      body: NestedScrollView(
        headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
          return <Widget>[
            SliverAppBar(
              backgroundColor: Colors.amber,
              expandedHeight: 200.0,
              floating: false,
              pinned: true,
              stretch: true,
              flexibleSpace: FlexibleSpaceBar(
                  centerTitle: true,
                  collapseMode: CollapseMode.parallax,
                  title: Text(state.chatDetail.ticket,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 16.0,
                      )),
                  background: Image.network(
                    "https://images.pexels.com/photos/417173/pexels-photo-417173.jpeg?auto=compress&cs=tinysrgb&dpr=2&h=750&w=1260",
                    fit: BoxFit.cover,
                  )),
            ),
          ];
        },
        body: Column(
          children: [
            Container(
              padding: EdgeInsets.symmetric(horizontal: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('1 course'),
                  IconButton(onPressed: () {}, icon: Icon(Icons.search)),
                ],
              ),
            ),
            // SingleChildScrollView(
            //   scrollDirection: Axis.vertical,
            //   child: Column(
            //     children: [
            //     ],
            //   ),
            // ),
            // Expanded(
            //   child: ListView.builder(
            //     itemCount: 1,
            //     itemBuilder: (context, index) => GestureDetector(
            //       onTap: () {},
            //       child: ListTile(
            //         leading: ClipRRect(
            //           borderRadius: BorderRadius.circular(48),
            //           child: Container(
            //             child: Image.asset(chats['avatar']),
            //           ),
            //         ),
            //         title: Text(
            //           chats['ticket'],
            //           style: TextStyle(color: Colors.amber.shade500),
            //         ),
            //         trailing: Column(
            //           mainAxisAlignment: MainAxisAlignment.center,
            //           crossAxisAlignment: CrossAxisAlignment.end,
            //           children: [
            //             ClipRRect(
            //               borderRadius: BorderRadius.circular(50),
            //               child: Container(
            //                 padding: EdgeInsets.symmetric(
            //                     horizontal: 10, vertical: 5),
            //                 color: Colors.amber,
            //                 child: Text(
            //                   "Chauffeur",
            //                   style: TextStyle(
            //                     fontWeight: FontWeight.bold,
            //                   ),
            //                 ),
            //               ),
            //             ),
            //           ],
            //         ),
            //       ),
            //     ),
            //   ),
            // ),
            // //Divider(),
            // Expanded(
            //   child: ListView.builder(
            //     itemCount: 3,
            //     itemBuilder: (context, index) => GestureDetector(
            //       onTap: () {},
            //       child: ListTile(
            //         leading: ClipRRect(
            //           borderRadius: BorderRadius.circular(48),
            //           child: Container(
            //             child: Image.asset(chats['avatar']),
            //           ),
            //         ),
            //         title: Text(
            //           chats['ticket'],
            //           style: TextStyle(color: Colors.amber.shade500),
            //         ),
            //         trailing: Column(
            //           mainAxisAlignment: MainAxisAlignment.center,
            //           crossAxisAlignment: CrossAxisAlignment.end,
            //           children: [
            //             ClipRRect(
            //               borderRadius: BorderRadius.circular(50),
            //               child: Container(
            //                 padding: EdgeInsets.symmetric(
            //                     horizontal: 10, vertical: 5),
            //                 color: Colors.amber,
            //                 child: Text(
            //                   "Chauffeur",
            //                   style: TextStyle(
            //                     fontWeight: FontWeight.bold,
            //                   ),
            //                 ),
            //               ),
            //             ),
            //           ],
            //         ),
            //       ),
            //     ),
            //   ),
            // ),
          ],
        ),
      ),
    );
  }
}

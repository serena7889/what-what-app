import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:what_what_app/models/topic_model.dart';
import 'package:what_what_app/networking/networking_client.dart';
import 'package:what_what_app/ui/components/loading_spinner.dart';
import 'package:what_what_app/ui/components/nav_drawer.dart';
import 'package:what_what_app/ui/components/text_field.dart';
import 'package:what_what_app/ui/styles/colors.dart';
import 'package:what_what_app/ui/styles/fonts.dart';
import 'package:what_what_app/ui/styles/shadows.dart';

class WWManageTopicsScreen extends StatefulWidget {
  static const String pageRoute = "/manage_topics_route";

  const WWManageTopicsScreen({Key? key}) : super(key: key);

  @override
  _WWManageSlotsScreenState createState() => _WWManageSlotsScreenState();
}

class _WWManageSlotsScreenState extends State<WWManageTopicsScreen> {
  @override
  Widget build(BuildContext context) {
    final client = Provider.of<NetworkingClient>(context);
    return Scaffold(
      drawer: WWNavDrawer(),
      appBar: AppBar(
        title: Text("Manage Topics"),
        actions: [
          IconButton(
            onPressed: () => addPressed(context),
            icon: Icon(
              Icons.add,
              color: WWColor.textOverAccentColor,
            ),
          ),
        ],
      ),
      body: Container(
        padding: EdgeInsets.only(top: 20),
        child: FutureBuilder<List<Topic>>(
          future: client.getTopics(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) return WWLoadingSpinner();
            if (snapshot.hasError) Center(child: Text("Error", style: WWFonts.fromOptions(context, color: WWColor.primaryText(context))));
            final topics = snapshot.data!;
            return ListView.builder(
              itemCount: topics.length,
              itemBuilder: (context, i) {
                final topic = topics[i];
                return Padding(
                  padding: EdgeInsets.only(left: 24, right: 24, bottom: 16),
                  child: Container(
                    height: 40,
                    child: Center(child: Text(topic.name)),
                    decoration: BoxDecoration(
                      color: WWColor.secondaryBackground(context),
                      borderRadius: BorderRadius.circular(20),
                      boxShadow: [
                        WWShadow.card.boxShadow(context),
                      ],
                    ),
                  ),
                );
              },
            );
          },
        ),
      ),
    );
  }

  // void showDeleteSlotDialog(BuildContext context, Slot slot) {
  //   showDialog(
  //     context: context,
  //     builder: (context) {
  //       return AlertDialog(
  //         title: Text("Delete Slot?"),
  //         actions: [
  //           TextButton(
  //             child: Text("Delete"),
  //             onPressed: () => removeSlot(slot),
  //           )
  //         ],
  //       );
  //     },
  //   );
  // }

  void triggerRefresh() => setState(() => {});

  // void removeTopic(Topic topic) async {
  //   final client = Provider.of<NetworkingClient>(context);
  //   await client.remove;
  //   triggerRefresh();
  //   Navigator.pop(context);
  // }

  void addPressed(BuildContext context) {
    final topicController = TextEditingController();
    final client = Provider.of<NetworkingClient>(context, listen: false);
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text("Add Title"),
          content: WWTextField(controller: topicController, placeholder: "Topic", style: WWTextFieldStyle.singleLine),
          actions: [
            TextButton(
              onPressed: () async {
                await client.addTopic(topicController.text);
                triggerRefresh();
                Navigator.pop(context);
              },
              child: Text("Add"),
            ),
          ],
        );
      },
    );
    // TODO: Add slot
  }
}

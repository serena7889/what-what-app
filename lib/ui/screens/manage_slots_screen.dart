import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:what_what_app/models/slot_model.dart';
import 'package:what_what_app/networking/networking_client.dart';
import 'package:what_what_app/ui/components/nav_drawer.dart';
import 'package:what_what_app/ui/components/question_cards/scheduled_question_card.dart';
import 'package:what_what_app/ui/components/question_lists/generic_question_list.dart';
import 'package:what_what_app/ui/styles/colors.dart';
import 'package:what_what_app/ui/helpers/datetime_extension.dart';

class WWManageSlotsScreen extends StatefulWidget {
  static const String pageRoute = "/manage_slots_route";

  const WWManageSlotsScreen({Key? key}) : super(key: key);

  @override
  _WWManageSlotsScreenState createState() => _WWManageSlotsScreenState();
}

class _WWManageSlotsScreenState extends State<WWManageSlotsScreen> {
  @override
  Widget build(BuildContext context) {
    final client = Provider.of<NetworkingClient>(context);
    return Scaffold(
      drawer: WWNavDrawer(),
      appBar: AppBar(
        title: Text("Manage Slots"),
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
        child: GenericQuestionList<Slot>(
          getQuestions: client.getSlots,
          cardFromQuestion: (slot, triggerRefresh) {
            return WWScheduledQuestionCard(
              question: slot.question?.text ?? "No Question",
              date: slot.date.toFormattedString(),
              answererName: slot.leader?.name ?? "No Leader",
              onButtonPressed: () => showDeleteSlotDialog(context, slot),
            );
          },
        ),
      ),
    );
  }

  void showDeleteSlotDialog(BuildContext context, Slot slot) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text("Delete Slot?"),
          actions: [
            TextButton(
              child: Text("Delete"),
              onPressed: () => removeSlot(slot),
            )
          ],
        );
      },
    );
  }

  void triggerRefresh() => setState(() => {});

  void removeSlot(Slot slot) async {
    final client = Provider.of<NetworkingClient>(context);
    await client.removeSlot(slot.id);
    triggerRefresh();
    Navigator.pop(context);
  }

  void addPressed(BuildContext context) async {
    var now = DateTime.now();
    DateTime? selectedDate = await showDatePicker(
        context: context,
        initialDate: now,
        firstDate: now,
        lastDate: now.add(Duration(days: 365)),
        builder: (context, child) {
          WWTheme theme = Provider.of<WWTheme>(context);
          return Theme(
            data: theme.themeData,
            child: child!,
          );
        });
    if (selectedDate == null) return;
    final client = Provider.of<NetworkingClient>(context, listen: false);
    bool result = await client.addSlot(selectedDate);
    if (result) print("SLOT ADDED");
    // TODO: Show success popup
    triggerRefresh();
  }
}

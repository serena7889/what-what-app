import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:what_what_app/models/slot_model.dart';
import 'package:what_what_app/networking/networking_client.dart';
import 'package:what_what_app/ui/components/loading_spinner.dart';
import 'package:what_what_app/ui/styles/colors.dart';
import 'package:what_what_app/ui/styles/fonts.dart';

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
      appBar: AppBar(
        title: Text("Manage Slots"),
        actions: [
          IconButton(
              onPressed: () => addPressed(context),
              icon: Icon(
                Icons.add,
                color: WWColor.textOverAccentColor,
              ))
        ],
      ),
      body: FutureBuilder<List<Slot>>(
          future: client.getSlots(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) return WWLoadingSpinner();
            if (snapshot.hasError) {
              return Center(
                child: Text(
                  snapshot.error.toString(),
                  style: WWFonts.fromOptions(context, color: WWColor.primaryText(context)),
                ),
              );
            }
            List<Slot> slots = snapshot.data!;
            return ListView.builder(
                itemCount: slots.length,
                itemBuilder: (context, i) {
                  Slot slot = slots[i];
                  String date = slot.date.toLocal().toString();
                  return Text("$date - ${slot.leader?.name ?? ""} - ${slot.question?.text ?? ""}");
                });
          }),
    );
  }

  void addPressed(BuildContext context) async {
    DateTime? selectedDate = await showDatePicker(context: context, initialDate: DateTime.now(), firstDate: DateTime.now(), lastDate: DateTime.now().add(Duration(days: 365)));
    if (selectedDate != null) {
      DateTime date = selectedDate;
      final client = Provider.of<NetworkingClient>(context, listen: false);
      bool result = await client.addSlot(selectedDate);
      if (result) print("SLOT ADDED");
      setState(() {});
    }
  }
}

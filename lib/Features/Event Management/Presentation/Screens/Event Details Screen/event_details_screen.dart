import 'package:evently/Core/Models/event_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../Core/App Colors/main_colors.dart';
import '../../../../../Core/App Routing/routes.dart';


class EventDetailsScreen extends StatelessWidget {
  const EventDetailsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var event = ModalRoute.of(context)?.settings.arguments as EventModel;
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
            onPressed: () {
              Navigator.pushNamed(context, Routes.formEventScreenRouteName,arguments: event);
            },
            icon: Icon(
                Icons.edit_outlined,
                color: MainColors.getMainColor(),
            ),
          ),
          IconButton(
            onPressed: () {
              // delete Event with id
            },
            icon: Icon(
              Icons.delete_outline,
              color: MainColors.getRedColor(),
            ),
          ),
        ],
        title: Text("${event.eventCategory} Event Details"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(16.r),
                child: Image(
                  image: AssetImage(event.eventCategory),
                  height: 205.h,
                ),
              ),
              Text(event.title)
            ],
          ),
        ),
      ),
    );
  }
}

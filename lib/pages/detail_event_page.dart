import 'package:college_scheduler/config/color_config.dart';
import 'package:college_scheduler/config/text_style_config.dart';
import 'package:college_scheduler/data/models/event_model.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class DetailEventPage extends StatelessWidget {
  const DetailEventPage({
    super.key,
    required this.data
  });

  final EventModel data;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        surfaceTintColor: ColorConfig.backgroundColor,
        backgroundColor: ColorConfig.backgroundColor,
        title: Text(
          "Detail Event",
          style: TextStyleConfig.body1,
        ),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Container(
            margin: const EdgeInsets.all(24.0),
            child: Text(
              data.title ?? "",
              style: TextStyleConfig.heading1bold,
            ),
          ),
          Container(
            decoration: BoxDecoration(
              color: ColorConfig.mainColor
            ),
            padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 16.0),
            child: Row(
              children: [
                Expanded(
                  child: Column(
                    spacing: 4.0,
                    children: [
                      Text(
                        "Date Of Event",
                        style: TextStyleConfig.body1bold,
                      ),
                      Text(
                        DateFormat("d MMMM y").format(data.dateOfEvent ?? DateTime.parse("0000-00-00")),
                        style: TextStyleConfig.body1,
                      )
                    ],
                  ),
                ),
                Expanded(
                  child: Column(
                    spacing: 4.0,
                    children: [
                      Text(
                        "Start Hour",
                        style: TextStyleConfig.body1bold,
                      ),
                      Text(
                        "${data.startHour?.hour}:${data.startHour?.minute}",
                        style: TextStyleConfig.body1,
                      )
                    ],
                  ),
                ),
                Expanded(
                  child: Column(
                    spacing: 4.0,
                    children: [
                      Text(
                        "End Hour",
                        style: TextStyleConfig.body1bold,
                      ),
                      Text(
                        "${data.endHour?.hour}:${data.endHour?.minute}",
                        style: TextStyleConfig.body1,
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 8.0,),
          Container(
            decoration: BoxDecoration(
              color: ColorConfig.mainColor
            ),
            padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 16.0),
            child: Row(
              children: [
                Expanded(
                  child: Column(
                    spacing: 4.0,
                    children: [
                      Text(
                        "Priority",
                        style: TextStyleConfig.body1bold,
                      ),
                      Text(
                        (data.priority?.name ?? "").toUpperCase(),
                        style: TextStyleConfig.body1,
                      )
                    ],
                  ),
                ),
                Expanded(
                  child: Column(
                    spacing: 4.0,
                    children: [
                      Text(
                        "Status",
                        style: TextStyleConfig.body1bold,
                      ),
                      Text(
                        (data.status?.name ?? "").toUpperCase(),
                        style: TextStyleConfig.body1,
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: Container(
              margin: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 16.0),
              padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 16.0),
              decoration: BoxDecoration(
                border: Border.all(color: ColorConfig.mainColor),
                borderRadius: BorderRadius.all(Radius.circular(8.0))
              ),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  spacing: 8.0,
                  children: [
                    Text("Description", style: TextStyleConfig.body1bold,),
                    Text(data.description ?? "", style: TextStyleConfig.body1, textAlign: TextAlign.justify,)
                  ],
                ),
              ),
            ),
          )
        ],
      )
    );
  }
}
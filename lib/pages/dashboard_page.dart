import 'dart:async';

import 'package:college_scheduler/components/quote_widget.dart';
import 'package:college_scheduler/components/text_form_field.dart';
import 'package:college_scheduler/config/color_config.dart';
import 'package:college_scheduler/config/text_style_config.dart';
import 'package:intl/intl.dart';
import 'package:flutter/material.dart';

class DashboardPage extends StatelessWidget {
  const DashboardPage({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SingleChildScrollView(
        child: Column(
          spacing: 24.0,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            QuoteWidget(),
            StatusDashboardWidget(),
            ListItemEventWidget()
          ],
        ),
      ),
    );
  }
}

class StatusDashboardWidget extends StatefulWidget {
  const StatusDashboardWidget({super.key});

  @override
  State<StatusDashboardWidget> createState() => _StatusDashboardWidgetState();
}

class _StatusDashboardWidgetState extends State<StatusDashboardWidget> {

  late DateTime _now;

  @override
  void initState() {
    super.initState();
    _now = DateTime.now();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 24.0),
      child: Row(
        spacing: 24.0,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 24.0),
            child: Column(
              children: [
                TimeTickingWidget(now: _now,),
                Text("${_now.day} / ${_now.month}", style: TextStyleConfig.heading1bold,)
              ],
            ),
          ),
          Expanded(
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(8.0)),
                color: ColorConfig.mainColor,
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey,
                    offset: Offset(2.0, 2.0),
                    blurRadius: 1.0
                  )
                ]
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                spacing: 8.0,
                children: [
                  const SizedBox(),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 24.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text("DONE", style: TextStyleConfig.body1bold,),
                        Text("14", style: TextStyleConfig.body1bold,),
                      ],
                    ),
                  ),
                  const Divider(color: Colors.white, height: 0,),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 24.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text("PROGRESS", style: TextStyleConfig.body1bold,),
                        Text("3", style: TextStyleConfig.body1bold,),
                      ],
                    ),
                  ),
                  const Divider(color: Colors.white, height: 0,),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 24.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text("IDLE", style: TextStyleConfig.body1bold,),
                        Text("5", style: TextStyleConfig.body1bold,),
                      ],
                    ),
                  ),
                  const SizedBox(),
                ],
              ),
            ),
          )
        ],
      ),
    ) ;
  }
}

class TimeTickingWidget extends StatefulWidget {
  TimeTickingWidget({
    super.key,
    required DateTime now
  }) : _now = now;

  DateTime _now;

  @override
  State<TimeTickingWidget> createState() => _TimeTickingWidgetState();
}

class _TimeTickingWidgetState extends State<TimeTickingWidget> with WidgetsBindingObserver{


  late bool _continueTimeTicking;

  late DateTime _timeOutput;

  late Timer _timerTicker;

  late DateFormat _format;

  @override
  void initState() {
    super.initState();

    _continueTimeTicking = true;
    _timeOutput = widget._now;
    _format = DateFormat("jms");

    timeTickingSec();
  }

  @override
  void dispose() {
    super.dispose();

    _timerTicker.cancel();
  }

  void timeTickingSec(){
    _timerTicker = Timer.periodic(const Duration(seconds: 1), (_){
      setState(() {
        _timeOutput = _timeOutput.add(const Duration(seconds: 1));
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Text("${_format.format(_timeOutput)}", style: TextStyleConfig.heading1bold,);
  }
}

class ListItemEventWidget extends StatefulWidget {
  const ListItemEventWidget({super.key});

  @override
  State<ListItemEventWidget> createState() => _ListItemEventWidgetState();
}

class _ListItemEventWidgetState extends State<ListItemEventWidget> {

  late TextEditingController _searchController;

  @override
  void initState() {
    super.initState();

    _searchController = TextEditingController();
  }

  @override
  void dispose() {
    super.dispose();

    _searchController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      spacing: 16.0,
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Expanded(
              child: CustomTextFormField(
                controller: _searchController,
                label: "",
                hint: "Search item by Title",
              ),
            ),
            Container(
              margin: const EdgeInsets.only(right: 24.0),
              decoration: BoxDecoration(
                color: Colors.white,
                border: Border.all(color: ColorConfig.mainColor),
                borderRadius: BorderRadius.all(Radius.circular(8.0))
              ),
              // padding: const EdgeInsets.all(8.0),
              child: Material(
                color: Colors.transparent,
                child: InkWell(
                  splashColor: Colors.black.withAlpha(25),
                  onTap: (){

                  },
                  child: Container(
                    padding: const EdgeInsets.all(12.0),
                    child: Icon(Icons.filter_alt, color: ColorConfig.mainColor,),
                  ),
                ),
              )
            )
          ],
        ),
        ListView.separated(
          separatorBuilder: (context, index) {
            return Divider(
              height: 0.0,
              thickness: 8.0,
              color: ColorConfig.mainColor,
            );
          },
          itemCount: 5,
          shrinkWrap: true,
          physics: NeverScrollableScrollPhysics(),
          itemBuilder: (context, index) {
            return ListItemEventDataWidget();
          },
        )
      ],
    );
  }
}

class ListItemEventDataWidget extends StatelessWidget {
  const ListItemEventDataWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          splashColor: Colors.black.withAlpha(25),
          onTap: (){

          },
          child: Container(
            padding: const EdgeInsets.all(24.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Text(
                  "Tugas Pembuatan Kalkulator Java",
                  style: TextStyleConfig.body1bold,
                ),
                const SizedBox(height: 8.0,),
                Text(
                  "Deadline : 30 Februari 2025",
                  style: TextStyleConfig.body2,
                ),
                const SizedBox(height: 32.0,),
                Text(
                  "Priority : HIGH",
                  style: TextStyleConfig.body2,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
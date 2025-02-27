import 'package:college_scheduler/components/dropdown_menu_component.dart';
import 'package:college_scheduler/components/primary_button.dart';
import 'package:college_scheduler/components/quote_widget.dart';
import 'package:college_scheduler/components/text_form_field.dart';
import 'package:college_scheduler/config/text_style_config.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class InputDataPage extends StatelessWidget {
  const InputDataPage({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SingleChildScrollView(
        child: Column(
          spacing: 24.0,
          // crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            QuoteWidget(),
            Container(
              alignment: Alignment.centerLeft,
              margin: const EdgeInsets.symmetric(horizontal: 24.0),
              child: Text(
                "Create Event Schedule",
                style: TextStyleConfig.heading1,
              ),
            ),
            FormInputDataWidget()
          ],
        ),
      ),
    );
  }
}

class FormInputDataWidget extends StatefulWidget {
  const FormInputDataWidget({super.key});

  @override
  State<FormInputDataWidget> createState() => _FormInputDataWidgetState();
}

class _FormInputDataWidgetState extends State<FormInputDataWidget> {

  late GlobalKey<FormState> _formKey;

  late DateTime _dateEvent;
  late TimeOfDay? _startHour;
  late TimeOfDay? _endHour;

  late TextEditingController _dateEventController;
  late TextEditingController _titleEventController;
  late TextEditingController _startHourController;
  late TextEditingController _endHourController;
  late TextEditingController _descriptionController;
  late TextEditingController _priorityController;
  late TextEditingController _statusController;

  late String _priority;
  late String _status;

  @override
  void initState() {
    super.initState();

    _formKey = GlobalKey<FormState>();

    _dateEvent = DateTime.now();

    _dateEventController = TextEditingController();
    _titleEventController = TextEditingController();
    _descriptionController = TextEditingController();
    _startHourController = TextEditingController();
    _endHourController = TextEditingController();
    _priorityController = TextEditingController();
    _statusController = TextEditingController();

    _priority = "LOW";
    _status = "IDLE";
  }

  @override
  void dispose() {
    super.dispose();

    _dateEventController.dispose();
    _titleEventController.dispose();
    _startHourController.dispose();
    _endHourController.dispose();
    _priorityController.dispose();
    _statusController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        // crossAxisAlignment: CrossAxisAlignment.stretch,
        spacing: 16.0,
        children: [
          CustomTextFormField(
            controller: _dateEventController,
            label: "Date Of Event",
            hint: "Please input Date Of Event",
            readonly: true,
            onTap: () async{
              final dateByUsers = await showDatePicker(
                context: context, 
                firstDate: DateTime(DateTime.now().year - 1), 
                lastDate: DateTime(DateTime.now().year + 1),
                initialDate: _dateEvent
              );

              _dateEventController.text = dateByUsers != null ? DateFormat("y-MM-dd").format(dateByUsers) : "";
              _dateEvent = dateByUsers ?? DateTime.now();
            },
          ),
          CustomTextFormField(
            controller: _titleEventController,
            label: "Title Event",
            hint: "Please input Title Event",
          ),
          Row(
            children: [
              Expanded(
                child: CustomTextFormField(
                  controller: _startHourController,
                  label: "Start Hour",
                  hint: "",
                  readonly: true,
                  onTap: () async{
                    final startHourByUsers = await showTimePicker(
                      context: context,
                      initialTime: TimeOfDay.now(),
                    );

                    _startHourController.text = startHourByUsers != null ? "${startHourByUsers.hour}:${startHourByUsers.minute}:00" : "";
                    _startHour = startHourByUsers;
                  },
                ),
              ),
              Expanded(
                child: CustomTextFormField(
                  controller: _endHourController,
                  label: "End Hour",
                  hint: "",
                  readonly: true,
                  onTap: () async{
                    final endHourByUsers = await showTimePicker(
                      context: context,
                      initialTime: TimeOfDay.now(),
                    );

                    _endHourController.text = endHourByUsers != null ? "${endHourByUsers.hour}:${endHourByUsers.minute}:00" : "";
                    _endHour = endHourByUsers;
                  },
                ),
              )
            ],
          ),
          CustomTextFormField(
            controller: _descriptionController,
            label: "Description",
            hint: "",
            maxLines: 5,
          ),
          DropdownMenuComponent(
            controller: _priorityController,
            label: "Priority",
            menu: [
              DropdownMenuEntry(
                value: "LOW",
                label: "LOW",
              ),
              DropdownMenuEntry(
                value: "MEDIUM",
                label: "MEDIUM",
              ),
              DropdownMenuEntry(
                value: "HIGH",
                label: "HIGH",
              ),
            ],
            value: _priority, 
            onSelected: (value){
              _priorityController.text = value;
              _priority = value;
            },
          ),
          DropdownMenuComponent(
            controller: _statusController,
            label: "Status",
            menu: [
              DropdownMenuEntry(
                value: "IDLE",
                label: "IDLE",
              ),
              DropdownMenuEntry(
                value: "PROGRESS",
                label: "PROGRESS",
              ),
              DropdownMenuEntry(
                value: "DONE",
                label: "DONE",
              ),
            ],
            value: _status, 
            onSelected: (value){
              _statusController.text = value;
              _status = value;
            },
          ),
          Align(
            alignment: Alignment.centerRight,
            child: PrimaryButtonComponent(
              onTap: (){

              },
              label: "Submit",
              width: MediaQuery.sizeOf(context).width * 0.25,
            ),
          ),
          const SizedBox()
        ],
      ),
    );
  }
}
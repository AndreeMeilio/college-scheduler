import 'package:college_scheduler/components/dropdown_menu_component.dart';
import 'package:college_scheduler/components/primary_button.dart';
import 'package:college_scheduler/components/quote_widget.dart';
import 'package:college_scheduler/components/text_form_field.dart';
import 'package:college_scheduler/config/color_config.dart';
import 'package:college_scheduler/config/state_general.dart';
import 'package:college_scheduler/config/text_style_config.dart';
import 'package:college_scheduler/cubit/event/create_event_cubit.dart';
import 'package:college_scheduler/data/models/event_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:toastification/toastification.dart';

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

  late PRIORITY _priority;
  late STATUS _status;

  late CreateAndUpdateEventCubit _cubit;

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

    _priority = PRIORITY.low;
    _status = STATUS.idle;

    _cubit = BlocProvider.of<CreateAndUpdateEventCubit>(context, listen: false);

    if (_cubit.tempDataEvent != null){
      final data = _cubit.tempDataEvent;

      _dateEventController.text = DateFormat("y-MM-dd").format(data?.dateOfEvent ?? DateTime.parse("0000-00-00"));
      _titleEventController.text = data?.title ?? "";
      _descriptionController.text = data?.description ?? "";
      _startHourController.text = "${data?.startHour?.hour}:${data?.startHour?.minute}:00";
      _endHourController.text = "${data?.endHour?.hour}:${data?.endHour?.minute}:00";
      
      _dateEvent = data?.dateOfEvent ?? DateTime.now();
      _startHour = data?.startHour ?? TimeOfDay.now();
      _endHour = data?.endHour ?? TimeOfDay.now();

      _priority = data?.priority ?? PRIORITY.low;
      _status = data?.status ?? STATUS.idle;
    }
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
                value: PRIORITY.low,
                label: "LOW",
              ),
              DropdownMenuEntry(
                value: PRIORITY.medium,
                label: "MEDIUM",
              ),
              DropdownMenuEntry(
                value: PRIORITY.high,
                label: "HIGH",
              ),
            ],
            value: _priority, 
            onSelected: (value){
              _priority = value;
            },
          ),
          DropdownMenuComponent(
            controller: _statusController,
            label: "Status",
            menu: [
              DropdownMenuEntry(
                value: STATUS.idle,
                label: "IDLE",
              ),
              DropdownMenuEntry(
                value: STATUS.progress,
                label: "PROGRESS",
              ),
              DropdownMenuEntry(
                value: STATUS.done,
                label: "DONE",
              ),
            ],
            value: _status, 
            onSelected: (value){
              _status = value;
            },
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Align(
                alignment: Alignment.centerLeft,
                child: PrimaryButtonComponent(
                  label: "Clear",
                  width: MediaQuery.sizeOf(context).width * 0.25,
                  color: Colors.black.withAlpha(1),
                  onTap: (){
                    _priority = PRIORITY.low;
                    _status = STATUS.idle;
                    _dateEvent = DateTime.now();
                    _startHour = TimeOfDay.now();
                    _endHour = TimeOfDay.now();

                    _dateEventController.clear();
                    _titleEventController.clear();
                    _descriptionController.clear();
                    _startHourController.clear();
                    _endHourController.clear();
                    _priorityController.clear();
                    _statusController.clear();

                    _cubit.clearTempDataEvent();
                  },
                ),
              ),
              Align(
                alignment: Alignment.centerRight,
                child: BlocConsumer<CreateAndUpdateEventCubit, StateGeneral>(
                  builder: (context, state){
                    return PrimaryButtonComponent(
                      isLoading: state.state is CreateAndUpdateEventLoadingState,
                      onTap: () async{
                        if (_formKey.currentState?.validate() ?? false){
                          await _cubit.insertAndUpdateEvent(
                            dateOfEvent: _dateEvent,
                            title: _titleEventController.text,
                            startHour: _startHour ?? TimeOfDay(hour: 0, minute: 0),
                            endHour: _endHour,
                            description: _descriptionController.text,
                            priority: _priority,
                            status: _status,
                            isEdit: _cubit.tempDataEvent != null,
                            idEvent: _cubit.tempDataEvent?.id
                          );
                          _cubit.clearTempDataEvent();
                        } else {
                          toastification.show(
                            context: context,
                            autoCloseDuration: const Duration(seconds: 3),
                            style: ToastificationStyle.fillColored,
                            type: ToastificationType.error,
                            title: Text("Create Event Schedule Failed"),
                            description: Text("Please fill the required data"),
                            primaryColor: Colors.red
                          );
                        }
                      },
                      label: "Submit",
                      width: MediaQuery.sizeOf(context).width * 0.25,
                    );
                  }, 
                  listener: (context, state){
                    if (state.state is CreateAndUpdateEventSuccessState){
                      toastification.show(
                        context: context,
                        autoCloseDuration: const Duration(seconds: 3),
                        style: ToastificationStyle.fillColored,
                        type: ToastificationType.success,
                        title: Text("Create Event Schedule Successfully"),
                        description: Text(state.message.toString()),
                        primaryColor: Colors.green
                      );

                      _priority = PRIORITY.low;
                      _status = STATUS.idle;
                      _dateEvent = DateTime.now();

                      _dateEventController.clear();
                      _titleEventController.clear();
                      _descriptionController.clear();
                      _startHourController.clear();
                      _endHourController.clear();
                      _priorityController.clear();
                      _statusController.clear();
                      
                    } else if (state.state is CreateAndUpdateEventFailedState){
                      toastification.show(
                        context: context,
                        autoCloseDuration: const Duration(seconds: 3),
                        style: ToastificationStyle.fillColored,
                        type: ToastificationType.error,
                        title: Text("Create Event Schedule Failed"),
                        description: Text(state.message.toString()),
                        primaryColor: Colors.red
                      );
                    }
                  }
                )
              ),
            ],
          ),
          const SizedBox()
        ],
      ),
    );
  }
}
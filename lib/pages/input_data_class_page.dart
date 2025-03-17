import 'package:college_scheduler/components/dropdown_menu_component.dart';
import 'package:college_scheduler/components/primary_button.dart';
import 'package:college_scheduler/components/text_form_field.dart';
import 'package:college_scheduler/config/state_general.dart';
import 'package:college_scheduler/config/text_style_config.dart';
import 'package:college_scheduler/cubit/class/create_and_update_data_class_cubit.dart';
import 'package:college_scheduler/cubit/lecturer/list_lecturer_cubit.dart';
import 'package:college_scheduler/data/models/class_model.dart';
import 'package:college_scheduler/data/models/lecturer_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shimmer/shimmer.dart';
import 'package:toastification/toastification.dart';

class InputDataClassPage extends StatefulWidget {
  InputDataClassPage({
    super.key,
    this.dataClassFromEdit
  });

  ClassModel? dataClassFromEdit;

  @override
  State<InputDataClassPage> createState() => _InputDataClassPageState();
}

class _InputDataClassPageState extends State<InputDataClassPage> {

  late GlobalKey<FormState> _formKey;
  
  late TextEditingController _nameController;
  late TextEditingController _lectureController;
  late TextEditingController _dayofweekController;
  late TextEditingController _startHourController;
  late TextEditingController _endHourController;

  late DAYOFWEEK _dayofweek;

  TimeOfDay? _startHour;
  TimeOfDay? _endHour;

  LecturerModel? _selectedLecturer;

  late List<LecturerModel?> _itemLecturer;

  late CreateAndUpdateDataClassCubit _cubit;
  late ListLecturerCubit _lecturerCubit;

  @override
  void initState() {
    super.initState();

    _formKey = GlobalKey<FormState>();

    _nameController = TextEditingController();
    _lectureController = TextEditingController();
    _startHourController = TextEditingController();
    _endHourController = TextEditingController();

    _dayofweek = DAYOFWEEK.monday;
    _dayofweekController = TextEditingController();

    _cubit = BlocProvider.of<CreateAndUpdateDataClassCubit>(context, listen: false);
    _lecturerCubit = BlocProvider.of<ListLecturerCubit>(context, listen: false);

    _lecturerCubit.getAllData();
    _lectureController.text = "Select Lecturer";

    if (widget.dataClassFromEdit != null){
      final dataClassEdit = widget.dataClassFromEdit;
      _nameController.text = dataClassEdit?.name ?? "";
      _lectureController.text = dataClassEdit?.lecturerName ?? "";
      _startHourController.text = "${dataClassEdit?.startHour?.hour}:${dataClassEdit?.endHour?.minute}:00";
      _endHourController.text = "${dataClassEdit?.endHour?.hour}:${dataClassEdit?.endHour?.minute}:00";
      
      _startHour = dataClassEdit?.startHour;
      _endHour = dataClassEdit?.endHour;

      _dayofweek = dataClassEdit?.day ?? DAYOFWEEK.monday;
    }
  }

  @override
  void dispose() {
    super.dispose();

    _nameController.dispose();
    _lectureController.dispose();
    _startHourController.dispose();
    _endHourController.dispose();
    _dayofweekController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Input Data Class", style: TextStyleConfig.body1,),
      ),
      body: Form(
        key: _formKey,
        child: Column(
          spacing: 24.0,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  spacing: 16.0,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    CustomTextFormField(
                      controller: _nameController,
                      label: "Class Name",
                      hint: "Input class name",
                      validator: (value){
                        if (_nameController.text.isEmpty){
                          return "Please input the name of the class";
                        }
              
                        return null;
                      },
                      isRequired: true,
                    ),
                    BlocBuilder<ListLecturerCubit, StateGeneral>(
                      builder: (context, state){
                        if (state.state is ListLecturerLoadedState){
                          _itemLecturer = List.from([
                            LecturerModel(
                              id: 0,
                              name: "Select Lecturer",
                              userId: 0
                            )
                          ]);
                          if (state.data.isNotEmpty){
                            _itemLecturer.addAll(List.from(state.data));
                          }
                          return DropdownMenuComponent(
                            label: "Lecturer",
                            controller: _lectureController,
                            value: _selectedLecturer,
                            menu: _itemLecturer.map((data){
                              return DropdownMenuEntry(
                                label: data?.name ?? "",
                                value: data
                              );
                            }).toList(),
                            onSelected: (value){
                              _selectedLecturer = value;
                            },
                          );
                        } else {
                          return Container(
                            margin: const EdgeInsets.symmetric(horizontal: 24.0),
                            child: Column(
                              spacing: 8.0,
                              crossAxisAlignment: CrossAxisAlignment.stretch,
                              children: [
                                Text(
                                  "Lecturer",
                                  style: TextStyleConfig.body1
                                ),
                                Shimmer.fromColors(
                                  baseColor: Colors.grey,
                                  highlightColor: Colors.white,
                                  child: Container(
                                    color: Colors.grey,
                                    height: 50.0,
                                    width: MediaQuery.sizeOf(context).width,
                                  ),
                                )
                              ],
                            ),
                          );
                        } 
                      },
                    ),
                    DropdownMenuComponent(
                      controller: _dayofweekController,
                      label: "Day",
                      menu: [
                        DropdownMenuEntry(
                          value: DAYOFWEEK.monday,
                          label: "Monday",
                        ),
                        DropdownMenuEntry(
                          value: DAYOFWEEK.tuesday,
                          label: "Tuesday",
                        ),
                        DropdownMenuEntry(
                          value: DAYOFWEEK.wednesday,
                          label: "Wednesday",
                        ),
                        DropdownMenuEntry(
                          value: DAYOFWEEK.thursday,
                          label: "Thursday",
                        ),
                        DropdownMenuEntry(
                          value: DAYOFWEEK.friday,
                          label: "Friday",
                        ),
                        DropdownMenuEntry(
                          value: DAYOFWEEK.saturday,
                          label: "Saturday",
                        ),
                        DropdownMenuEntry(
                          value: DAYOFWEEK.sunday,
                          label: "Sunday",
                        ),
                      ],
                      value: _dayofweek, 
                      onSelected: (value){
                        _dayofweek = value;
                      },
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
                                initialTime: _startHour ?? TimeOfDay.now(),
                              );
              
                              _startHourController.text = startHourByUsers != null ? "${startHourByUsers.hour}:${startHourByUsers.minute}:00" : "";
                              _startHour = startHourByUsers;
                            },
                            isRequired: true,
                            validator: (value){
                              if (value?.isEmpty ?? false){
                                return "Please input starting time of the class";
                              }
              
                              return null;
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
                                initialTime: _endHour ?? TimeOfDay.now(),
                              );
              
                              _endHourController.text = endHourByUsers != null ? "${endHourByUsers.hour}:${endHourByUsers.minute}:00" : "";
                              _endHour = endHourByUsers;
                            },
                            isRequired: true,
                            validator: (value){
                              if (value?.isEmpty ?? false){
                                return "Please input ending time of the class";
                              }
              
                              return null;
                            },
                          ),
                        )
                      ],
                    ),
                    const SizedBox(),
                  ],
                ),
              ),
            ),
            BlocConsumer<CreateAndUpdateDataClassCubit, StateGeneral>(
              builder: (context, state){
                return PrimaryButtonComponent(
                  onTap: () async{
                    if (_formKey.currentState?.validate() ?? false){
                      await _cubit.createAndUpdateClass(
                        name: _nameController.text,
                        lecturerName: _lectureController.text.toString() == "Select Lecturer" ? "" : _lectureController.text,
                        dayofweek: _dayofweek,
                        startHour: _startHour ?? TimeOfDay.fromDateTime(DateTime.parse("0001-01-01 00:00:00")),
                        endHour: _endHour ?? TimeOfDay.fromDateTime(DateTime.parse("0001-01-01 00:00:00")),
                        isEdit: widget.dataClassFromEdit != null,
                        idClass: widget.dataClassFromEdit?.id
                      );
                    } else {
                      toastification.show(
                        context: context,
                        autoCloseDuration: const Duration(seconds: 3),
                        style: ToastificationStyle.fillColored,
                        type: ToastificationType.error,
                        title: Text("Create Data Class Failed"),
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
                if (state.state is CreateAndUpdateDataClassSuccessState){
                  toastification.show(
                    context: context,
                    autoCloseDuration: const Duration(seconds: 3),
                    style: ToastificationStyle.fillColored,
                    type: ToastificationType.success,
                    title: Text("Create Data Class Success"),
                    description: Text(state.message ?? ""),
                    primaryColor: Colors.green
                  );
            
                  _nameController.clear();
                  _lectureController.clear();
                  _dayofweekController.clear();
                  _dayofweek = DAYOFWEEK.monday;
                  _startHour = TimeOfDay.now();
                  _endHour = TimeOfDay.now();
                  _startHourController.clear();
                  _endHourController.clear();
                } else if (state.state is CreateAndUpdateDataClassFailedState){
                  toastification.show(
                    context: context,
                    autoCloseDuration: const Duration(seconds: 3),
                    style: ToastificationStyle.fillColored,
                    type: ToastificationType.error,
                    title: Text("Create Data Class Failed"),
                    description: Text(state.message ?? ""),
                    primaryColor: Colors.red
                  );
                }
              },
            ),
            const SizedBox(),
          ],
        ),
      ),
    );
  }
}
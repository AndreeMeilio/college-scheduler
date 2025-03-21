import 'package:college_scheduler/components/dropdown_menu_component.dart';
import 'package:college_scheduler/components/primary_button.dart';
import 'package:college_scheduler/components/text_form_field.dart';
import 'package:college_scheduler/config/color_config.dart';
import 'package:college_scheduler/config/state_general.dart';
import 'package:college_scheduler/config/text_style_config.dart';
import 'package:college_scheduler/cubit/class/create_and_update_data_class_cubit.dart';
import 'package:college_scheduler/cubit/lecturer/list_lecturer_cubit.dart';
import 'package:college_scheduler/data/models/class_model.dart';
import 'package:college_scheduler/data/models/lecturer_model.dart';
import 'package:college_scheduler/utils/toast_notif_utils.dart';
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

    _dayofweek = DAYOFWEEK.selectDay;
    _dayofweekController = TextEditingController();
    _dayofweekController.text = "Select Day";

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
        surfaceTintColor: ColorConfig.backgroundColor,
        backgroundColor: ColorConfig.backgroundColor,
        title: Text("Input Data Class", style: TextStyleConfig.body1,),
      ),
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/background_image.png"),
            fit: BoxFit.cover
          )
        ),
        child: Form(
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
                                  value: data,
                                  enabled: !(data?.name == "Select Lecturer")
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
                            value: DAYOFWEEK.selectDay,
                            label: "Select Day",
                            enabled: false
                          ),
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
                        ToastNotifUtils.showError(
                          context: context,
                          title: "Create Data Class Failed",
                          description: "Please fill the required data"
                        );
                      }
                    },
                    label: "Submit",
                    width: MediaQuery.sizeOf(context).width * 0.25,
                  );
                },
                listener: (context, state){
                  if (state.state is CreateAndUpdateDataClassSuccessState){
                    ToastNotifUtils.showSuccess(
                      context: context,
                      title: "Create Data Class Success",
                      description: state.message ?? ""
                    );
                    
                    _nameController.clear();
                    _lectureController.text = "Select Lecturer";
                    _selectedLecturer = LecturerModel(
                      id: 0,
                      name: "Select Lecturer",
                      userId: 0
                    );
                    _dayofweekController.text = "Select Day";
                    _dayofweek = DAYOFWEEK.selectDay;
                    _startHour = TimeOfDay.now();
                    _endHour = TimeOfDay.now();
                    _startHourController.clear();
                    _endHourController.clear();
                  } else if (state.state is CreateAndUpdateDataClassFailedState){
                    ToastNotifUtils.showError(
                      context: context,
                      title: "Create Data Class Failed",
                      description: state.message ?? ""
                    );
                  }
                },
              ),
              const SizedBox(),
            ],
          ),
        ),
      ),
    );
  }
}
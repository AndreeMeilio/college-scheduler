
import 'package:college_scheduler/components/primary_button.dart';
import 'package:college_scheduler/components/text_form_field.dart';
import 'package:college_scheduler/config/color_config.dart';
import 'package:college_scheduler/config/state_general.dart';
import 'package:college_scheduler/cubit/lecturer/create_lecturer_cubit.dart';
import 'package:college_scheduler/data/models/lecturer_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:toastification/toastification.dart';

class InputDataLecturerPage extends StatefulWidget {
  const InputDataLecturerPage({
    super.key,
    LecturerModel? data
  }) : _data = data;

  final LecturerModel? _data;

  @override
  State<InputDataLecturerPage> createState() => _InputDataLecturerPageState();
}

class _InputDataLecturerPageState extends State<InputDataLecturerPage> {

  late GlobalKey<FormState> _key;
  late TextEditingController _nameController;
  late CreateLecturerCubit _cubit;

  @override
  void initState() {
    super.initState();

    _key = GlobalKey<FormState>();

    _nameController = TextEditingController();
    _cubit = BlocProvider.of<CreateLecturerCubit>(context, listen: false);

    if (widget._data != null){
      _nameController.text = widget._data!.name ?? "";
    }
  }

  @override
  void dispose() {
    super.dispose();

    _nameController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        surfaceTintColor: ColorConfig.backgroundColor,
        backgroundColor: ColorConfig.backgroundColor,
        title: Text(
          "Input Data Lecturer"
        ),
      ),
      body: Column(
        spacing: 24.0,
        children: [
          const SizedBox(),
          Expanded(
            child: SingleChildScrollView(
              child: Form(
                key: _key,
                child: Column(
                  spacing: 16.0,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    CustomTextFormField(
                      controller: _nameController,
                      hint: "Input Lecturer Name",
                      label: "Lecturer Name",
                      validator: (value){
                        if (value?.isEmpty ?? false){
                          return "Please input the name of lecturer";
                        }

                        return null;
                      },
                    )
                  ],
                ),
              ),
            ),
          ),
          BlocConsumer<CreateLecturerCubit, StateGeneral>(
            builder: (context, state){
              return PrimaryButtonComponent(
                label: "Submit",
                isLoading: state.state is CreateLecturerLoadingState,
                onTap: () async{
                  if (_key.currentState?.validate() ?? false){
                    if (widget._data != null){
                      await _cubit.createLecturer(
                        lecturerName: _nameController.text,
                        idLecturer: widget._data?.id,
                        isEditData: true
                      );
                    } else {
                      await _cubit.createLecturer(lecturerName: _nameController.text);
                    }
                  } else {
                    toastification.show(
                      context: context,
                      autoCloseDuration: const Duration(seconds: 3),
                      style: ToastificationStyle.fillColored,
                      type: ToastificationType.error,
                      title: Text("Create Data Lecturer Failed"),
                      description: Text("Please fill the required data"),
                      primaryColor: Colors.red
                    );
                  }
                },
              );
            },
            listener: (context, state){
              if (state.state is CreateLecturerSuccessState){
                toastification.show(
                  context: context,
                  autoCloseDuration: const Duration(seconds: 3),
                  style: ToastificationStyle.fillColored,
                  type: ToastificationType.success,
                  title: Text("Register Success"),
                  description: Text(state.message ?? ""),
                  primaryColor: Colors.green
                );

                _nameController.clear();
              } else if (state.state is CreateLecturerFailedState){
                toastification.show(
                  context: context,
                  autoCloseDuration: const Duration(seconds: 3),
                  style: ToastificationStyle.fillColored,
                  type: ToastificationType.error,
                  title: Text("Create Data Lecturer Failed"),
                  description: Text(state.message ?? ""),
                  primaryColor: Colors.red
                );
              }
            },
          ),
          const SizedBox()
        ],
      ),
    );
  }
}
import 'package:college_scheduler/components/delete_confirmation_component.dart';
import 'package:college_scheduler/components/primary_button.dart';
import 'package:college_scheduler/config/color_config.dart';
import 'package:college_scheduler/config/state_general.dart';
import 'package:college_scheduler/config/text_style_config.dart';
import 'package:college_scheduler/cubit/class/list_data_class_cubit.dart';
import 'package:college_scheduler/data/models/class_model.dart';
import 'package:college_scheduler/pages/input_data_class_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:page_transition/page_transition.dart';
import 'package:shimmer/shimmer.dart';

class DataClassPage extends StatefulWidget {
  const DataClassPage({super.key});

  @override
  State<DataClassPage> createState() => _DataClassPageState();
}

class _DataClassPageState extends State<DataClassPage> {

  late ListDataClassCubit _cubit;

  @override
  void initState() {
    super.initState();

    _cubit = BlocProvider.of<ListDataClassCubit>(context, listen: false);
    _cubit.getAllData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Data Class", style: TextStyleConfig.body1,),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Container(
              margin: const EdgeInsets.all(24.0),
              child: Text(
                "List Data Class",
                style: TextStyleConfig.heading1bold,
              ),
            ),
            BlocBuilder<ListDataClassCubit, StateGeneral>(
              builder: (context, state) {
                if (state.state is ListDataClassLoadedState){
                  return ListView.separated(
                    itemCount: state.data.length,
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    separatorBuilder: (context, index) {
                      return Divider(color: ColorConfig.backgroundColor, height: 2.0,);
                    },
                    itemBuilder: (context, index){
                      return DataClassItemWidget(
                        data: state.data[index],
                        cubit: _cubit,
                      );
                    },
                  );
                } else if (state.state is ListDataClassFailedState){
                  return Center(
                    child: Text(
                      state.message.toString(),
                      style: TextStyleConfig.body1,
                    ),
                  );
                } else {
                  return ListView.separated(
                    itemCount: 5,
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    separatorBuilder: (context, index) {
                      return Divider(color: ColorConfig.backgroundColor, height: 2.0,);
                    },
                    itemBuilder: (context, index){
                      return DataClassItemLoadingWidget();
                    },
                  );
                }
              },
            ),
            Container(
              margin: const EdgeInsets.symmetric(vertical: 24.0),
              alignment: Alignment.center,
              child: PrimaryButtonComponent(
                label: "Create Data Class",
                onTap: (){
                  Navigator.push(context, PageTransition(
                    type: PageTransitionType.rightToLeft,
                    child: InputDataClassPage()
                  ));
                },
              ),
            )
          ],
        ),
      )
    );
  }
}

class DataClassItemWidget extends StatelessWidget {
  const DataClassItemWidget({
    super.key,
    required ClassModel data,
    required ListDataClassCubit cubit
  }) : _data = data,
       _cubit = cubit;

  final ClassModel _data;
  final ListDataClassCubit _cubit;

  @override
  Widget build(BuildContext context) {
    return Slidable(
      key: ValueKey(_data.id),
      startActionPane: ActionPane(
        motion: ScrollMotion(),
        children: [
          SlidableAction(
            onPressed: (context) {
              Navigator.push(context, PageTransition(
                type: PageTransitionType.rightToLeft,
                child: InputDataClassPage(
                  dataClassFromEdit: _data,
                )
              ));
            },
            label: "Edit",
            backgroundColor: ColorConfig.mainColor.withAlpha(75),
            icon: Icons.edit,
          ),
          SlidableAction(
            onPressed: (context) async{
              showModalBottomSheet(
                context: context,
                builder: (context){
                  return DeleteConfirmationComponent(
                    onCancel: (){
                      Navigator.pop(context);
                    }, 
                    onProcceed: () async{
                      await _cubit.deleteData(data: _data);

                      if (context.mounted){
                        Navigator.pop(context);
                      }
                    }
                  );
                }
              );
            },
            label: "Delete",
            backgroundColor: Colors.red,
            icon: Icons.edit,
          ),
        ],
      ),
      child: Container(
        decoration: BoxDecoration(
          color: ColorConfig.mainColor,
        ),
        padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 8.0),
        child: Column(
          spacing: 4.0,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              _data.name.toString(),
              style: TextStyleConfig.body1bold,
            ),
            Text(
              _data.lecturerName.toString(),
              style: TextStyleConfig.body1,
            ),
            const SizedBox(height: 4.0,),
            Row(
              children: [
                Expanded(
                  child: Align(
                    alignment: Alignment.center,
                    child: Text(
                      "${_data.day?.name[0].toUpperCase()}${_data.day?.name.substring(1)}",
                      style: TextStyleConfig.body1,
                    ),
                  )
                ),
                Expanded(
                  child: Align(
                    alignment: Alignment.center,
                    child: Text(
                      "${_data.startHour?.hour}:${_data.startHour?.minute}",
                      style: TextStyleConfig.body1,
                    ),
                  )
                ),
                Text(
                  "s/d",
                  style: TextStyleConfig.body1,
                ),
                Expanded(
                  child: Align(
                    alignment: Alignment.center,
                    child: Text(
                      "${_data.endHour?.hour}:${_data.endHour?.minute}",
                      style: TextStyleConfig.body1,
                    ),
                  )
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}

class DataClassItemLoadingWidget extends StatelessWidget {
  const DataClassItemLoadingWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: ColorConfig.mainColor,
      ),
      padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 8.0),
      child: Column(
        spacing: 4.0,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Shimmer(
            gradient: LinearGradient(colors: [
              Colors.grey,
              Colors.black
            ]),
            child: Text(
              "Data Dummy 1",
              style: TextStyleConfig.body1bold,
            ),
          ),
          Shimmer(
            gradient: LinearGradient(colors: [
              Colors.grey,
              Colors.black
            ]),
            child: Text(
              "Data Dummy 1",
              style: TextStyleConfig.body1,
            ),
          ),
          const SizedBox(height: 4.0,),
          Row(
            children: [
              Expanded(
                child: Align(
                  alignment: Alignment.center,
                  child: Shimmer(
                    gradient: LinearGradient(colors: [
                      Colors.grey,
                      Colors.black
                    ]),
                    child: Text(
                      "Data Dummy 1",
                      style: TextStyleConfig.body1,
                    ),
                  )
                )
              ),
              Expanded(
                child: Align(
                  alignment: Alignment.center,
                  child: Shimmer(
                    gradient: LinearGradient(colors: [
                      Colors.grey,
                      Colors.black
                    ]),
                    child: Text(
                      "Data Dummy 1",
                      style: TextStyleConfig.body1,
                    ),
                  ),
                )
              ),
              Text(
                "s/d",
                style: TextStyleConfig.body1,
              ),
              Expanded(
                child: Align(
                  alignment: Alignment.center,
                  child: Shimmer(
                    gradient: LinearGradient(colors: [
                      Colors.grey,
                      Colors.black
                    ]),
                    child: Text(
                      "Data Dummy 1",
                      style: TextStyleConfig.body1,
                    ),
                  ),
                )
              ),
            ],
          )
        ],
      ),
    );
  }
}
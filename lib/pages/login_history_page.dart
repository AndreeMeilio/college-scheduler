
import 'package:college_scheduler/config/color_config.dart';
import 'package:college_scheduler/config/state_general.dart';
import 'package:college_scheduler/config/text_style_config.dart';
import 'package:college_scheduler/cubit/logs/login_logs_cubit.dart';
import 'package:college_scheduler/data/models/logs_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:shimmer/shimmer.dart';

class LoginHistoryPage extends StatefulWidget {
  const LoginHistoryPage({super.key});

  @override
  State<LoginHistoryPage> createState() => _LoginHistoryPageState();
}

class _LoginHistoryPageState extends State<LoginHistoryPage> {

  late LoginLogsCubit _cubit;

  @override
  void initState() {
    super.initState();

    _cubit = BlocProvider.of<LoginLogsCubit>(context, listen: false);

    _cubit.getAllLoginLogs();
  }

  @override
  void dispose() {
    super.dispose();

    _cubit.close();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Login History",
          style: TextStyleConfig.body1,
        ),
      ),
      body: BlocConsumer<LoginLogsCubit, StateGeneral<LoginLogsState, List<LogsModel?>?>>(
        builder: (context, state){
          if (state.data?.isNotEmpty ?? false){
            return ListView.builder(
              itemCount: state.data?.length,
              itemBuilder: (context, index){
                return LoginHistoryItemWidget(
                  logsModel: state.data?[index],
                );
              },
            );
          } else {
            return Container(
              margin: const EdgeInsets.all(24.0),
              alignment: Alignment.center,
              child: Text(
                state.message.toString(),
                style: TextStyleConfig.body1bold,
              ),
            );
          }
        },
        listener: (context, state){
          
        },
      )
    );
  }
}

class LoginHistoryItemWidget extends StatelessWidget {
  const LoginHistoryItemWidget({
    super.key,
    required this.logsModel
  });

  final LogsModel? logsModel;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 8.0),
      padding: const EdgeInsets.symmetric(vertical: 16.0, horizontal: 24.0),
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(color: ColorConfig.mainColor),
        borderRadius: BorderRadius.all(Radius.circular(8.0)),
        boxShadow: [
          BoxShadow(
            color: Colors.grey,
            offset: Offset(1, 1),
            spreadRadius: 1.0
          )
        ]
      ),
      child: Column(
        spacing: 16.0,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Row(
            spacing: 16.0,
            children: [
              Text(
                logsModel?.actionName?.toUpperCase() ?? "",
                style: TextStyleConfig.body1bold,
              ),
              Expanded(
                child: Text(
                  DateFormat("d MMMM y hh:mm:ss").format(logsModel?.createdAt ?? DateTime.parse("0000-00-00")),
                  style: TextStyleConfig.body1,
                ),
              )
            ],
          ),
          Text(
            "Account with username andreemeilioc login to system at ${logsModel?.createdAt}",
            style: TextStyleConfig.body2,
            textAlign: TextAlign.justify,
          )
        ],
      )
    );
  }
}

class LoginHistoryItemLoadingWidget extends StatelessWidget {
  const LoginHistoryItemLoadingWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 8.0),
      padding: const EdgeInsets.symmetric(vertical: 16.0, horizontal: 24.0),
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(color: ColorConfig.mainColor),
        borderRadius: BorderRadius.all(Radius.circular(8.0)),
        boxShadow: [
          BoxShadow(
            color: Colors.grey,
            offset: Offset(1, 1),
            spreadRadius: 1.0
          )
        ]
      ),
      child: Column(
        spacing: 16.0,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Row(
            spacing: 16.0,
            children: [
              Shimmer.fromColors(
                baseColor: Colors.grey,
                highlightColor: Colors.white,
                child: Container(
                  color: Colors.grey,
                  height: 10.0,
                  width: MediaQuery.sizeOf(context).width * 0.2,
                ),
              ),
              Expanded(
                child: Shimmer.fromColors(
                  baseColor: Colors.grey,
                  highlightColor: Colors.white,
                  child: Container(
                    color: Colors.grey,
                    height: 10.0,
                    width: MediaQuery.sizeOf(context).width * 0.2,
                  ),
                ),
              )
            ],
          ),
          Shimmer.fromColors(
            baseColor: Colors.grey,
            highlightColor: Colors.white,
            child: Container(
              color: Colors.grey,
              height: 25.0,
              width: MediaQuery.sizeOf(context).width,
            ),
          ),
        ],
      )
    );
  }
}
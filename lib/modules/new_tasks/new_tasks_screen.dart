import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:udemy_course/shared/components/components.dart';
import 'package:udemy_course/shared/components/constants.dart';
import 'package:udemy_course/shared/cubit/cubit.dart';
import 'package:udemy_course/shared/cubit/states.dart';

class NewTasksScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit, AppState>(
      listener: (context, state) {},
      builder: (context, state) {
        var tasks = AppCubit.get(context).tasks;
        return ListView.separated(
          itemBuilder: (context, index){
            print('task status$index: ${tasks[index]['status']}');
            return databaseList(
              model: tasks[index],
              context: context,
            );
          },
          separatorBuilder: (context, index) => Container(
            width: double.infinity,
            height: 1.0,
            color: Colors.grey,
          ),
          itemCount: AppCubit.get(context).tasks.length,
        );
      },
    );
  }
}

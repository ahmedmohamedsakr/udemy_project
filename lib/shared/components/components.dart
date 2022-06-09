import 'package:flutter/material.dart';
import 'package:udemy_course/shared/cubit/cubit.dart';

Widget defaultTextFormField({
  required TextEditingController controller,
  required TextInputType type,
  Function(String)? onSubmit,
  Function(String)? onChange,
  required String? Function(String?) validate,
  bool secure = false,
  required IconData prefixIcon,
  IconData? suffixIcon,
  Function()? onPressed,
  Function()? onTap,
  required String label,
}) =>
    TextFormField(
      controller: controller,
      keyboardType: type,
      obscureText: secure,
      onFieldSubmitted: onSubmit,
      onChanged: onChange,
      validator: validate,
      onTap: onTap,
      decoration: InputDecoration(
        prefixIcon: Icon(prefixIcon),
        suffixIcon: suffixIcon != null
            ? IconButton(
                onPressed: onPressed,
                icon: Icon(suffixIcon),
              )
            : null,
        labelText: label,
        border: OutlineInputBorder(),
      ),
    );

Widget defaultButton({
  required Function() function,
  Color background = Colors.blue,
  double width = double.infinity,
  double height = 50.0,
  double radius = 8.0,
  required String text,
}) =>
    Container(
      width: width,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(radius),
        color: background,
      ),
      child: MaterialButton(
        onPressed: function,
        height: height,
        child: Text(
          text,
          style: TextStyle(
              fontWeight: FontWeight.w900, fontSize: 20.0, color: Colors.white),
        ),
      ),
    );

Widget databaseList({required Map model, required context}) => Padding(
      padding: const EdgeInsets.all(20.0),
      child: Row(
        children: [
          CircleAvatar(
            radius: 40.0,
            child: Text(
              '${model['time']}',
            ),
          ),
          const SizedBox(
            width: 20.0,
          ),
          Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                '${model['title']}',
                style: TextStyle(
                  fontSize: 20.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                '${model['date']}',
                style: TextStyle(
                  color: Colors.grey,
                ),
              ),
            ],
          ),
          IconButton(
            onPressed: () {
              AppCubit.get(context).updateData(
                status: 'done',
                id: model['id'],
              );
            },
            icon: Icon(
              Icons.check_box,
              color: Colors.green,
            ),
          ),
          IconButton(
            onPressed: () {
              AppCubit.get(context).updateData(
                status: 'archived',
                id: model['id'],
              );
            },
            icon: Icon(
              Icons.archive,
              color: Colors.black38,
            ),
          ),
        ],
      ),
    );

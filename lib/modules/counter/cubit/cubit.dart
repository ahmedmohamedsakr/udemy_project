import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:udemy_course/modules/counter/cubit/states.dart';

class CounterCubit extends Cubit<CounterStates>{    //Cubit<has only one abstract class so make states class extend it>

  CounterCubit():super(InitialCounterState());

   int counter=1;

   static CounterCubit get(context)=> BlocProvider.of(context); //to make a global object to use it at all screens.

   void minus(){
     counter--;
     emit(MinusCounterState());
   }
   void plus(){
     counter++;
     emit(PlusCounterState());
   }
}
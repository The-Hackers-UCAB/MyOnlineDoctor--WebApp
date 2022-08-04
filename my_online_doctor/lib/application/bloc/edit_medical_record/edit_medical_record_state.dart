//Project imports:
part of 'edit_medical_record_bloc.dart';

//RecordEditState: Here we define the states of the RecordEditBloc.
abstract class RecordEditState {}

class RecordEditStateInitial extends RecordEditState {}

class RecordEditStateLoading extends RecordEditState {}

class RecordEditStateHideLoading extends RecordEditState {}

class RecordEditStateDataFetched extends RecordEditState {}

class RecordEditStateSuccess extends RecordEditState {}

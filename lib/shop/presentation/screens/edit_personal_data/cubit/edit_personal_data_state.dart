abstract class EditPersonalDataState {
  const EditPersonalDataState({
    this.message,
  });
  final String? message;
}

class EditPersonalDataInitialState extends EditPersonalDataState {}

class EditPersonalDataLoadingState extends EditPersonalDataState {}

class EditPersonalDataErrorState extends EditPersonalDataState {
  const EditPersonalDataErrorState({
    super.message,
  });
}

class EditPersonalDataSuccessState extends EditPersonalDataState {
  const EditPersonalDataSuccessState({
    super.message,
  });
}

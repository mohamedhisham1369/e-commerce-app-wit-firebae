
abstract class EditprofileState {}

class EditprofileInitial extends EditprofileState {}
class get_data_loading_state extends EditprofileState {}
class get_data_succes_state extends EditprofileState {}
class get_data_error_state extends EditprofileState {}
class ImagePickedState extends EditprofileState {}

class updata_loading_state extends EditprofileState {}
class updata_sucess_state extends EditprofileState {}
class updata_error_state extends EditprofileState {}
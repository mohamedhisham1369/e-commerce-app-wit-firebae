
abstract class cartState {}

class cartInitstate extends cartState {}

class getcart_loading_state extends cartState {}
class getcart_success_state extends cartState {
  final double value;
  getcart_success_state(this.value);
}
class getcart_error_state extends cartState {}
class delete_loading_state extends cartState {}
class delete_success_state extends cartState {

}
class delete_error_state extends cartState {}

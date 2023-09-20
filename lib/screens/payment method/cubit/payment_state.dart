
abstract class PaymentState {}

class PaymentInitial extends PaymentState {}
class orderloadingstate extends PaymentState {}
class ordersucessstate extends PaymentState {}

class ordererrorstate extends PaymentState {}

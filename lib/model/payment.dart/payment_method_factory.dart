import 'payment_method.dart';

class PaymentMethodFactory {
   int methodIndex;
   late IPaymentMethod paymentMethod;
    PaymentMethodFactory({required this.methodIndex}){
      if (methodIndex == 0) {
      paymentMethod= Visa();
    } else if (methodIndex == 1) {
      paymentMethod= PayPal();
    } else if (methodIndex == 2) {
      paymentMethod= MasterCard();
    } else {
      paymentMethod= Visa();
    }
   } 
}
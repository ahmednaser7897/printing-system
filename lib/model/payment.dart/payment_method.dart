abstract class IPaymentMethod {
  String withdraw(int amount);
}

class PayPal implements IPaymentMethod {
  @override
  String withdraw(int amount) {
    return 'You Add $amount \$ in Your Card By PayPal';
  }
}

class Visa implements IPaymentMethod {
  @override
  String withdraw(int amount) {
    return 'You Add $amount \$ in Your Card By Visa';
  }
}

class MasterCard implements IPaymentMethod {
  @override
  String withdraw(int amount) {
    return 'You Add $amount \$ in Your Card By MasterCard';
  }
}

/// The `PaymentMethodEnum` enum represents the available payment methods.
/// It includes the following options:
/// - `cash`: Cash payment method.
/// - `visa`: Visa payment method.
///
/// Each payment method has an associated integer value that can be accessed using the `value` property.
/// [1] means cash and [2] means visa

enum PaymentMethodEnum {
  cash(1),
  visa(2);

  const PaymentMethodEnum(
    this.value,
  );
  final int value;
}

class TPricingCalculator {
  static double calculateTotalPrice(double productPrice, String location, {double discount=0.0}) {
    double taxRate = getTaxRateForLocation(location);
    double taxAmount = productPrice * taxRate;
    double shippingCost = getShippingCost(location);
    double discountedPrice = productPrice -discount;
    double totalPrice = discountedPrice + taxAmount + shippingCost;
    return totalPrice;
  }

  static String calculateShippingCost(double productPrice, String location) {
    double shippingCost = getShippingCost(location);
    return shippingCost.toStringAsFixed(2);
  }

  static String calculateTax(double productPrice, String location) {
    double taxRate = getTaxRateForLocation(location);
    double taxAmount = productPrice * taxRate;
    return taxAmount.toStringAsFixed(2);
  }

  static double getTaxRateForLocation(String location) {
    return 0.10;
  }

  static double getShippingCost(String location) {
    return 50.00;
  }
}

/// Prices are integers in the smallest currency unit (24900 = 249.00),
/// exactly like the API contract. Change the symbol to your currency.
const String currencySymbol = r'$';
 
String formatMoney(int minorUnits) =>
    '$currencySymbol${(minorUnits / 100).toStringAsFixed(2)}';
 
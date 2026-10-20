const String currencySymbol = r'$';
 
String formatMoney(int minorUnits) =>
    '$currencySymbol${(minorUnits / 100).toStringAsFixed(2)}';
 
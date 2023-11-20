/// Creating the UPI Details Class
class UPIDetails {
  /// Specifies the Payee Address or the business virtual payment address (VPA) i.e Payee UPI ID
  ///
  /// The [upiID] property is required to transfer the amount to the Payee UPI ID
  ///
  final String upiID;

  /// Specifies the Payee Name or the Business Name
  ///
  /// The [payeeName] property is required so as to cross verify the payeename with UPI ID,
  /// so to check the transaction is valid or not
  final String payeeName;

  /// Defines the transaction ID
  ///
  /// The [transactionID] property is optional, you can specify the transaction id or else not
  ///
  /// Default value is empty String
  ///
  final String? transactionID;

  /// Defines the amount to be transferred to the Payee UPI
  ///
  /// The [amount] property is required, you need to specify the amount you going to transfer
  ///
  final double? amount;

  /// Defines the code of the currency.
  ///
  /// The [currencyCode] is just optional Default Code is INR
  ///
  final String currencyCode;

  /// Defines the Note to view to the payee when you are paying.
  ///
  /// The [transactionNote] is justion optional, Default value is empty String
  ///
  final String? transactionNote;

  UPIDetails({
    required this.upiID,
    required this.payeeName,
    this.transactionID = "",
    this.amount = 0,
    this.currencyCode = "INR",
    this.transactionNote = "",
  });
  // upi://pay?pa=imshibaji@okicici&pn=Shibaji Debnath&am=50&cu=INR&mode=01&purpose=10&orgid=-&sign=-&tn=Just Test
  String get qrCodeValue {
    if (amount == null) {
      return "upi://pay?pa=$upiID&pn=$payeeName&tr=$transactionID&am=0&cu=$currencyCode&mode=01&purpose=10&orgid=-&sign=-&tn=$transactionNote";
    }
    return "upi://pay?pa=$upiID&pn=$payeeName&tr=$transactionID&am=$amount&cu=$currencyCode&mode=01&purpose=10&orgid=-&sign=-&tn=$transactionNote";
  }
}

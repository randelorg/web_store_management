class PaymentHistoryModel {
  String? collectionID, givenDate, collectionAmount;

  get getCollectionID => this.collectionID;

  set setCollectionID(String collectionID) => this.collectionID = collectionID;

  get getCollectionAmount => this.collectionAmount;

  set setCollectionAmount(String collectionAmount) =>
      this.collectionAmount = collectionAmount;

  get getGivenDate => this.givenDate;

  set setGivenDate(String givenDate) => this.givenDate = givenDate;

  PaymentHistoryModel.empty();

  PaymentHistoryModel.full({
    this.collectionID,
    this.collectionAmount,
    this.givenDate,
  }) {
    this.collectionID = collectionID;
    this.collectionAmount = collectionAmount;
    this.givenDate = givenDate;
  }

  factory PaymentHistoryModel.fromJson(Map<String, dynamic> json) {
    return PaymentHistoryModel.full(
      collectionID: json['CollectionID'] as String,
      collectionAmount: json['CollectionAmount'] as String,
      givenDate: json['GivenDate'] as String,
    );
  }
}

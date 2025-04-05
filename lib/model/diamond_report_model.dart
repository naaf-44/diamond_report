class DiamondReportModel {
  String? qty;
  String? lotID;
  String? size;
  String? carat;
  String? lab;
  String? shape;
  String? color;
  String? clarity;
  String? cut;
  String? polish;
  String? symmetry;
  String? fluorescence;
  String? discount;
  String? perCaratRate;
  String? finalAmount;
  String? keyToSymbol;
  String? labComment;

  DiamondReportModel({
    this.qty,
    this.lotID,
    this.size,
    this.carat,
    this.lab,
    this.shape,
    this.color,
    this.clarity,
    this.cut,
    this.polish,
    this.symmetry,
    this.fluorescence,
    this.discount,
    this.perCaratRate,
    this.finalAmount,
    this.keyToSymbol,
    this.labComment,
  });

  factory DiamondReportModel.fromList(List<dynamic> row) {
    return DiamondReportModel(
      qty: row[3]?.toString(),
      lotID: row[4]?.toString(),
      size: row[5]?.toString(),
      carat: row[6]?.toString(),
      lab: row[7]?.toString(),
      shape: row[8]?.toString(),
      color: row[9]?.toString(),
      clarity: row[10]?.toString(),
      cut: row[11]?.toString(),
      polish: row[12]?.toString(),
      symmetry: row[13]?.toString(),
      fluorescence: row[14]?.toString(),
      discount: row[15]?.toString(),
      perCaratRate: row[16]?.toString(),
      finalAmount: ((double.tryParse(row[6]!.toString()) ?? 0) * (double.tryParse(row[16]!.toString()) ?? 0)).toString(),
      keyToSymbol: row[18]?.toString(),
      labComment: row[19]?.toString(),
    );
  }

}

class DiamondReportModel {
  String? lotID;
  double? size;
  double? carat;
  String? lab;
  String? shape;
  String? color;
  String? clarity;
  String? cut;
  String? polish;
  String? symmetry;
  String? fluorescence;
  double? discount;
  double? perCaratRate;
  double? finalAmount;
  String? keyToSymbol;
  String? labComment;

  DiamondReportModel({
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

  factory DiamondReportModel.fromJson(Map<String, dynamic> json) {
    return DiamondReportModel(
      lotID: json['lotID'] as String?,
      size: (json['size'] as num?)?.toDouble(),
      carat: (json['carat'] as num?)?.toDouble(),
      lab: json['lab'] as String?,
      shape: json['shape'] as String?,
      color: json['color'] as String?,
      clarity: json['clarity'] as String?,
      cut: json['cut'] as String?,
      polish: json['polish'] as String?,
      symmetry: json['symmetry'] as String?,
      fluorescence: json['fluorescence'] as String?,
      discount: (json['discount'] as num?)?.toDouble(),
      perCaratRate: (json['perCaratRate'] as num?)?.toDouble(),
      finalAmount: (json['finalAmount'] as num?)?.toDouble(),
      keyToSymbol: json['keyToSymbol'] as String?,
      labComment: json['labComment'] as String?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'lotID': lotID,
      'size': size,
      'carat': carat,
      'lab': lab,
      'shape': shape,
      'color': color,
      'clarity': clarity,
      'cut': cut,
      'polish': polish,
      'symmetry': symmetry,
      'fluorescence': fluorescence,
      'discount': discount,
      'perCaratRate': perCaratRate,
      'finalAmount': finalAmount,
      'keyToSymbol': keyToSymbol,
      'labComment': labComment,
    };
  }

  factory DiamondReportModel.fromList(List<dynamic> row) {
    return DiamondReportModel(
      lotID: row[0]?.toString(),
      size: _parseDouble(row[1]),
      carat: _parseDouble(row[2]),
      lab: row[3]?.toString(),
      shape: row[4]?.toString(),
      color: row[5]?.toString(),
      clarity: row[6]?.toString(),
      cut: row[7]?.toString(),
      polish: row[8]?.toString(),
      symmetry: row[9]?.toString(),
      fluorescence: row[10]?.toString(),
      discount: _parseDouble(row[11]),
      perCaratRate: _parseDouble(row[12]),
      finalAmount: _parseDouble(row[13]),
      keyToSymbol: row[14]?.toString(),
      labComment: row[15]?.toString(),
    );
  }

  static double? _parseDouble(dynamic value) {
    if (value == null) return null;
    return double.tryParse(value.toString());
  }
}

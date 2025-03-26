class Hymnal {
  final String message;
  final String transposedMxl;
  final String transposedPdf;

  Hymnal({required this.message, required this.transposedMxl, required this.transposedPdf});

  factory Hymnal.fromJson(Map<String, dynamic> json) {
    return Hymnal(
      message: json['message'],
      transposedMxl: json['transposed_mxl'],
      transposedPdf: json['transposed_pdf'],
    );
  }
}

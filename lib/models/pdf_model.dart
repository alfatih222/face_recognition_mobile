class PdfResponse {
  final String id;
  final String path;
  final String? pathWithoutDomain;

  PdfResponse({required this.id, required this.path, this.pathWithoutDomain});

  factory PdfResponse.fromJson(Map<String, dynamic> json) {
    return PdfResponse(
      id: json['id'],
      path: json['path'],
      pathWithoutDomain: json['path_without_domain'],
    );
  }
}

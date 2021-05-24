class HomeBanner {
  final String bannerId;
  final String imageUrl;

  HomeBanner({required this.bannerId, required this.imageUrl});

  static HomeBanner fromJson(dynamic json) {
    return HomeBanner(
      bannerId: json['bannerId'] as String,
      imageUrl: json['image'] as String
    );
  }
}
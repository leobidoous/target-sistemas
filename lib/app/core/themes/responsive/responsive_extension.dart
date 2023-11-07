import './size_config.dart';

/// Extension to use values using [num]
extension Responsive on num {
  /// [getter] to get [responsive height] according to device height
  double get responsiveHeight => SizeConfig.heightMultiplier * this;

  /// [getter] to get [responsive width] according to device width
  double get responsiveWidth => SizeConfig.widthMultiplier * this;

  /// [getter] to get [responsive fontSize] according to device width
  double get fontSize => SizeConfig.textMultiplier * this;
}

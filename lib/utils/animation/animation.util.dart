class AnimationUtil {
  // Takes two points and a value between both points and generates percentage
  double percentBetweenPoints({
    required double lowerBound,
    required double upperBound,
    required double state,
  }) {
    if (state > upperBound) {
      return 1;
    }

    if (state < lowerBound) {
      return 0;
    }

    double divisor = upperBound - lowerBound;
    double numerator = state - lowerBound;

    return numerator / divisor;
  }
}

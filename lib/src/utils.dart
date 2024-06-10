double getInterpolateY(double y, int index, double cardHeight, double position,
    double isBottom, double isAppearing) {
  double yVal =
      _lerp(y, 0, 0.00001 + index * cardHeight, 0, -index * cardHeight);
  double pos = _lerp(position, isBottom, isAppearing, 0, -cardHeight / 4);

  return yVal + pos + y;
}

double getInterpolatePos(
    double position, double cardHeight, double isBottom, double isAppearing) {
  double pos = _lerp(position, isBottom, isAppearing, 0, -cardHeight / 4);
  return pos;
}

double getAnimatedScale(double position, double isDisappearing, double isTop,
    double isBottom, double isAppearing) {
  double scale = _lerp4(
      position, isDisappearing, isTop, isBottom, isAppearing, 0.5, 1, 1, 0.5);
  return scale;
}

double getAnimatedOpacity(double position, double isDisappearing, double isTop,
    double isBottom, double isAppearing) {
  return _lerp4(
      position, isDisappearing, isTop, isBottom, isAppearing, 0.5, 1, 1, 0.5);
}

/// Linearly interpolates between two values.
double _lerp(double t, double t0, double t1, double v0, double v1) {
  if (t <= t0) return v0;
  if (t >= t1) return v1;
  return v0 + (t - t0) / (t1 - t0) * (v1 - v0);
}

/// Linearly interpolates between four values with clamping.
double _lerp4(double t, double t0, double t1, double t2, double t3, double v0,
    double v1, double v2, double v3) {
  if (t <= t0) return v0;
  if (t >= t3) return v3;
  if (t <= t1) return _lerp(t, t0, t1, v0, v1);
  if (t <= t2) return _lerp(t, t1, t2, v1, v2);
  return _lerp(t, t2, t3, v2, v3);
}

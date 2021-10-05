class Utility {
  /// Trying to cast the input as the desired, return `null` if the casting fails
  static T? cast<T>(x) => x is T ? x : null;
}

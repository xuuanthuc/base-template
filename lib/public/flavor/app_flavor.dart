
enum Flavor {
  development,
  release,
}

class AppFlavor {
  static Flavor appFlavor = Flavor.development;

  static String get baseApi {
    switch (appFlavor) {
      case Flavor.release:
        return 'https://';
      case Flavor.development:
        return 'http://';
      default:
        return 'http://';
    }
  }
}
class Ringtone {
  final String name;
  final String url;
  final String numberOfListens;

  Ringtone(
      {required this.name, required this.url, required this.numberOfListens});

  String formatNumber() {
    var numberOfListens = double.parse(this.numberOfListens);
    List<String> suffixes = ["", "K", "M", "B", "T"];
    int i = 0;
    while (numberOfListens >= 1000 && i < suffixes.length - 1) {
      numberOfListens /= 1000;
      i++;
    }
    return numberOfListens.toStringAsFixed(2).replaceAll('.', ',') +
        suffixes[i];
  }
}

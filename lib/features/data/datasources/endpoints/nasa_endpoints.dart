class NasaEndpoints {
  static String apod(String apiKey, String date) =>
      "https://api.nasa.gov/planetery/apod?api key=$apiKey&date=$date";
}

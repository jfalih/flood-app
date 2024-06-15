class Urls {
  static String baseUrl = 'http://flood.asia/api';
  static String assetUrl = 'http://flood.asia/storage/images/';
  static String registrationUrl = '$baseUrl/auth/register';
  static String loginUrl = '$baseUrl/auth/login';
  static String placesUrl = '$baseUrl/places';
  static String historyUrl = '$baseUrl/history';
  static String placesRecommendationUrl = '$baseUrl/places/recommendation';
  static String bookingUrl(String id) => '$baseUrl/booking/$id';
  static String receiptUrl(String id) => '$baseUrl/receipt/$id';
  static String categoryUrl = '$baseUrl/categories';

  static String detailCategory(String id) => '$baseUrl/category/$id/places';
  
  static String changeStatus(String taskId, String status) =>
      '$baseUrl/updateTaskStatus/$taskId/$status';

  static String deleteTask(String taskId) => '$baseUrl/deleteTask/$taskId';
}

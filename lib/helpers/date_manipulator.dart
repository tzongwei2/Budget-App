
Map<String, DateTime> getCurrentMonthSg(DateTime date) {
  // Convert the input month to Singapore time
  DateTime singaporeDate = date.toUtc().add(const Duration(hours: 8));

  // Start and end of the month in Singapore time
  DateTime startOfMonth = DateTime(singaporeDate.year, singaporeDate.month,  1, 0, 0, 0);
  DateTime endOfMonth = DateTime(singaporeDate.year, singaporeDate.month + 1, 0);

  return {
    'startOfMonth': startOfMonth,
    'endOfMonth': endOfMonth,
  };
}
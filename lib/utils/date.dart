class DateUtils {
  static String formatDate(DateTime date) {
    String result = '';
//    print(date.toLocal().toString());
    result += date.year.toString();
//    print(date.month);
    if(date.month < 10) {
      result += '-0' + date.month.toString();
    } else {
      result += '-' + date.month.toString();
    }
    if(date.day < 10) {
      result += '-0' + date.day.toString();
    } else {
      result += '-' + date.day.toString();
    }
    return result;
  }

  static String formatDateSixHoursAgo(DateTime date) {
    date = date.subtract(new Duration(hours: 6));
    String result = '';
//    print(date.toLocal().toString());
    result += date.year.toString();
//    print(date.month);
    if(date.month < 10) {
      result += '-0' + date.month.toString();
    } else {
      result += '-' + date.month.toString();
    }
    if(date.day < 10) {
      result += '-0' + date.day.toString();
    } else {
      result += '-' + date.day.toString();
    }
    return result;
  }

  static String formatDateAddEightHours(DateTime date) {
    date = date.add(new Duration(hours: 8));
    String result = '';
//    print(date.toLocal().toString());
    result += date.year.toString();
    if(date.month < 10) {
      result += '-0' + date.month.toString();
    } else {
      result += '-' + date.month.toString();
    }
    if(date.day < 10) {
      result += '-0' + date.day.toString();
    } else {
      result += '-' + date.day.toString();
    }
    result += ' ';
    if(date.hour < 10) {
      result += '0' + date.hour.toString();
    } else {
      result += date.hour.toString();
    }

    if(date.minute < 10) {
      result += ':0' + date.minute.toString();
    } else {
      result += ':' + date.minute.toString();
    }

    return result;
  }

  static String formatDateToDaysAgo(String date) {
    DateTime dateTime = DateTime.parse(date);
    DateTime now = DateTime.now();
    int seconds = (now.millisecondsSinceEpoch - dateTime.millisecondsSinceEpoch) ~/ (60 * 1000);
    if(seconds == 0) {
      return '刚刚';
    }
    if(seconds < 60) {
      return seconds.toString() + '分钟前';
    }
    seconds = seconds ~/ 60;
//    print(seconds);
    if(seconds < 24) {
      return seconds.toString() + '小时前';
    }
    if(seconds < (24 * 7)) {
      return (seconds ~/ 24).toString() + '天前';
    }
    if(seconds < (24 * 30)) {
      return (seconds ~/ (24 * 7)).toString() + '周前';
    }
    if(seconds < (24 * 365)) {
      return (seconds ~/ (24 * 30)).toString() + '月前';
    }
    if(seconds > (24 * 365)) {
      return (seconds ~/ (24 * 365)).toString() + '年前';
    }
  }
}
/*
 * 时间格式化
 */
class TimeParse {
  static String parse(int time) {
    print('time : $time');
    try {
      if (time < 60) {
        return '00:' + (time < 10 ? '0$time' : "$time");
      } else {
        int rem = time % 60;
        int min = time ~/ 60;
        return '0$min:' + (rem < 10 ? '0$rem' : "$rem");
      }
    } catch (e) {
      print('异常');
      print(e);
      return '00:00';
    }
  }
}

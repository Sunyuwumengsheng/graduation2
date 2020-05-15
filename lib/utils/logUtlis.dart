class LogUtils {
  //dart.vm.product 环境标识位 Release为true debug 为false
  static const bool isRelease = const bool.fromEnvironment("dart.vm.product");

  static void d(String tag, Object message) {
    if (!isRelease) _printLog(tag, 'D -> ', message);
  }

  static void i(String tag, Object message) {
    _printLog(tag, 'I -> ', message);
  }

  static void e(String tag, Object message, {Exception e}) {
    _printLog(tag, 'E -> ', message);
  }

  static void _printLog(String tag, String level, Object message) {
    StringBuffer sb = new StringBuffer();
    sb..write(level)..write(tag ?? '')..write(': ')..write(message);
    print(sb.toString());
  }
}
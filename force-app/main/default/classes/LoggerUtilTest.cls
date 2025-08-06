@IsTest
private class LoggerUtilTest {
  @IsTest
  static void testLog() {
    LoggerUtil.log('Test log message');
    LoggerUtil.logError('Test error message');
    LoggerUtil.logWarning('Test warning message');
  }
}
public without sharing class LoggerUtil {
  public static void log(String message) {
    System.debug(LoggingLevel.INFO, message);
  }

  public static void logError(String message) {
    System.debug(LoggingLevel.ERROR, message);
  }

  public static void logWarning(String message) {
    System.debug(LoggingLevel.WARN, message);
  }
}
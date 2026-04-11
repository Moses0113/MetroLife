/// API endpoint constants
/// 參考: prd.md Section 5.1 (HKO) & 5.2 (KMB)
library;

class ApiConstants {
  ApiConstants._();

  // ========== Hong Kong Observatory (HKO) ==========
  static const String hkoWeatherUrl =
      'https://data.weather.gov.hk/weatherAPI/opendata/weather.php';

  static const String hkoCsdiWfsUrl =
      'https://portal.csdi.gov.hk/server/services/common/hko_rcd_1634806665997_63899/MapServer/WFSServer';

  // ========== KMB (九巴) ==========
  static const String kmbBaseUrl =
      'https://data.etabus.gov.hk/v1/transport/kmb';
  static const String kmbAllStops = '$kmbBaseUrl/stop';
  static const String kmbStopEta = '$kmbBaseUrl/stop-eta';
  static const String kmbRoute = '$kmbBaseUrl/route';
  static const String kmbRouteStop = '$kmbBaseUrl/route-stop';
}

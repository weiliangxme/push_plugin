import 'dart:collection';


import 'package:mz_rsa_plugin/mz_rsa_plugin.dart';



class RSAUtil {

  static const String PRIVATE_KEY = "MIIEvgIBADANBgkqhkiG9w0BAQEFAASCBKgwggSkAgEAAoIBAQC9etzFVGK4IqGNfbAhynCw+EqamSH/oPtjsoxPjcrTo54oRF+s+hG4CRgx61jPC4y/IT3dkUIvxV6NpZwXZDyRr+V1aOtvrSv837xej7aaie61Kw4618Jt0qSiCtVQLFCigQWm3Gv3MFGeZFka3uSJfmx4oKwFF+6r7jgRxaNBHLUI06VXmVinDvH6zuoSmsvJCgE6qb5kJJOUUGaagObfQvNCmsD+xqpzyGpKAcXU4n80WBjIHHYslyDqATIVoq6NFHKmExKRk6NYqmE1r8EBhhHFcVfc+zIhgjIOimRtUtIwuRL7sUltWSktEC/rT7KyBu3g6k3i6+Nmo87gtol/AgMBAAECggEABsncFwXK86Xp+9PA97T1DKIYqilKWoo993hyJneCCMsX44FvnBbpg5pvz3oLGH/lbwOV39ZQdL2xgYmpaf0hXmba5bX4mWuu48RwT0L+29KNRthgDiOkx6KAW33f3pt32BqfRTcodxa4FeCqgJfzwClTYY8AGr6cwnQqdhiKnM6GotH7U74PuQGW5jGaYmBSjn+AaGw64/elA2AfGgUBNQUfcCS/KFLIqs72UkKXAZbcczep1l5+PJbyRu+hN73BN+o8XeT7wDIO6/RrQmJ/8GSrDGp3o3rHEqxE2s/t04ycblxcLqz46CJmqqnEeOAhcawUEyHujmcWHc59JuuQoQKBgQDyqiGuX2VwqAIkVfT/qtTS2rx3YetQmKisKJEYA07HLYD3Anm3/RO1ht1OE3e5iaIPRiy6kH2ertsTPJk2n17dfiWgYVaS+NjpiUXFejBRJMhDs32Yh0k+YEJBJJJZsIzbS0l5ShiBr7xoWsaFhVqGoupGiF86duhD44mQwJv/LQKBgQDH5IPwPWTPPUWCODQg7A6zt5BiKxmm544dK4O5pESGZZ6cKr09qPSzxUWy+dHee3T8Ig4IhFdAsfCCyYu6HPki3bYYeA0AH0q9hARP+or1bzXMNRy8gXq5KD6vKR7JYHyy+Wk3rDzOKWiMzsBiJqe6CUbENy3/wp9Chac4vQb22wKBgQC73j9pMm3khA30d5/P+EAAZlwWyPZXVXjwoA+E2bq5tV7s3TvC1+nUVe8rrSK5v/Z5gMjMP2Uh3xm4kOfFRCk7rZgPzIwsCQBV/XLI6kpR5/orf+Cyn7py0i85I8kyKt9CP81IW7cRYC6rU+vyH0Xwilx58sZXCwvS02wDZzremQKBgQCOIu6ygGVTe4UWgHKIynH11txDAdS+ur5x/YQwGB9l1ZKAB2ADHUXLIsZZ6owSAIWB15FU+w20AhM8XKYPlBSPd0nJgmv0H0wdEGekm0n+FbMSXt3tKMCkMnrIQJwUo5hoBzOLE90013rxTP69jDEN9xSr53S8/Z4TRkhO7xKpqwKBgFXGeTPZCwu7KhVPag6aivHesDCUgTGubaxOgYeYxFtulGu9ENwJNtCmWB55tEey193VvPRoYiHMVsjvyl0nMPqWAbffLuaWRMgPK0V3035adeHdZFtgMG01qh9m9vYkmfrqUPNYVzWUoaUNc4wICj3FgGWHiUKeRFuLFDlOl7pP";

  static Future<String> encrypt(Map<String, dynamic> map, String key) async {
    var st = SplayTreeMap.from(map);
    var content = _mapToString(st);
    String encryptContent = await MzRsaPlugin.encryptStringByPrivateKey(content, key);
    return encryptContent.replaceAll('\n', '').replaceAll('\r', '');
  }

  static String _mapToString(Map value) {
    var list = [];
    value.forEach((key, value) {
      list.add('$key=$value');
    });
    return list.join('&');
  }


}
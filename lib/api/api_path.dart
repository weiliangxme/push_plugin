class ApiPath{
  static String pushUrl = "https://cospush.test.bee996.com";


  //registered device id
  static const registerPushId = "/push-server/client/reg";

  static const unRegisterPushId = "/push-server/client/cancel";

  //Report push click interface
  static const reportPushClick = "/push-server/sendPlanDetail/checkNum";

  //set message as read interface
  static const setNotificationRead = "/push-server/message/updateReadState";

  //Clear all unread messages
  static const updateReadStateAll = "/push-server/message/updateReadStateAll";

  //message center
  static const getMessageCenterData = "/push-server/message/findMessageSummary";

  // message center list data by type
  static const getMessageListByType = "/push-server/message/partition/page";

  static const changeNotificationState = "/push-server/message/preferences/saveUserMessagePreferences";

  //获得用户消息偏好设置
  static const getUserNotificationStates = "/push-server/message/preferences/getUserMessagePreferences";

  //改变用户消息总开关的状态值
  static const updateUserNotificationState = "/push-server/message/preferences/updateUserPrimaryPreferencesState";

}
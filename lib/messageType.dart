enum MessageType {
  // 1 文本
  TEXT,
  // 2 系统表情
  FACE,
  // 3 位置
  LOCATION,
  // 4 图片
  IMAGE,
  // 5 音频
  VOICE,
  // 6 视频
  VIDEO,
  // 7 文件
  FILES,
  // 8 操作类消息
  CMD,
  // 9 引用消息
  ReferMsg,
  // 10 合并转发消息
  MultiMsg,
  //个人名片
  CARD,
  // 撤回消息
  RETRACT,
  // 邀请入群名片
  JoinGroupCardBody,
  // 转发外部动态
  ForeignDyn,
  // 新增群公告
  AddGroupNotice,
  // Gif
  GIF,
  //音视频通话
  AVChat,
  //群直播操作类消息
  AVGroupCard,
}
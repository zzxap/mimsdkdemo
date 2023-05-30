
enum cmdType {

  //用户相关
  ping(0xFFFF), //客户端发起心跳
  pong(0xFFFE), //服务端心跳响应
  receivedConfirm(0x415), //客户端各种业务接口确认回包
  receivedSingleChatConfirm(0x416), //单聊回包确认，双向的
  receivedGroupChatConfirm(0x417), //群聊回包确认，双向的
  receivedSingleChatOfflineConfirm(0x47A), //离线转在线回包
  receivedGroupChatOfflineConfirm(0x47B), //群聊离线转在线回包
  receivedBatchTransferConfirm(0x419), //多人转发回包

  //用户相关
  connect(0x3EA), //连接管道
  disconnect(0x3EC), //断开管道
  backOffline(0x3ED), //退到后台
  userChangedNotify(0x3F2), //推送个人资料更新通知
  loginNotify(0x431), //推送主动登录通知 -App登录，通知其他端
  logoutNotify(0x432), //推送主动退出通知 -App主动退出，通知其他端
  forceExitNotify(0x43B), //推送强制退出通知 -其他端强制将某一端APP退出
  repeatLoginNotify(0x43D), //推送重复登录通知 -同端重复时通知最后一个
  adminForceExitNotify(0xBB8), //系统管理员踢用户下线 -通知被踢用户全部退出
  adminDeletedUserNotify(0xBB9), //系统管理员删除用户

  //会话相关
  updateConversationNotify(0x1392), //更新会话
  deleteConversationNotify(0x1393), //删除会话

  //好友关系链相关
  friendshipAddedNotify(0x3F8), //推送成为好友通知
  friendshipChangedNotify(0x3F3), //推送好友关系链更新通知 - 设置好友备注名、自定义字段，通知其他端
  deletedFriendNotify(0x3FB), //推送删除好友通知
  addFriendApplyNotify(0x3F7), //推送添加好友申请通知 -
  friendApplyAllReadedNotify(0xFA0), //推送好友申请全部已读通知
  approvFriendApplyNotify(0x418), //推送审批好友申请通知 -同意、拒绝、删除、忽略
  addedFriendGroupNotify(0xFA1), //推送添加分组通知
  addedFriendGroupItemsNotify(0xFA2), //推送添加好友到分组通知
  removedFriendGroupItemsNotify(0xFA3), //推送分组中移出好友通知
  renamedFriendGroupNotify(0xFA4), //推送分组重命名通知
  addedBlacklistNotify(0xFA5), //推送添加黑名单通知
  deletedBlacklistNotify(0xFA6); //推送删除黑名单通知

  const cmdType(this.value);

  final int value;

  static cmdType? fromValue(int value) {
    for (var type in cmdType.values) {
      if (type.value == value) return type;
    }
    return null;
  }
}




/*
enum CmdType {
  Invalid = 0,
  ping = 0xFFFF,
pong = 0xFFFE, //服务端心跳响应
receivedConfirm = 0x415, //客户端各种业务接口确认回包
receivedSingleChatConfirm = 0x416, //单聊回包确认，双向的
receivedGroupChatConfirm = 0x417, //群聊回包确认，双向的
receivedSingleChatOfflineConfirm = 0x47A, //离线转在线回包
receivedGroupChatOfflineConfirm = 0x47B, //群聊离线转在线回包
receivedBatchTransferConfirm = 0x419, //多人转发回包

//连接管道
connect = 0x3EA, //1002

//断开管道
disconnect = 0x3EC, //1004

//退到后台
backOffline = 0x3ED, //1005

//推送个人资料更新通知
userChangedNotify = 0x3F2, //1010

//推送主动登录通知 -App登录，通知其他端
loginNotify = 0x431, //1073

//推送主动退出通知 -App主动退出，通知其他端
logoutNotify = 0x432, //1074

//推送强制退出通知 -其他端强制将某一端APP退出
forceExitNotify = 0x43B, //1083

//推送重复登录通知 -同端重复时通知最后一个
repeatLoginNotify = 0x43D, //1085

//系统管理员踢用户下线 -通知被踢用户全部退出
adminForceExitNotify = 0xBB8, //3000

//系统管理员删除用户
adminDeletedUserNotify = 0xBB9, //3001

/*******************会话相关*****************/

//更新会话
updateConversationNotify = 0x1392, //5010

//删除会话
deleteConversationNotify = 0x1393, //5011

/***************好友关系链******************/
///推送成为好友通知
friendshipAddedNotify = 0x3F8, //1016

///推送好友关系链更新通知 - 设置好友备注名、自定义字段，通知其他端
friendshipChangedNotify = 0x3F3, //1011

///推送删除好友通知
deletedFriendNotify = 0x3FB, //1019

///推送添加好友申请通知 -
addFriendApplyNotify = 0x3F7, //1015

///推送好友申请全部已读通知
friendApplyAllReadedNotify = 0xFA0, //4000

///推送审批好友申请通知 -同意、拒绝、删除、忽略
approvFriendApplyNotify = 0x418, //1048

///推送添加分组通知
addedFriendGroupNotify = 0xFA1, /4001

///推送添加好友到分组通知
addedFriendGroupItemsNotify = 0xFA2, /4002

///推送分组中移出好友通知
removedFriendGroupItemsNotify = 0xFA3, /4003

///推送分组重命名通知
renamedFriendGroupNotify = 0xFA4, /4004

///推送添加黑名单通知
addedBlacklistNotify = 0xFA5, /4005

///推送删除黑名单通知
deletedBlacklistNotify = 0xFA6, /4006

/***************群组相关******************/
createGroupNotify = 0x3F4,//1012

updateGroupNotify = 0x3F5,//1013

applyJoinGroupNotify = 0x3FF,//1023

inviteJoinGroupNotify = 0x401,//1025

approveJoinGruopApplyNotify = 0x400,//1024

quitGroupNotify = 0x402,//1026

addedNewGroupMemberNotify= 0x403,//1027

modifyGroupMemberNotify= 0x404,//1028

deleteGroupMemberNotify= 0x405,//1029

dismissGroupNotify= 0x410,//1040

updateGroupRemarkNotify= 0x411,//1041

/***************消息相关******************/
userSingleChat= 0x44F,//1103

groupChat= 0x450,//1104

messageReadedReceiptConfirm= 0x453,//1107

singleOfflineMessage= 0x454,//1108

groupOfflineMessage= 0x455,//1109

burnMsgAfterReadSingleChat= 0x457,//1111

burnMsgAfterReadSingleChatConfirm= 0x41E,//1054

burnMsgAfterReadGroupChat= 0x458,//1112

burnMsgAfterReadGroupChatConfirm= 0x41F,//1055

forwardChat= 0x460,//112

reCallMessage= 0x41A,//105

reCallMessageConfirm= 0x41B,//1051

reCallMessageNotify=0x41C,//1052

messageReadedReceipt=0x452,//1106

messageReadedNotify=0x41D,//1053

messageBodyUpdate=0x424,//106

messageBodyUpdateConfirm=0x425//1061

/***************会话相关******************/

/***************音视频相关******************/
avChatLaunch=0x1774,//6004

avChatHandle=0x177,//600

avChatNoResponse=0x1772,//6002

/***************自定义表情相关***************/
accountUpdEmojis=0x408,//1032

accountDelEmojis=0x407,//1031

accountAddEmojis=0x406,//103

/***************在线客服用户端相关***************/
cscLogin=0x1F72,//805

cscLogout=0x1F73,//8051

cscSAllotServicerNotify=0x2008,//820

cscStopConversationNotify=0x2009,//8201

cscConversationChangeNotify=0x200A,//8202，应用场景：更新置顶、免打扰时，用户端多端同步

/***************在线客服消息（客服端、用户端共用）***************/
cscSendMsg=0x1F40,//800

cscMsgToOnline=0x1F48,//8008

cscMsgToOnlineConfirm=0x1F49,//8009

cscSetMsgReaded=0x1FAA,//8106

cscMsgReadedNotify=0x1F75,//8053

cscMsgConfirm=0x1F6E,//8046

cscSetMsgReadedConfirm=0x1FAB,//8107

initSDK=0x2328,//900

httpGetVerifyCode=0x2329,//9001

httpLoginByVerifyCode=0x232A,//9002

httpGetConversationList=0x232B,//9003

httpGetAll=0x232C,//9004

httpGetFriendList=0x232D,//9005

httpGetGroupList=0x232E //9006

}
* */
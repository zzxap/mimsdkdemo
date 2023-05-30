/* Code generated by cmd/cgo; DO NOT EDIT. */

/* package mimsdk */


#line 1 "cgo-builtin-export-prolog"

#include <stddef.h>

#ifndef GO_CGO_EXPORT_PROLOGUE_H
#define GO_CGO_EXPORT_PROLOGUE_H

#ifndef GO_CGO_GOSTRING_TYPEDEF
typedef struct { const char *p; ptrdiff_t n; } _GoString_;
#endif

#endif

/* Start of preamble from import "C" comments.  */


#line 3 "main.go"



#include <stdio.h>
#include <string.h>
#include <stdlib.h>
typedef void (*OpenFunc)(char*,int);


#line 1 "cgo-generated-wrapper"


/* End of preamble from import "C" comments.  */


/* Start of boilerplate cgo prologue.  */
#line 1 "cgo-gcc-export-header-prolog"

#ifndef GO_CGO_PROLOGUE_H
#define GO_CGO_PROLOGUE_H

typedef signed char GoInt8;
typedef unsigned char GoUint8;
typedef short GoInt16;
typedef unsigned short GoUint16;
typedef int GoInt32;
typedef unsigned int GoUint32;
typedef long long GoInt64;
typedef unsigned long long GoUint64;
typedef GoInt64 GoInt;
typedef GoUint64 GoUint;
typedef size_t GoUintptr;
typedef float GoFloat32;
typedef double GoFloat64;
#ifdef _MSC_VER
#include <complex.h>
typedef _Fcomplex GoComplex64;
typedef _Dcomplex GoComplex128;
#else
typedef float _Complex GoComplex64;
typedef double _Complex GoComplex128;
#endif

/*
  static assertion to make sure the file is being used on architecture
  at least with matching size of GoInt.
*/
typedef char _check_for_64_bit_pointer_matching_GoInt[sizeof(void*)==64/8 ? 1:-1];

#ifndef GO_CGO_GOSTRING_TYPEDEF
typedef _GoString_ GoString;
#endif
typedef void *GoMap;
typedef void *GoChan;
typedef struct { void *t; void *v; } GoInterface;
typedef struct { void *data; GoInt len; GoInt cap; } GoSlice;

#endif

/* End of boilerplate cgo prologue.  */

#ifdef __cplusplus
extern "C" {
#endif

extern void initcb(OpenFunc mopenfunc);
extern void goCallback(char* s, int i);

// 注册回调函数
//
extern void callbackTriger(void* cb);
extern void testcb();
extern void call_later_go_cb(void* data);
extern void InitializeDartApi(void* api);
extern void InitSDKWithFFI(GoInt64 appId, char* sdkConfig, GoInt64 port, char* mode);
extern void InitSDK(GoInt64 appId, char* sdkConfig, char* mode);
extern void DisconnectServer();
extern void ReConnectServer();
extern void GetVerifyCode(char* mobile);
extern char* LoginByVerifyCode(char* mobile, char* VerificationCode);
extern void SendMessage(GoInt messageType, char* fromId, char* toId, char* message);
extern void SendGroupMessage(GoInt messageType, char* groupId, char* fromId, char* message);
extern char* SendAnySingleMessage(GoUint16 cmd, GoInt messageType, char* fromId, char* toId, char* MessageContent);
extern char* SendAnyGroupleMessage(GoUint16 cmd, GoInt messageType, char* fromId, char* toId, char* MessageContent);
extern char* GetConversationList();
extern char* GetMsgList(char* fromId, char* toId, GoInt64 lastMsgSyncId);
extern char* GetGroupMsgList(char* fromId, char* groupId, GoInt64 lastMsgSyncId);

// 添加好友
//
extern char* AddFriend(char* fromId, char* toId, char* message);

// 审批好友请求approvStatus  0 忽略 1 同意添加单向好友 2 同意并添加为双向好友 3 拒绝 4 删除
//
extern char* ApprovFriendApply(char* fromId, char* friendId, GoInt approvStatus);
extern char* DeleteFriend(char* fromId, char* toIds);
extern char* GetFriendList();

// 群组类型：1:Public（公开群），2:Private（私有群），3:Meeting（临时会议群），4:AVChatRoom（直播群）（必填）
//
extern char* CreateGroup(GoInt groupType, char* groupName, char* groupMemberList);
extern char* InviteUserJoinGroup(char* groupId, char* toIds);
extern char* GetGroupList();

// 获取客服历史消息 MsgLastSequence是最后一条消息的msgSequence 开始传-1
//
extern char* GetCustomerMsgList(char* fromId, char* toId, GoInt MsgLastSequence);
extern void StartWork(GoInt64 port);
extern void TestStartWork(GoInt64 port);
extern void RevokeMessage(char* msgId, char* fromId, char* toId, GoInt64 itemType, GoInt64 msgSequence, GoInt64 msgTime);
extern char* Start();

#ifdef __cplusplus
}
#endif

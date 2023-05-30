import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:path/path.dart' as path;
import 'package:ffi/ffi.dart';
import 'package:flutter/services.dart';
import 'dart:io' show Directory, File, Platform;
import 'mimsdk.dart';
//import 'package:path/path.dart' as path;
import 'dart:convert';
//import 'package:device_info/device_info.dart';
import 'dart:isolate';
//import 'package:path_provider/path_provider.dart';
import 'dart:ffi' as ffi;
//import 'package:awesome_dialog/awesome_dialog.dart';
import 'DeviceInfo.dart';
import 'dart:io' show Platform;
import 'messageType.dart';
import 'cmdType.dart';
import 'package:path_provider/path_provider.dart';
void debugPrint(dynamic str) {
  print("[Dart]: ${str.toString()}");
}

class DataModel extends ffi.Struct {
  @ffi.Int64()
  external int code;
  @ffi.Int64()
  external int cmd;
  external ffi.Pointer<Utf8> data;
  external ffi.Pointer<Utf8> error;
  external ffi.Pointer<Utf8> funcName;
}
String _mobile="";
String _verifycode="";



Future<String> getUniqueId() async {
   if (deviceInfo["deviceId"]!=null){
     final original =deviceInfo["deviceId"].toString();
     final find = '-';
     final replaceWith = '';
     var  newString = original.replaceAll(find, replaceWith);
     newString = newString.replaceAll("{", replaceWith);
     newString = newString.replaceAll("}", replaceWith);
     return newString;
   }
   return "f_a_asdfasfdsf".toString();
}



String getOSName(){
  if ( Platform.isIOS) {
    return "iOS";
  }
  if (Platform.isMacOS ) {
    return "MacOS";
  }
  if (Platform.isAndroid ) {
    return "Android";
  }
  if ( Platform.isLinux) {
    return "Linux";
  }
  if (Platform.isWindows) {
    return "Windows";
  }
  return "unknow";
}

const String _libName = 'MIMSDK_iOS';
/// The dynamic library in which the symbols for [MimsdkFfipluginBindings] can be found.
final DynamicLibrary _dylib = () {
  if ( Platform.isMacOS) {
    var libraryPath = path.join(Directory.current.path,   'lib$_libName.a');
   // var libraryPath = path.join(Directory.current.path,  'lib', '$_libName.framework/$_libName');
    print(libraryPath);
    return DynamicLibrary.open('lib$_libName.a');
    //return  DynamicLibrary.process();//DynamicLibrary.open('$_libName.framework/$_libName');
    //return DynamicLibrary.open(libraryPath);
  }

  if (Platform.isIOS ) {
    //return DynamicLibrary.open('$_libName.framework/$_libName');
    return  DynamicLibrary.process();//DynamicLibrary.open('$_libName.framework/$_libName');
    //return DynamicLibrary.open('lib$_libName.a');
  }

  if (Platform.isAndroid || Platform.isLinux) {
    //将Android版的so文件放在android/app/src/main/jniLibs 里会自动加载
    return DynamicLibrary.open('lib$_libName.so');
  }
  if (Platform.isWindows) {
    var libraryPath = path.join(Directory.current.path,  'lib', 'lib$_libName.so');
    print(libraryPath);
    return DynamicLibrary.open(libraryPath);
    //return DynamicLibrary.open('$_libName.dll');
  }
  throw UnsupportedError('Unknown platform: ${Platform.operatingSystem}');
}();

/// The bindings to the native functions in [_dylib].
var dylib = NativeLibrary(_dylib);


final interactiveCppRequests = ReceivePort()
  ..listen((data) {
    print('Received: ${data} from Go');
    final model = ffi.Pointer<DataModel>.fromAddress(data as int);
    print('code=');
    print(model.ref.code);
    print('cmd = ');
    print(model.ref.cmd);
    //base64解码
    List<int> bytes = base64Decode(model.ref.data.toDartString());
    String datadecodedString = utf8.decode(bytes);
    print("data="+datadecodedString);
    List<int> byteserr = base64Decode(model.ref.error.toDartString());
    String errordecodedStringe = utf8.decode(byteserr);
    print("err="+errordecodedStringe);
    print('funcname= '+model.ref.funcName.toDartString());

    ReceiveData(model.ref.code,model.ref.cmd,datadecodedString,errordecodedStringe,model.ref.funcName.toDartString());

  });
//接收数据
void ReceiveData(int code,int cmd,String data,String errstr,String funcname) {
  var type = cmdType.fromValue(cmd); // 获取enum值
  switch (type) {
    case  cmdType.ping :
      print(' cmdType.ping');
      break;

    case  cmdType.ping :
      print(' cmdType.ping');
      break;

    default:
      print('Invalid day');
  }

  switch (funcname) {
    case 'GetFriendList':
      print('GetFriendList');
      break;
    case 'AddFriend':
      print('AddFriend');
      break;
    case 'ApprovFriendApply':
      print('ApprovFriendApply');
      break;
    case 'DeleteFriend':
      print('DeleteFriend');
      break;
    case 'CreateGroup':
      print('CreateGroup');
      break;
    case 'InviteUserJoinGroup':
      print('InviteUserJoinGroup');
      break;
    case 'GetGroupList':
      print('GetGroupList');
      break;
    default:
      print('Invalid day');
  }

}

Future<File> _localFile(String filename) async {
  final path = await getApplicationDocumentsDirectory();
  return File('${path.path}/$filename');
}

Future<File> copyFileToDocuments(String filename) async {
  final file = await _localFile(filename);
  final data = await rootBundle.load('lib/$filename');
  return file.writeAsBytes(data.buffer.asUint8List());
}

Future<void> initSdk() async {
  await initPlatformState();
  final appDocDir = await getApplicationDocumentsDirectory();
  final appDocPath = appDocDir.path; //数据的存储目录;
  //copyFileToDocuments("libMIMSDK.a");
  dylib = NativeLibrary(_dylib);

  //final lib = DynamicLibrary.open("F:\\flutter\\mimsdkFlutter\\build\\app\\intermediates\\merged_native_libs\\debug\\out\\lib\\x86_64\\godart.so");
 // final lib = DynamicLibrary.open("F:\\flutter\\mimsdkFlutter\\build\\app\\intermediates\\merged_native_libs\\debug\\out\\lib\\arm64-v8a\\godart.so");
  dylib.InitializeDartApi(ffi.NativeApi.initializeApiDLData)  ;

  var imei=await getUniqueId();
  var config = {
    "sdk_config_DeviceName": getOSName(),
    "sdk_config_DeviceType": getOSName(),
    "sdk_config_DeviceOs": getOSName(),
    "sdk_config_ClientVersion": "1.0",
    "sdk_config_imei": imei,
    "sdk_config_file_dir": appDocPath
  };

  final int nativePort = interactiveCppRequests.sendPort.nativePort;
  print("nativePort=");
  print(nativePort);

  final appId =10000;
  var jsonString = jsonEncode(config);
  final sdkConfig = jsonString.toNativeUtf8().cast<ffi.Char>() ; //jsonString.toNativeUtf8();
  var mode="release"; //开发环境用debug（仅限公司内部调试用） 生产环境用release

  dylib.InitSDKWithFFI(appId, sdkConfig, nativePort,mode.toNativeUtf8().cast<ffi.Char>());

}
void startmodel(){
  final int nativePort = interactiveCppRequests.sendPort.nativePort;
  dylib.StartWork(nativePort);
}
void  getVerify(String mobile){
  dylib.GetVerifyCode(mobile.toNativeUtf8().cast<ffi.Char>());
}
void  loginByPhone(String mobile,String code){
  if(mobile.length==0||code.length==0){
    print("please input mobile and code");
    return;
  }
  dylib.LoginByVerifyCode(mobile.toNativeUtf8().cast<ffi.Char>(),code.toNativeUtf8().cast<ffi.Char>());
}
void showdialog(BuildContext  context,String message ){
  print(message);
 /* AwesomeDialog(
    context: context,
    dialogType: DialogType.infoReverse,
    headerAnimationLoop: true,
    animType: AnimType.bottomSlide,
    title: '',
    reverseBtnOrder: true,
    btnOkOnPress: () {},
    btnCancelOnPress: () {},
    desc: message,
  ).show();

  */
}
class MyApp extends StatelessWidget {
  const MyApp({super.key});
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Flutter IMSDK Demo'),
    );
  }
}
class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});
  final String title;
  @override
  State<MyHomePage> createState() => _MyHomePageState();
}
class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;
  TextEditingController phoneController = TextEditingController(text: '13699881033');
  TextEditingController codeController = TextEditingController();
  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text(widget.title),
      ),
      body: Center(
        // Center is a layout widget. It takes a single child and positions it
        // in the middle of the parent.
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            TextFormField(
              decoration: InputDecoration(labelText: '手机号'),
              controller: phoneController,
            ),
            TextFormField(
              decoration: InputDecoration(labelText: '验证码'),
              controller: codeController,
            ),
            TextButton(
                  style: ButtonStyle(
                    foregroundColor: MaterialStateProperty.all<Color>(Colors.blue),
                  ),
                  onPressed: () {
                   initSdk();
                  },
                  child: Text('初始化', style: TextStyle( fontSize: 20)),
                ),

           TextButton(
                  style: ButtonStyle(

                    foregroundColor: MaterialStateProperty.all<Color>(Colors.blue),
                  ),
                  onPressed: () {
                    String phone = phoneController.text;
                    if (phone.length<10){
                      showdialog(context, "请输入手机号");
                      return;
                    }
                    getVerify(phone);
                  },
                  child: Text('获取验证码', style: TextStyle( fontSize: 20)),
            ),  TextButton(
                  style: ButtonStyle(
                    foregroundColor: MaterialStateProperty.all<Color>(Colors.blue),
                  ),
                  onPressed: () {
                    String phone = phoneController.text;
                    String code = codeController.text;
                    if (phone.length<10){
                      showdialog(context, "请输入手机号");
                      return;
                    }
                    if (code.length<4){
                      showdialog(context, "请输入验证码");
                      return;
                    }
                    loginByPhone(phone,code);
                  },
                  child: Text('登录', style: TextStyle( fontSize: 20)),
            ), TextButton(
                  style: ButtonStyle(
                    foregroundColor: MaterialStateProperty.all<Color>(Colors.blue),
                  ),
                  onPressed: () {
                   dylib.Start();
                  },
                  child: Text('连接IM服务', style: TextStyle( fontSize: 20)),

            ),TextButton(
              style: ButtonStyle(
                foregroundColor: MaterialStateProperty.all<Color>(Colors.blue),
              ),
              onPressed: () {
                dylib.SendMessage(MessageType.TEXT.index+1, "1120108".toNativeUtf8().cast<ffi.Char>(), "1120163".toNativeUtf8().cast<ffi.Char>(), "hi".toNativeUtf8().cast<ffi.Char>());
                },
              child: Text('发消息', style: TextStyle( fontSize: 20)),
            ),
            TextButton(
              style: ButtonStyle(foregroundColor: MaterialStateProperty.all<Color>(Colors.blue),),
              onPressed: () {
                dylib.GetConversationList();
              },
              child: Text('获取会话列表', style: TextStyle( fontSize: 20)),
            ),
            TextButton(
              style: ButtonStyle(foregroundColor: MaterialStateProperty.all<Color>(Colors.blue),),
              onPressed: () {
                dylib.GetFriendList();
              },
              child: Text('获取好友列表', style: TextStyle( fontSize: 20)),
            ),
            TextButton(
              style: ButtonStyle(foregroundColor: MaterialStateProperty.all<Color>(Colors.blue),),
              onPressed: () {
                dylib.GetGroupList();
              },
              child: Text('获取群列表', style: TextStyle( fontSize: 20)),
            ),
          ],
        ),
      ),
    // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}

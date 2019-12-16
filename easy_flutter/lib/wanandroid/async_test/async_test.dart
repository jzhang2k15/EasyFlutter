import 'dart:isolate';

class AsyncTest {
// 新的 isolate 端口
// 该端口将在未来使用
// 用来给 isolate 发送消息
//
  SendPort newIsolateSendPort;

//
// 新 Isolate 实例
//
  Isolate newIsolate;

//
// 启动一个新的 isolate
// 然后开始第一次握手
//
//
  void callerCreateIsolate() async {
    //
    // 本地临时 ReceivePort
    // 用于检索新的 isolate 的 SendPort
    //
    ReceivePort receivePort = ReceivePort();

    //
    // 初始化新的 isolate
    //
    newIsolate = await Isolate.spawn(
      callbackFunction,
      receivePort.sendPort,
    );

    //
    // 检索要用于进一步通信的端口
    //
    //
    newIsolateSendPort = await receivePort.first;
  }

//
// 新 isolate 的入口
//
  static void callbackFunction(SendPort callerSendPort){
    //
    // 一个 SendPort 实例，用来接收来自调用者的消息
    //
    //
    ReceivePort newIsolateReceivePort = ReceivePort();

    //
    // 向调用者提供此 isolate 的 SendPort 引用
    //
    callerSendPort.send(newIsolateReceivePort.sendPort);

    //
    // 进一步流程
    //
  }
}

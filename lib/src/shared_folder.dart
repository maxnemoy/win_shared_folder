import 'dart:ffi';
import 'dart:io' show Platform, Directory;
import 'package:ffi/ffi.dart';
import 'package:path/path.dart' as path;

typedef ExternalFuncInt = Int32 Function(Int32, Int32);
typedef InternalFuncInt = int Function(int, int);

typedef ExternalFuncString = Pointer<Utf8> Function(Pointer<Utf8>, Pointer<Utf8>);
typedef InternalFuncString = Pointer<Utf8> Function(Pointer<Utf8>, Pointer<Utf8>);

class SharedFolder {
  final DynamicLibrary lib;

  SharedFolder()
      : lib = DynamicLibrary.open(
            ".\\data\\flutter_assets\\packages\\win_shared_folder\\lib.dll");

  int callExternalInt(int a, int b) {
    Pointer<NativeFunction<ExternalFuncInt>> external = lib.lookup<NativeFunction<ExternalFuncInt>>('numbers');
    InternalFuncInt add = external.asFunction<InternalFuncInt>();
    return add(a, b);
  }

  String callExternalString(String a, String b) {
    Pointer<NativeFunction<ExternalFuncString>> external = lib.lookup<NativeFunction<ExternalFuncString>>('strings');
    InternalFuncString add = external.asFunction<InternalFuncString>();
    return add(a.toNativeUtf8(), b.toNativeUtf8()).toDartString();
  }
}

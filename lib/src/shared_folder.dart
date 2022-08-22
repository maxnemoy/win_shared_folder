import 'dart:ffi';
import 'package:ffi/ffi.dart';

typedef ExternalFuncInt = Int32 Function(Int32, Int32);
typedef InternalFuncInt = int Function(int, int);

typedef ExternalFuncString = Pointer<Utf8> Function(
    Pointer<Utf8>, Pointer<Utf8>);
typedef InternalFuncString = Pointer<Utf8> Function(
    Pointer<Utf8>, Pointer<Utf8>);

typedef ExternalFuncSetPath = Void Function(Pointer<Utf8>);
typedef InternalFuncSetPath = void Function(Pointer<Utf8>);

typedef ExternalFuncSetUser = Void Function(Pointer<Utf8>, Pointer<Utf8>);
typedef InternalFuncSetUser = void Function(Pointer<Utf8>, Pointer<Utf8>);

typedef ExternalFuncGetFolder = Pointer<Utf8> Function(Pointer<Utf8>);
typedef InternalFuncGetFolders = Pointer<Utf8> Function(Pointer<Utf8>);

typedef ExternalFuncShowConfig = Void Function();
typedef InternalFuncShowConfig = void Function();

class SharedFolder {
  final DynamicLibrary lib;

  SharedFolder()
      : lib = DynamicLibrary.open(
            ".\\data\\flutter_assets\\packages\\win_shared_folder\\lib.dll");

  void setPath(String path) {
    Pointer<NativeFunction<ExternalFuncSetPath>> external =
        lib.lookup<NativeFunction<ExternalFuncSetPath>>('setPath');
    InternalFuncSetPath setPath = external.asFunction<InternalFuncSetPath>();
    setPath(path.toNativeUtf8());
  }

  void setUser(String username, String password) {
    Pointer<NativeFunction<ExternalFuncSetUser>> external =
        lib.lookup<NativeFunction<ExternalFuncSetUser>>('setUser');
    InternalFuncSetUser setUser = external.asFunction<InternalFuncSetUser>();
    setUser(username.toNativeUtf8(), password.toNativeUtf8());
  }

  void showConfig() {
    Pointer<NativeFunction<ExternalFuncShowConfig>> external =
        lib.lookup<NativeFunction<ExternalFuncShowConfig>>('showConfig');
    InternalFuncShowConfig showConfig = external.asFunction<InternalFuncShowConfig>();
    showConfig();
  }

  List<String> getFolders(String path) {
    Pointer<NativeFunction<ExternalFuncGetFolder>> external =
        lib.lookup<NativeFunction<ExternalFuncGetFolder>>('getFolders');
    InternalFuncGetFolders getFolders =
        external.asFunction<InternalFuncGetFolders>();
    return getFolders(path.toNativeUtf8()).toDartString().split("::");
  }

  int callExternalInt(int a, int b) {
    Pointer<NativeFunction<ExternalFuncInt>> external =
        lib.lookup<NativeFunction<ExternalFuncInt>>('numbers');
    InternalFuncInt add = external.asFunction<InternalFuncInt>();
    return add(a, b);
  }

  String callExternalString(String a, String b) {
    Pointer<NativeFunction<ExternalFuncString>> external =
        lib.lookup<NativeFunction<ExternalFuncString>>('strings');
    InternalFuncString add = external.asFunction<InternalFuncString>();
    return add(a.toNativeUtf8(), b.toNativeUtf8()).toDartString();
  }
}

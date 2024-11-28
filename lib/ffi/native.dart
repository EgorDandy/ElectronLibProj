import 'dart:ffi';
import 'dart:io';

import 'package:ffi/ffi.dart'; 

typedef CompareStringsC = Bool Function(Pointer<Utf8>, Pointer<Utf8>); 
typedef CompareStringsDart = bool Function(Pointer<Utf8>, Pointer<Utf8>);

final DynamicLibrary dylib = Platform.isAndroid
    ? DynamicLibrary.open('libnative.so')
    : DynamicLibrary.process();

final compareStrings = dylib
    .lookup<NativeFunction<Bool Function(Pointer<Utf8>, Pointer<Utf8>)>>("compareStrings")
    .asFunction<bool Function(Pointer<Utf8>, Pointer<Utf8>)>();
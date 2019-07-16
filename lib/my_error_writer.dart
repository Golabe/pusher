import 'dart:async';
import 'dart:io';


import 'package:jaguar/http/context/context.dart';
import 'package:jaguar/http/response/response.dart';
import 'package:jaguar/serve/error_writer/error_writer.dart';

class MyErrorWrite extends ErrorWriter {
  @override
  FutureOr<Response> make404(Context ctx) {
    //找不到页面时返回
    final resp =
    Response('''<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Title</title>
</head>
<body>
404
</body>
</html>''', statusCode: HttpStatus.notFound);
    resp.headers.contentType = ContentType.html;
    return ctx.response = resp;
  }

  @override
  FutureOr<Response> make500(Context ctx, Object error, [StackTrace stack]) {
    final resp =
    Response('''<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Title</title>
</head>
<body>
500
</body>
</html>''', statusCode: HttpStatus.internalServerError);
    resp.headers.contentType = ContentType.html;
   return  ctx.response = resp;
  }

}
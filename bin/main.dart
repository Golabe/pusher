import 'package:jaguar/jaguar.dart';
import 'package:pusher/my_error_writer.dart';

main() => Jaguar(
  errorWriter: MyErrorWrite()

)
  ..getJson('api/user', (ctx) {
    throw Exception("发生错误");
  })
  ..getJson('api/user', (ctx) {

  })
  ..staticFile('/', 'static/index.html')
  ..staticFile('/static/*', 'static')
  ..log.onRecord.listen(print)
  ..serve(logRequests: true);

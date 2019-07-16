import 'dart:io';

import 'package:jaguar/jaguar.dart';
import 'package:pusher/model/user.dart';
import 'package:pusher/my_error_writer.dart';
import 'package:jaguar_query_postgres/jaguar_query_postgres.dart';

final PgAdapter _adapter =
    PgAdapter('pusher', username: 'postgres', password: 'root');

main() {
  Jaguar(errorWriter: MyErrorWrite())

    ..post('api/user/new', (ctx) async {
      //连接数据库
      await _adapter.connect();
// 实例化UserBean对象
      UserBean userBean = new UserBean(_adapter);
//创建表
//      await userBean.createTable();
//插入一条数据
      User newUser = new User();
      newUser.username = 'rhyme';
      newUser.password = '123456';
      newUser.avatar = 'http:/localhost:8080/static/admin.png';
      newUser.email = 'rhymelph#gmail.com'; //这里不能使用@，会自动变为格式化字符串
      newUser.role = '0';
      newUser.phoneNumber = '15758188600';
      await userBean.insert(newUser);
//查询一条数据
      ctx.response = Response('success');
    })
    ..get('api/user', (ctx)  async{
      await _adapter.connect();
// 实例化UserBean对象
      UserBean userBean = new UserBean(_adapter);
//创建表
      User selectOne = await userBean.find('1');

      ctx.response=Response('user info {usrname:${selectOne.username}');
    })
    ..postJson('api/user', (ctx) async {
//      User user = await ctx.bodyAsJson(convert: User.forMap);
//      ctx.response =
//          Response('user{username :${user.username} ,pwd:${user.pwd}');
    })
//    ..postJson('api/user', (ctx) async {
////      List<User> users = await ctx.bodyAsJsonList(convert: User.forMap);
////      String result = '';
////      for (User user in users) {
////        result += 'username:${user.username},pwd:${user.pwd}';
////      }
////      ctx.response = Response(result);
//    })
    ..postJson('api/user/avatar', (ctx) async {
      Stream<List<int>> image = await ctx.bodyAsStream;
      int time = DateTime.now().millisecondsSinceEpoch;
      File file = await File("${time}.png").create();
      await image.listen(file.writeAsBytes);
      ctx.response = Response('success');
    })
    ..get('api/user/:id', (ctx) {
      ctx.response = Response(ctx.pathParams['id']);
    })
    ..get('/api/UserInfo', (ctx) async {
      //连接数据库
      await _adapter.connect();
// 实例化UserBean对象
      UserBean userBean = new UserBean(_adapter);
//创建表
      await userBean.createTable();
//插入一条数据
      User newUser = new User();
      newUser.id = '1';
      newUser.username = 'rhyme';
      newUser.password = '123456';
      newUser.avatar = 'http:/localhost:8080/static/admin.png';
      newUser.email = 'rhymelph#gmail.com'; //这里不能使用@，会自动变为格式化字符串
      newUser.role = '0';
      newUser.phoneNumber = '15758188600';
      await userBean.insert(newUser);
//查询一条数据
      User selectOne = await userBean.find('1');
//返回查询的数据到页面
      return Response(selectOne.toString());
    })
    ..staticFile('/', 'static/index.html')
    ..staticFile('/static/*', 'static')
    ..log.onRecord.listen(print)
    ..serve(logRequests: true);
}

import 'dart:convert';
import 'package:shelf/shelf.dart';
import '../../RespnseMsg/CustomResponse.dart';
import '../../Services/Supabase/supabaseEnv.dart';

loginResponse(Request req) async {
  try {
    final Map body = jsonDecode(await req.readAsString());
    if (body["email"] == null || body["password"] == null) {
      return ResponseMsg().errorResponse(
        msg: "Enter your email and password",
      );
    }
    final userLogin = await SupabaseEnv()
        .supabase
        .auth
        .signInWithPassword(email: body["email"], password: body["password"]);
        print("AccessToken:${userLogin.session?.accessToken.toString()}");
        print("RefreshToken:${userLogin.session?.refreshToken.toString()}");

    return ResponseMsg().successResponse(
      msg: "Log in",
      data: {"Token": userLogin.session!.accessToken.toString()},
    );
  } catch (error) {
    print(error);

    return ResponseMsg().errorResponse(msg: "Error log in");
  }
}
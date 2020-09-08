// import 'dart:convert';
// import 'dart:io';
// import 'package:async/async.dart';

// import 'package:http/http.dart' as http;
// import 'package:SalesTrendz/model/ResponseModel.dart';
// class ApiCalls{
//   static Future<ResponseModel> getHttpResponse(String _url, String _body)async{
//     bool mIsError = false;
//     String mErrorMsg = "";
//     ResponseModel _responseModel = new ResponseModel();
//     try{
//       Map<String,String> headers = {
//         'Content-type' : 'application/json', 
//         'Accept': 'application/json',
//       };
//       final response = await http.post(_url, body: _body, headers: headers);
//       if(response == null){
//         mIsError = false;
//         mErrorMsg = "Received null response from server."+response.statusCode.toString();
//       }else{
//         switch(response.statusCode){
//           case 200:
//             try{
//               mIsError = true;
//               mErrorMsg = "success";
//               String parsedJson = json.decode(response.body);
//               _responseModel = ResponseModel.fromJson(jsonDecode(parsedJson));
//               // return _responseModel;
//             } on FormatException catch(e){
//               print(e);
//               mIsError = false;
//               mErrorMsg = "Received wrong body contents."+response.statusCode.toString();
//             }
//             break;
//           case 400:
//             print(response.statusCode);
//             break;
//           case 401:
//             print(response.statusCode);
//             break;
//           default:
//             print(response.statusCode);
//             mIsError = false;
//             mErrorMsg = "Invalid server response: " + response.statusCode.toString();
//             break;
//         }
//       }
//     }on SocketException catch(e){
//       mIsError = false;
//       mErrorMsg = "Failed to connect to server. " + e.message;
//     } on Exception catch(e){
//       mIsError = false;
//       mErrorMsg = "Unknown error $e.";
//     }
//     if((!mIsError) || (_responseModel == null)){
//       _responseModel.setIsCorrect(mIsError);
//       _responseModel.setMessage(mErrorMsg);
//       // _responseModel.setData(new Data());
//       return _responseModel;
//     }
//     _responseModel.setIsCorrect(mIsError);
//     _responseModel.setMessage(mErrorMsg);
//     return _responseModel;
//   }


//   static Future<ResponseModel> getLogin(String userName, String password)async{
//     String _url = "http://www.testit.online/gfprs/api/fp/auth";
//     String _body = jsonEncode({"UserName":userName,"PassWord":password});
//     return await getHttpResponse(_url, _body);
//   }
// }
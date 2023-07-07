enum TokenRole { publisher, subscriber }

enum MediaAction {
  getResourceID = "rid",
  startRecording= "start",
  stopRecording= "stop",
  getRTCToken= "rtc",
  process= "process",
}

enum TokenType { uid, userAccount }

// Future<String?> generateRTCToken({
//     required String channelName,
//     required TokenRole role,
//     required TokenType type,
//     required int uid,
//     required Function(String e) onError,
//   }) async {
//     // Get URL parameters
//     Map<String, String> env = dotenv.env;

//     // URL endpoint
//     Map<String, String> body = {
//       "uid": uid.toString(),
//       "appId": env["AGORA_APP_ID"]!,
//       "appCertificate": env["AGORA_CERT"]!,
//       "role": unpackTokenRole(role),
//       "tokenType": unpackTokenType(type),
//       "channelName": channelName,
//     };

//     //Make Request
//     var json = await _fetch(
//       MediaAction.getRTCToken,
//       body,
//       onError,
//     );

//     if (json == null) return null;

//     if (json["error"] != null) {
//       Map? res = await _implementHandleNetworkJitter(
//         body,
//         MediaAction.getRTCToken,
//         json,
//         onError,
//       );

//       if (res == null) return null;

//       return json["payload"]["token"];
//     }

//     return json["payload"]["token"];
//   }

// String _genCredentials(Map<String, String> env) => _encodeBase64(
//     "${env["MEDIA_KEY"]}:${env["MEDIA_SECRET"]}",
//   );




//   Future<Map?> _fetch(MediaAction action, Map<String, dynamic> body,
//       Function(String e) onError) async {
//     http.Response? response;

//     // Get URL parameters
//     Map<String, String> env = dotenv.env;

//     String target = actionMap[action]!;

//     String endpoint =
//         "${env["MEDIA_ENDPOINT"]!}/$target?key=${_genCredentials(env)}";

//     try {
//       response =
//           await http.post(Uri.parse(endpoint), body: conv.json.encode(body));
//     } catch (e) {
//       onError(e.toString());
//     }

//     if (response == null) return null;

//     Map<String, dynamic> json = conv.jsonDecode(response.body);

//     if (response.statusCode != 200) {
//       var res = {
//         "status": response.statusCode,
//         "error": json,
//       };

//       onError(res.toString());

//       return res;
//     }

//     return {
//       "status": response.statusCode,
//       "error": null,
//       "payload": json,
//     };
//   }

interface RTCTokenProps {
    channelName: string,
    role: TokenRole,
    type: TokenType,
    uid: number,
}

export const generateRTCToken = (props: RTCTokenProps) => {

}

const fetch = async (action: MediaAction, body: Object) => {
    return;
}
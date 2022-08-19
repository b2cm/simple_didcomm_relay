import 'dart:io';

import 'package:shelf/shelf.dart';
import 'package:shelf/shelf_io.dart';
import 'package:shelf_router/shelf_router.dart';

// Configure routes.
final _router = Router()
  ..post('/buffer/<did>', _bufferHandler)
  ..get('/get/<did>', _getHandler);

final Map<String, List<String>> messages = {};

Future<Response> _bufferHandler(Request req, String did) async {
  List<String> list = messages[did] ?? [];
  list.add(await req.readAsString());
  messages[did] = list;
  return Response.ok('Successfully buffered message\n');
}

Response _getHandler(Request request, String did) {
  List<String>? messagesForDid = messages.remove(did);
  if (messagesForDid != null) {
    return Response.ok(messagesForDid.toString());
  } else {
    return Response.notFound('no messages found');
  }
}

void main(List<String> args) async {
  // Use any available host or container IP (usually `0.0.0.0`).
  final ip = InternetAddress.anyIPv4;

  // Configure a pipeline that logs requests.
  final handler = Pipeline().addMiddleware(logRequests()).addHandler(_router);

  // For running in containers, we respect the PORT environment variable.
  final port = int.parse(Platform.environment['PORT'] ?? '8888');
  final server = await serve(handler, ip, port);
  print('Server listening on port ${server.port}');
}

library streamy_proxy;

import "dart:async";
import "dart:html";
import "dart:json" as json;
import "base.dart";

/// A [RequestHandler] that proxies through a frontend server.
class ProxyClient extends RequestHandler {

  /// The base url of the proxy.
  final String proxyUrl;
  final StreamyHttpHandler httpHandler;

  ProxyClient(this.proxyUrl, {this.httpHandler: const DartHtmlHttpHandler()});

  Stream handle(Request req) {
    var url = "$proxyUrl/${req.root.servicePath}${req.path}";
    var payload = req.hasPayload ? json.stringify(req.payload) : null;
    httpHandler.request(url, req.httpMethod, payload).then((resp) {
      if (resp.statusCode != 200) {
        throw new ProxyException(httpReq.statusCode,
            "API call returned status: ${resp.statusText}");
      }
      return req.responseDeserializer(resp.body);
    }).asStream();
  }
}

class ProxyException implements Exception {

  final String message;
  final int code;

  ProxyException(this.message, this.code);

  String toString() => "$code: $message";
}

class StreamyHttpResponse {
  final int statusCode;
  final String statusText;
  final String body;

  StreamyHttpResponse(this.statusCode, this.statusText, this.body);
}

abstract class StreamyHttpHandler {

  Future<StreamyHttpResponse> request(String url, String method, [String payload = null]);
}

class DartHtmlHttpHandler implements StreamyHttpHandler {

  Future<StreamyHttpResponse> request(String url, String method, [String payload = null]) {
    var res;
    if (payload != null) {
      res = HttpRequest.request(url, method: method, sendData: payload);
    } else {
      res = HttpRequest.request(url, method: method);
    }
    return res.then((resp) {
      return new StreamyHttpResponse(resp.status, resp.statusText, resp.responseText);
    });
  }
}

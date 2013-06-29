/**
 * WARNING: This code was generated from templates in
 * folder templates. Do not edit by hand.
 */
library addendum;
import "dart:async";
import "dart:json";
import "package:streamy/base.dart" as base;
import "package:streamy/comparable.dart";
Map<String, base.TypeInfo> TYPE_REGISTRY = {
};

class Foo extends base.EntityWrapper {
  static final List<String> KNOWN_PROPERTIES = [
    "id",
    "bar",
  ];
  Foo() : super.wrap(new base.RawEntity(), (cloned) => new Foo._wrap(cloned));
  Foo._wrap(base.Entity entity) : super.wrap(entity, (cloned) => new Foo._wrap(cloned));
  Foo.wrap(base.Entity entity, base.EntityWrapperCloneFn cloneWrapper) :
      super.wrap(entity, (cloned) => cloneWrapper(cloned));
  int get id => this["id"];
  set id(int value) {
    this["id"] = value;
  }
  int removeId() => this.remove("id");
  String get bar => this["bar"];
  set bar(String value) {
    this["bar"] = value;
  }
  String removeBar() => this.remove("bar");
  factory Foo.fromJsonString(String strJson) => new Foo.fromJson(parse(strJson));
  factory Foo.fromJson(Map json) {
    if (json == null) {
      return null;
    }
    json = new Map.from(json);
    var result = new Foo()
      ..id = json.remove("id")
      ..bar = json.remove("bar")
;
    base.addUnknownProperties(result, json, TYPE_REGISTRY);
    return result;
  }
  Map toJson() {
    Map map = super.toJson();
;
    return map;
  }
  Foo clone() => new Foo._wrap(super.clone());
  Type get streamyType => Foo;
}

class FoosGetRequest extends base.Request {
  static final List<String> KNOWN_PARAMETERS = [
    "fooId",
  ];
  String get httpMethod => "GET";
  String get pathFormat => "foos/{fooId}";
  bool get hasPayload => false;
  FoosGetRequest(AddendumTest root) : super(root) {
  }
  List<String> get pathParameters => const ["fooId",];
  List<String> get queryParameters => const [];
  int get fooId => parameters["fooId"];
  set fooId(int value) {
    parameters["fooId"] = value;
  }
  int removeFooId() => parameters.remove("fooId");
  Stream<Foo> send(
   { 
      bool dedup: true
      ,
      int ttl: 800
      ,
      String foo: "Bar"
   } 
  ) {
      this.local["dedup"] = dedup;
      this.local["ttl"] = ttl;
      this.local["foo"] = foo;
    return this.root.send(this);
  }
  FoosGetRequest clone() => base.internalCloneFrom(new FoosGetRequest(root), this);
  base.Deserializer get responseDeserializer => (String str) => new Foo.fromJsonString(str);
}

class FoosResource {
  final AddendumTest _root;
  static final List<String> KNOWN_METHODS = [
    "get",
  ];
  FoosResource(this._root);
  FoosGetRequest get() {
    return new FoosGetRequest(_root);
  }
}

/// Entry point to all API services for the application.
class AddendumTest extends base.Root {
  FoosResource _foos;
  FoosResource get foos => _foos;
  final base.RequestHandler requestHandler;
  final String servicePath;
  AddendumTest(this.requestHandler, {this.servicePath: "addendum/v1/"}) {
    this._foos = new FoosResource(this);
  }
  Stream send(base.Request request) => requestHandler.handle(request);
}

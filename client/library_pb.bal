import ballerina/grpc;
import ballerina/protobuf;
import ballerina/protobuf.types.empty;
import ballerina/protobuf.types.wrappers;

public const string LIBRARY_DESC = "0A0D6C6962726172792E70726F746F12076C6962726172791A1B676F6F676C652F70726F746F6275662F656D7074792E70726F746F1A1E676F6F676C652F70726F746F6275662F77726170706572732E70726F746F22260A0B557365725265717565737412170A07757365725F6964180120012809520675736572496422280A0C55736572526573706F6E736512180A076D65737361676518012001280952076D657373616765229A010A04426F6F6B12120A046973626E18012001280952046973626E12190A08617574686F725F311802200128095207617574686F723112190A08617574686F725F321803200128095207617574686F7232121A0A086C6F636174696F6E18042001280952086C6F636174696F6E12140A057469746C6518052001280952057469746C6512160A067374617475731806200128095206737461747573221E0A08426F6F6B6973626E12120A046973626E18012001280952046973626E32F0020A0F4C6962726172795F73657276696365122F0A07616464426F6F6B120D2E6C6962726172792E426F6F6B1A152E6C6962726172792E55736572526573706F6E7365123B0A0C6372656174655F757365727312142E6C6962726172792E55736572526571756573741A152E6C6962726172792E55736572526573706F6E736512340A0C7570646174655F626F6F6B73120D2E6C6962726172792E426F6F6B1A152E6C6962726172792E55736572526573706F6E7365123C0A0B72656D6F76655F626F6F6B121C2E676F6F676C652E70726F746F6275662E537472696E6756616C75651A0D2E6C6962726172792E426F6F6B3001123F0A146C6973745F617661696C61626C655F626F6F6B7312162E676F6F676C652E70726F746F6275662E456D7074791A0D2E6C6962726172792E426F6F6B3001123A0A0B6C6F636174655F626F6F6B121C2E676F6F676C652E70726F746F6275662E537472696E6756616C75651A0D2E6C6962726172792E426F6F6B620670726F746F33";

public isolated client class Library_serviceClient {
    *grpc:AbstractClientEndpoint;

    private final grpc:Client grpcClient;

    public isolated function init(string url, *grpc:ClientConfiguration config) returns grpc:Error? {
        self.grpcClient = check new (url, config);
        check self.grpcClient.initStub(self, LIBRARY_DESC);
    }

    isolated remote function addBook(Book|ContextBook req) returns UserResponse|grpc:Error {
        map<string|string[]> headers = {};
        Book message;
        if req is ContextBook {
            message = req.content;
            headers = req.headers;
        } else {
            message = req;
        }
        var payload = check self.grpcClient->executeSimpleRPC("library.Library_service/addBook", message, headers);
        [anydata, map<string|string[]>] [result, _] = payload;
        return <UserResponse>result;
    }

    isolated remote function addBookContext(Book|ContextBook req) returns ContextUserResponse|grpc:Error {
        map<string|string[]> headers = {};
        Book message;
        if req is ContextBook {
            message = req.content;
            headers = req.headers;
        } else {
            message = req;
        }
        var payload = check self.grpcClient->executeSimpleRPC("library.Library_service/addBook", message, headers);
        [anydata, map<string|string[]>] [result, respHeaders] = payload;
        return {content: <UserResponse>result, headers: respHeaders};
    }

    isolated remote function create_users(UserRequest|ContextUserRequest req) returns UserResponse|grpc:Error {
        map<string|string[]> headers = {};
        UserRequest message;
        if req is ContextUserRequest {
            message = req.content;
            headers = req.headers;
        } else {
            message = req;
        }
        var payload = check self.grpcClient->executeSimpleRPC("library.Library_service/create_users", message, headers);
        [anydata, map<string|string[]>] [result, _] = payload;
        return <UserResponse>result;
    }

    isolated remote function create_usersContext(UserRequest|ContextUserRequest req) returns ContextUserResponse|grpc:Error {
        map<string|string[]> headers = {};
        UserRequest message;
        if req is ContextUserRequest {
            message = req.content;
            headers = req.headers;
        } else {
            message = req;
        }
        var payload = check self.grpcClient->executeSimpleRPC("library.Library_service/create_users", message, headers);
        [anydata, map<string|string[]>] [result, respHeaders] = payload;
        return {content: <UserResponse>result, headers: respHeaders};
    }

    isolated remote function update_books(Book|ContextBook req) returns UserResponse|grpc:Error {
        map<string|string[]> headers = {};
        Book message;
        if req is ContextBook {
            message = req.content;
            headers = req.headers;
        } else {
            message = req;
        }
        var payload = check self.grpcClient->executeSimpleRPC("library.Library_service/update_books", message, headers);
        [anydata, map<string|string[]>] [result, _] = payload;
        return <UserResponse>result;
    }

    isolated remote function update_booksContext(Book|ContextBook req) returns ContextUserResponse|grpc:Error {
        map<string|string[]> headers = {};
        Book message;
        if req is ContextBook {
            message = req.content;
            headers = req.headers;
        } else {
            message = req;
        }
        var payload = check self.grpcClient->executeSimpleRPC("library.Library_service/update_books", message, headers);
        [anydata, map<string|string[]>] [result, respHeaders] = payload;
        return {content: <UserResponse>result, headers: respHeaders};
    }

    isolated remote function locate_book(string|wrappers:ContextString req) returns Book|grpc:Error {
        map<string|string[]> headers = {};
        string message;
        if req is wrappers:ContextString {
            message = req.content;
            headers = req.headers;
        } else {
            message = req;
        }
        var payload = check self.grpcClient->executeSimpleRPC("library.Library_service/locate_book", message, headers);
        [anydata, map<string|string[]>] [result, _] = payload;
        return <Book>result;
    }

    isolated remote function locate_bookContext(string|wrappers:ContextString req) returns ContextBook|grpc:Error {
        map<string|string[]> headers = {};
        string message;
        if req is wrappers:ContextString {
            message = req.content;
            headers = req.headers;
        } else {
            message = req;
        }
        var payload = check self.grpcClient->executeSimpleRPC("library.Library_service/locate_book", message, headers);
        [anydata, map<string|string[]>] [result, respHeaders] = payload;
        return {content: <Book>result, headers: respHeaders};
    }

    isolated remote function remove_book(string|wrappers:ContextString req) returns stream<Book, grpc:Error?>|grpc:Error {
        map<string|string[]> headers = {};
        string message;
        if req is wrappers:ContextString {
            message = req.content;
            headers = req.headers;
        } else {
            message = req;
        }
        var payload = check self.grpcClient->executeServerStreaming("library.Library_service/remove_book", message, headers);
        [stream<anydata, grpc:Error?>, map<string|string[]>] [result, _] = payload;
        BookStream outputStream = new BookStream(result);
        return new stream<Book, grpc:Error?>(outputStream);
    }

    isolated remote function remove_bookContext(string|wrappers:ContextString req) returns ContextBookStream|grpc:Error {
        map<string|string[]> headers = {};
        string message;
        if req is wrappers:ContextString {
            message = req.content;
            headers = req.headers;
        } else {
            message = req;
        }
        var payload = check self.grpcClient->executeServerStreaming("library.Library_service/remove_book", message, headers);
        [stream<anydata, grpc:Error?>, map<string|string[]>] [result, respHeaders] = payload;
        BookStream outputStream = new BookStream(result);
        return {content: new stream<Book, grpc:Error?>(outputStream), headers: respHeaders};
    }

    isolated remote function list_available_books() returns stream<Book, grpc:Error?>|grpc:Error {
        empty:Empty message = {};
        map<string|string[]> headers = {};
        var payload = check self.grpcClient->executeServerStreaming("library.Library_service/list_available_books", message, headers);
        [stream<anydata, grpc:Error?>, map<string|string[]>] [result, _] = payload;
        BookStream outputStream = new BookStream(result);
        return new stream<Book, grpc:Error?>(outputStream);
    }

    isolated remote function list_available_booksContext() returns ContextBookStream|grpc:Error {
        empty:Empty message = {};
        map<string|string[]> headers = {};
        var payload = check self.grpcClient->executeServerStreaming("library.Library_service/list_available_books", message, headers);
        [stream<anydata, grpc:Error?>, map<string|string[]>] [result, respHeaders] = payload;
        BookStream outputStream = new BookStream(result);
        return {content: new stream<Book, grpc:Error?>(outputStream), headers: respHeaders};
    }
}

public class BookStream {
    private stream<anydata, grpc:Error?> anydataStream;

    public isolated function init(stream<anydata, grpc:Error?> anydataStream) {
        self.anydataStream = anydataStream;
    }

    public isolated function next() returns record {|Book value;|}|grpc:Error? {
        var streamValue = self.anydataStream.next();
        if (streamValue is ()) {
            return streamValue;
        } else if (streamValue is grpc:Error) {
            return streamValue;
        } else {
            record {|Book value;|} nextRecord = {value: <Book>streamValue.value};
            return nextRecord;
        }
    }

    public isolated function close() returns grpc:Error? {
        return self.anydataStream.close();
    }
}

public type ContextBookStream record {|
    stream<Book, error?> content;
    map<string|string[]> headers;
|};

public type ContextUserResponse record {|
    UserResponse content;
    map<string|string[]> headers;
|};

public type ContextBook record {|
    Book content;
    map<string|string[]> headers;
|};

public type ContextUserRequest record {|
    UserRequest content;
    map<string|string[]> headers;
|};

@protobuf:Descriptor {value: LIBRARY_DESC}
public type UserResponse record {|
    string message = "";
|};

@protobuf:Descriptor {value: LIBRARY_DESC}
public type Book record {|
    string isbn = "";
    string author_1 = "";
    string author_2 = "";
    string location = "";
    string title = "";
    string status = "";
|};

@protobuf:Descriptor {value: LIBRARY_DESC}
public type UserRequest record {|
    string user_id = "";
|};

@protobuf:Descriptor {value: LIBRARY_DESC}
public type Bookisbn record {|
    string isbn = "";
|};


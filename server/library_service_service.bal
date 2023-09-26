import ballerina/grpc;

listener grpc:Listener ep = new (9090);
table<Book>key(isbn) bookTable = table [];
table<UserRequest>key(user_id) userTable = table[];
@grpc:Descriptor {value: LIBRARY_DESC}
service "Library_service" on ep {

    remote function addBook(Book value) returns UserResponse|error {

        error? addNewBook = bookTable.add(value);
        if addNewBook is error {
            return addNewBook;
        } else {
            return {message: "Book successfully added"};
    }
    }
    remote function create_users(UserRequest value) returns UserResponse|error {
      error? createUser = userTable.add(value);
        if createUser is error {
            return createUser;
        } else {
            return {message: "the user was sucessfully created"};
    }
    }

    remote function update_books(Book value) returns UserResponse|error {
        error? addNewBook = bookTable.put(value);
        if addNewBook is error {
            return addNewBook;
        } else {
            return {message: "successfully updated"};
        }
    }

    remote function locate_book(string value) returns Book|error {
     Book getbook = bookTable.get(value);
        if (getbook.isbn === "") {

            return error("Book cannot be found");
        } else {
            return getbook;
    }
    }

    remote function remove_book(string value) returns stream<Book, error?>|error {
        stream<Book, error?> courseStream = stream from var book in bookTable.toArray()
            select book;
    Book deletedBook = bookTable.remove(value);
return   courseStream;
}

    remote function list_available_books() returns stream<Book, error?>|error {
          stream<Book, error?> courseStream = stream from var book in bookTable.toArray()
            select book;
        return courseStream;
    }
    

remote function borrow_book(Bookisbn value) returns UserResponse | error {


      Book existingBook = bookTable.get(value.isbn);
    if (existingBook.isbn === "") {
       return error("Book not found");
    }else {
    return { message: "Book borrowed successfully" };
}
}
}
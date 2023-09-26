import ballerina/io;

Library_serviceClient ep = check new ("http://localhost:9090" );

public function main() returns error? {

    // Display a menu for user interaction
    while (true) {
        io:println("\nLibrary Management System Menu:");
        io:println("1. Add Book");
        io:println("2. Create User");
        io:println("3. Update Book");
        io:println("4. Locate Book");
        io:println("5. Remove Book");
        io:println("6. List Available Books");
        io:println("7. Exit");

        string choice = io:readln("Enter your choice: ");

        match choice {
            "1" => {
                // Add Book
                Book addBookRequest = getBookDetailsFromUser();
                UserResponse addBookResponse = check ep->addBook(addBookRequest);
                io:println(addBookResponse.message);
            }
            "2" => {
                // Create User
                UserRequest createUserRequest = getUserDetailsFromUser();
                UserResponse createUserResponse = check ep->create_users(createUserRequest);
                io:println(createUserResponse.message);
            }
            "3" => {
                // Update Book
                Book updateBookRequest = getBookDetailsFromUser();
                UserResponse updateBookResponse = check ep->update_books(updateBookRequest);
                io:println(updateBookResponse.message);
            }
            "4" => {
                // Locate Book
                string locateBookRequest = io:readln("Enter ISBN of the book to locate: ");
                Book locateBookResponse = check ep->locate_book(locateBookRequest);
                io:println("Located Book: " + locateBookResponse.title);
            }
            "5" => {
                // Remove Book
                string removeBookRequest = io:readln("Enter ISBN of the book to remove: ");
                stream<Book, error?> removeBookResponse = check ep->remove_book(removeBookRequest);
                check removeBookResponse.forEach(function (Book value) {
                    io:println("Removed Book: " + value.title);
                });
            }
            "6" => {
                // List Available Books
                stream<Book, error?> listAvailableBooksResponse = check ep->list_available_books();
                check listAvailableBooksResponse.forEach(function (Book value) {
                    io:println("Available Book: " + value.title);
                });
            }
            "7" => {
                // Exit
                io:println("Exiting Library Management System.");
                return;
            }
            _ => {
                io:println("Invalid choice. Please select a valid option.");
            }
        }
    }
}

function getBookDetailsFromUser() returns Book {
    io:println("\nEnter Book Details:");
    string isbn = io:readln("ISBN: ");
    string author1 = io:readln("Author 1: ");
    string author2 = io:readln("Author 2: ");
    string location = io:readln("Location: ");
    string title = io:readln("Title: ");
    string status = io:readln("Status: ");

    Book bookDetails = {
        isbn: isbn,
        author_1: author1,
        author_2: author2,
        location: location,
        title: title,
        status: status
    };
    return bookDetails;
}

function getUserDetailsFromUser() returns UserRequest {
    io:println("\nEnter User Details:");
    string userId = io:readln("User ID: ");

    UserRequest userRequest = {
        user_id: userId
    };
    return userRequest;
}




import ballerina/http;
import ballerina/io;
import ballerina/uuid;

//WE ARE CREATING THE RECORDS FOR LECTURER AND COURSE. 
type Lecturer record {
    readonly string lecturerID; //KEY IDENTIFIER (staff number)
    string emailAddress;
    string officeNumber;
    string faculty;
    string courseCode;
    Title title; 
    Gender gender; 
    Status status; 
    Qualification qualification;
};

//ENUMS ARE USED WHEN ONE KNOWS THE OUTCOME OF A VARIABLE/VALUE.
enum Title {
    Miss,
    Mrs,
    Mr
};

enum Gender {
    Male,
    Female,
    Other
};

enum Status {
    Single,
    Married
};

enum Qualification{
    Masters,
    pHD, 
    Honours
};

type Office record{
    readonly string officeID;
    string officeNumber;
};

type Course record{
    readonly string courseCode; //KEY IDENTIFIER (course code)
    string courseNqlLevel;
    string courseName;
    string courseDescription;
    string courseCatergory;
};

type LecturersInFaculty record{
    readonly string ID;
    string lecturerID;
    string faculty;
};

type LecturersInACertainCourse record{
    readonly string ID;
    string lecturerID;
    string courseCode;
};

type LecturersInOneOffice record{
    readonly string ID;
    string lecturerID;
    string officeNumber;
};


//STORING THE RECORDS CREATE ABOVE INTO TABLES.

table<Lecturer> key(lecturerID) lecturerTable = table [];
table<Course> key(courseCode) coursesTable = table [];
table<Office> key(officeID) officeTable = table [];

table<AddingCourse> key(courseId) add_coursesTable = table [];
table<LecturersInACertainCourse> key(ID) lecturers_InACertainCourseTable = table [];
table<LecturersInOneOffice> key(ID) lecturers_InOneOfficeTable = table [];

 //CREATING FUNCTIONS FOR THE SERVER.
 
type AddingCourse record {
      readonly string courseId;
    string staffNumber;
    string courseCode;
};


service / on new http:Listener(3500) {
   
// WE ARE CREATING A FUNCTION THAT SHOULD BE ABLE TO ADD A NEW LECTURER TO THE LECTURER TABLE
    resource function post addLecturer(Lecturer newLecturer) returns string {
        error? addLecturer = lecturerTable.add(newLecturer);

        if (addLecturer is error) {
            return "Error " + addLecturer.message();
        } 
         else {
            return newLecturer.lecturerID + "saved successfuly";
        }
    }

// WE ARE CREATING A FUNCTION THAT SHOULD BE ABLE TO UPDATE A LECTURER USING THE PRIMARY KEY OF THE LECTURER
    resource function put updateExistingLecturer(Lecturer updatedLecturer) returns string {
        error? updateExistingLecturer = lecturerTable.put(updatedLecturer);

        if (updateExistingLecturer is error) {
            return "Error " + updateExistingLecturer.message();
        } 
         else {
            return updatedLecturer.lecturerID + "updated successfuly";
        }
    }

// WE ARE CREATING A FUNCTION THAT SHOULD BE ABLE TO DELETE A LECTURER USING THE PRIMARY KEY OF THE LECTURER
    resource function delete deleteLecturerByLecturerID(string lecturerID) returns string{
    
    var lecturerFound = false;
    lecturerTable = <table<Lecturer> key(lecturerID)>lecturerTable.filter((Lecturer) => Lecturer.lecturerID != lecturerID);

    foreach Lecturer lecturer in lecturerTable {
        if (lecturer.lecturerID == lecturerID) {
            lecturerFound = true;
            break;
        }
    }
    if (lecturerFound) {
        return "Lecturer with ID " + lecturerID + " has been deleted.";
    } else {
        return "Lecturer not found with ID " + lecturerID;
    }
    }

// WE ARE CREATING A FUNCTION THAT SHOULD BE ABLE TO CREATE A COURSE TO THE COURSE TABLE
    resource function post createCourse(Course newCourse) returns string|error {
        error? createCourse = coursesTable.add(newCourse);
        if createCourse is error {
            return error("Failed to Create the a new Course !");
        }
        return newCourse.courseName + " course created successfully";
   }

// WE ARE CREATING A FUNCTION THAT SHOULD BE ABLE TO ADD A NEW COURSE TO ADD_COURSES TABLE TABLE
    resource function post addCourse(AddingCourse addCourseReq) returns string|error {
        string courseId = uuid:createType1AsString();
        error? addingCourse = add_coursesTable.add(
            {
            courseId: courseId,
            staffNumber: addCourseReq.staffNumber,
            courseCode: addCourseReq.courseCode
            });
        if addingCourse is error{
            return error("Failed to add Course");
        }
        return addCourseReq.courseCode + " added succesfullly !";
    }

// WE ARE CREATING A FUNCTION THAT SHOULD BE ABLE TO GET A LECTURER USING THE PRIMARY KEY OF THE LECTURER WHICH IS THE ID
    resource function get retrieveLecturerDetailsByID/[string lecturerID] () returns Lecturer {
        Lecturer lecturer = lecturerTable.get(lecturerID);
        return lecturer;
    }

// WE ARE CREATING A FUNCTION THAT SHOULD BE ABLE TO GET All LECTURER
    resource function get retrieveAllLecturersFaculty() returns table<Lecturer> key(lecturerID) {
        return lecturerTable;
    }
// WE ARE CREATING A FUNCTION THAT SHOULD BE ABLE TO GET All LECTURER IN A CERTAIN COURSE
    resource function get retrieveAllLecturerInCertainCourse() returns string|error {
    
        var _ = from var lecturer in lecturerTable
        join var lecturerInACertainCourse in lecturers_InACertainCourseTable
        on lecturer.lecturerID equals lecturerInACertainCourse.lecturerID

        join var course in coursesTable 
        on lecturerInACertainCourse.courseCode equals course.courseCode
        
        select {
            lecturerID: lecturer.lecturerID,
            courseCode: course.courseCode
        };
        io:println("Lecturers in a certain Course ",LecturersInACertainCourse);

        return "Test Functions Succesfull. Retrived successfully By Course";
}

// WE ARE CREATING A FUNCTION THAT SHOULD BE ABLE TO GET All LECTURER BY OFFICE NUMBER
    resource function get retrieveLectureByOfficeNo() returns string|error {

        var LecturersInOneOffice = from var lecturer in lecturerTable
        join var lecturerInOneOffice in lecturers_InOneOfficeTable
        on lecturer.lecturerID equals lecturerInOneOffice.lecturerID
        
        join var office in officeTable
        on lecturerInOneOffice.officeNumber equals office.officeNumber

            select{
            lecturerID: lecturer.lecturerID,
            officeID: office.officeID
            };

            io:println("Lecturers in a same office ", LecturersInOneOffice);

        return "Test Functions Succesfull. Retrived successfully By Office";
    }
}
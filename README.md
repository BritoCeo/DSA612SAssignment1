# GROUP MEMBERS

1. Brito Manuel = 222068744
2. Rejoice Kwizi = 222076534
3. Isabel Tchikenge = 222068698
4. Jamey Rittmann = 222089822

## Functions

1. Add a new lecturer - post
2. Update an existing lecturer's information - put
3. Delete a lecturer's record by their staff number (lecturerID) - delete
4. Retrieve the details of a specific lecturer by their staff number (lecturerID) - get
5. Retrieve a list of all lecturers within the faculty - get
6. Retrieve all the lecturers that teach a certain course - get
7. Retrieve all the lecturers that sit in the same office - get
8. Search Lecturer - get

## Lecturer Structure

- lecturerID (unique key ID for staff number)
- lecturer's office number
- lecturer's title (Miss, Mr, Mrs)
- lecturer's email address
- lecturer's gender
- lecturer's qualification (Masters, pHD, Honours)

## Course Structure

- course code (unique key ID)
- course NQL level
- course name
- course description

## Generating the YAML format

- bal openapi -i main.bal

## Genearting the client

- cd client
- bal openapi -i openapi.yaml --mode client -o client

randomize();

// some macros for checking async listeners
#macro FIRESTORE_COLLECTIONQUERY "FirebaseFirestore_Collection_Query"
#macro FIRESTORE_DOCREAD "FirebaseFirestore_Document_Read"
#macro FIRESTORE_DOCSET "RESTFirebaseFirestore_Document_Set"

// listeners
listener_set = -1;
listener_read = -1;
listener_query = -1;
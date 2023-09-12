# FirebaseDS

FirebaseDS is an expansion upon the [YoyoGames Firebase Firestore library](https://marketplace.yoyogames.com/assets/10446/firebase-firestore-ext) for GameMaker, extended to support **structs** and **arrays**. Users can now read and write data structures to Firestore documents using GameMaker's structs and arrays. FirebaseDS can encode/decode any amount of nesting data structurres.

Using this extension requires litte-to-no more knowledge than that of the original library, so the original documentation is included under the **datafiles** project folder. To set a struct/array to Firestore, simply add it to the JSON in the Set() function call. For example:
```
var doc = {
  num: 64,
  str: "abc",
  dog: {
      name: "Spot",
      age: 6
    }
  };
var json = json_stringify(doc);
var docPath = "collection/doc"    // insert your own Firestore doc path here
FirebaseFirestore(docPath).Set(json);
```

You can also query collections to look for documents in which an array contains a specific value. To perform such a query, use the "array_contains" keyword in the Where() call. For example:
```
var collection = "collection"    // insert your own Firestore collection name here
listener = FirebaseFirestore(collection).Where("myArray", "array_contains", "myValue").Query()
```


Currently, FirebaseDS only works for the **REST API implementation** of the original YoyoGames Firestore library.

Only a small number of functions have been edited from the official release:
- FirebaseREST_Firestore_jsonEncode
- FirebaseREST_Firestore_jsonDecode
- FirebaseREST_firestore_value
- FirebaseREST_parseArray
- FirebaseREST_parseMap

To import FirebaseDS into your GameMaker project, you can download the [yymps here](https://github.com/rezonators/FirebaseDS/raw/main/FirebaseDS.yymps). If you want to see an example project with some simple use cases, you can clone this repository and open the FirebaseDS project in GameMaker.

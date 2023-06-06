# FirebaseDS

FirebaseDS is an expansion upon the [YoyoGames Firebase Firestore library](https://marketplace.yoyogames.com/assets/10446/firebase-firestore-ext) for GameMaker, extended to support **structs** and **arrays**. Users can now read and write data structures to Firestore documents using GameMaker's structs and arrays. FirebaseDS can encode/decode any amount of nesting data structures.

Currently, FirebaseDS only works for the **REST API implementation** of the Firestore library.

Only a small number of functions have been edited from the official release:
- FirebaseREST_Firestore_jsonEncode
- FirebaseREST_Firestore_jsonDecode
- FirebaseREST_firestore_value
- FirebaseREST_parseArray
- FirebaseREST_parseMap

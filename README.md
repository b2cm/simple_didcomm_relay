# Simple Didcomm Relay

A server app built using [Shelf](https://pub.dev/packages/shelf).
This server is able to buffer didcomm messages and release them to the 
corresponding recipient.

# Running the sample with Dart SDK

You can run the example with the [Dart SDK](https://dart.dev/get-dart)
like this:

```
$ dart run bin/server.dart
Server listening on port 8888
```

# Connect smartphone to server using adb
To ensure that your smartphone could reach this service running on your local machine, use `adb reverse`:

```
adb reverse tcp:8888 tcp:8888
```
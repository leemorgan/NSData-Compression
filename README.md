Purpose
=====
Compression is a category on NSData that provides data compression and decompression functionality by wrapping CompressionLib, a new library available on OS 10.11 and iOS 9.0

Compression is written in Swift. For the Objective-C version see [LAMCompression](https://github.com/leemorgan/NSData-LAMCompression).

Installation
=====
To use the Compression category in an app, include the `NSData+Compression.swift` file in your project.

You will also need to include the `libcompression` library in your project.

NSData Extensions
=====

    func compressedDataUsingCompression(compression: Compression) -> NSData?
Returns a NSData object created by compressing the receiver using the given compression algorithm.

<br>

    func uncompressedDataUsingCompression(compression: Compression) -> NSData?
Returns a NSData object by uncompressing the receiver using the given compression algorithm.

<br>

    convenience init?(contentsOfArchive path: String, usedCompression: Compression?)
Returns a NSData object initialized by decompressing the data from the file specified by `path` using the given `compression` algorithm.

<br>

    convenience init?(contentsOfArchive path: String)
Returns a NSData object initialized by decompressing the data from the file specified by `path`. Attempts to determine the appropriate decompression algorithm using the path's extension.

This method is equivalent to `NSData(contentsOfArchive:usedCompression:)` with `nil compression`

Documentation
=====
The `NSData+Compression` category is documented using standard Xcode doc comments.

The project has a dummy (skeleton) app which is included to support Unit Testing with Xcode. The app itself doesn't do anything interesting at all.


Supported OS & SDK Versions
=====
Compression relies on CompressionLib which is only available in OS 10.11 and iOS 9.0 and later.


Background Information
=====

[Tinkering with CompressionLib](http://blog.shiftybit.net/tinkering-with-compressionlib/)

[Tinkering with CompressionLib (Part 2)](http://blog.shiftybit.net/tinkering-with-compressionlib-part-2)

[Tinkering with CompressionLib (Part 3)](http://blog.shiftybit.net/tinkering-with-compressionlib-part-3)

By [Lee Morgan](http://shiftybit.net). If you find this useful please let me know. I'm [@leemorgan](https://twitter.com/leemorgan) on twitter.


License
=====
The license is contained in the "License.txt" file.


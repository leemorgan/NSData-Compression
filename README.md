⚠️ Deprecated and No Longer Maintained ⚠️
=====
In iOS 13 and Apple's other 2019 operating system releases there are new built-in methods on `NSData` for [compressing](https://developer.apple.com/documentation/foundation/nsdata/3174960-compressed) and [decompressing](https://developer.apple.com/documentation/foundation/nsdata/3174961-decompressed) data, so I ([@JJC1138](https://github.com/JJC1138)) won't be making any further updates to this library and would encourage you to move to the native methods when possible.

Purpose
=====
Compression is a set of extensions to Swift's Foundation Data type that provide data compression and decompression functionality by wrapping [libcompression](https://developer.apple.com/library/mac/documentation/Performance/Reference/Compression/), a new library available on OS 10.11 and iOS 9.0

Compression is written in Swift. For the Objective-C version see [LAMCompression](https://github.com/leemorgan/NSData-LAMCompression).

Installation
=====
To use the Compression extensions in an app, include the `Data+Compression.swift` file in your project.

You will also need to include the `libcompression` library in your project.

Data Extensions
=====

    func compressed(using: Compression) -> Data?
Returns a Data object created by compressing the receiver using the given compression algorithm.

<br>

    func uncompressed(using: Compression) -> Data?
Returns a Data object by uncompressing the receiver using the given compression algorithm.

<br>

    init?(contentsOfArchive: String, usedCompression: Compression?)
Returns a Data object initialized by decompressing the data from the file specified by `contentsOfArchive` using the given `usedCompression` algorithm.

<br>

    init?(contentsOfArchive: String)
Returns a Data object initialized by decompressing the data from the file specified by `contentsOfArchive`. Attempts to determine the appropriate decompression algorithm using the path's extension.

This method is equivalent to `Data(contentsOfArchive:usedCompression:)` with `nil usedCompression`

Documentation
=====
The `Data+Compression` extension is documented using standard Xcode doc comments.

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


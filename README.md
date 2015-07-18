Purpose
=====
Compression is a category on NSData that provides data compression and decompression functionality by wrapping CompressionLib, a new library available on OS 10.11 and iOS 9.0

Compression is written in Swift. For the Objective-C version see [LAMCompression](https://github.com/leemorgan/NSData-LAMCompression).

Installation
=====
To use the Compression category in an app, include the `NSData+Compression.swift` file in your project. You will also need to include the `libcompression` library.

Furthermore, you will need to provide either an Objective-C bridging header or a module to allow Swift access to libcompression.


####Use an Objective-C bridging header

&#35;import <compression.h> in an [Objective-C bridging header](https://developer.apple.com/library/ios/documentation/Swift/Conceptual/BuildingCocoaApps/MixandMatch.html).

####Use a Module

To use a module you first need to create a folder in your Project directory. You can name it whatever you like; I named it “CompressionLibModule”.

Next create a text file in the new directory and name it “module.map”

Add the following to the text file

    module libcompression [system] {
        header "/Applications/Xcode-beta.app/Contents/Developer/Platforms/MacOSX.platform/Developer/SDKs/MacOSX10.11.sdk/usr/include/compression.h"
        export *
    }
This creates a module named “libcompression” that contains the `compression.h` header.

There’s one last step. In the `Build Settings` for your `Project` (or `Target`) under `Swift Compiler - Search Paths` you need to add the path to your module’s directory to the `Import Paths`.

    $(SRCROOT)/CompressionLibModule/

Now in any Swift file you want to use CompressionLib add the following import statement

    import libcompression


NSData Extensions
=====

    func compressedDataUsingCompression(compression: Compression) -> NSData?
Returns a NSData object created by compressing the receiver using the given compression algorithm.

<br>

    func uncompressedDataUsingCompression(compression: Compression) -> NSData?
Returns a NSData object by uncompressing the receiver using the given compression algorithm.


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


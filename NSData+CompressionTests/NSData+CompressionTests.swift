//
//  NSData+CompressionTests.swift
//  NSData+CompressionTests
//
//  Created by Lee Morgan on 7/18/15.
//  Copyright © 2015 Lee Morgan. All rights reserved.
//

import XCTest
@testable import NSData_Compression

class NSData_CompressionTests: XCTestCase {
	
	override func setUp() {
		super.setUp()
		// Put setup code here. This method is called before the invocation of each test method in the class.
	}
	
	override func tearDown() {
		// Put teardown code here. This method is called after the invocation of each test method in the class.
		super.tearDown()
	}
	
	
	/// init(contentsOfArchive: usingCompression:) tests
	func test_initContentsOfArchiveUsingCompression() {
		
		let verifiedData = testDataOfType("txt")
		guard let archivePath = NSBundle.mainBundle().pathForResource("TestData", ofType: "lzfse") else {
			assertionFailure("FATAL ERROR: Failed to get path to archive Test Data")
			exit(EXIT_FAILURE)
		}
		
		
		// Test explicit compression NSData(contentsOfArchive: usingCompression:)
		let explicitData = NSData(contentsOfArchive: archivePath, usedCompression: Compression.LZFSE)
		XCTAssertTrue(explicitData!.isEqualToData(verifiedData))
		
		// Test incorrect explicit compression
		let incorrectData = NSData(contentsOfArchive: archivePath, usedCompression: Compression.LZ4)
		XCTAssertNil(incorrectData)
		
		// Test implicit compression NSData(contentsOfArchive:)
		let implicitData = NSData(contentsOfArchive: archivePath)
		XCTAssertTrue(implicitData!.isEqualToData(verifiedData))
	}
	
	
	/// uncompressedDataUsingCompression tests
	func test_uncompressedDataUsingCompression() {
		
		var compressedData : NSData
		var uncompressedData : NSData?
		let verifiedData = testDataOfType("txt")
		
		
		// Test LZ4
		compressedData = testDataOfType("lz4")
		uncompressedData = compressedData.uncompressedDataUsingCompression(Compression.LZ4)
		XCTAssertTrue(uncompressedData!.isEqualToData(verifiedData))
		
		// Test ZLIB
		compressedData = testDataOfType("zlib")
		uncompressedData = compressedData.uncompressedDataUsingCompression(Compression.ZLIB)
		XCTAssertTrue(uncompressedData!.isEqualToData(verifiedData))
		
		// Test LZMA
		compressedData = testDataOfType("lzma")
		uncompressedData = compressedData.uncompressedDataUsingCompression(Compression.LZMA)
		XCTAssertTrue(uncompressedData!.isEqualToData(verifiedData))
		
		// Test LZFSE
		compressedData = testDataOfType("lzfse")
		uncompressedData = compressedData.uncompressedDataUsingCompression(Compression.LZFSE)
		XCTAssertTrue(uncompressedData!.isEqualToData(verifiedData))
	}
	
	
	/// compressedDataUsingCompression tests
	func test_compressedDataUsingCompression() {
		
		let uncompressedData = testDataOfType("txt")
		var compressedData : NSData?
		var verifiedData : NSData
		
		// Test LZ4
		compressedData = uncompressedData.compressedDataUsingCompression(Compression.LZ4)
		verifiedData = testDataOfType("lz4")
		XCTAssertTrue(compressedData!.isEqualToData(verifiedData))
		
		// Test ZLIB
		compressedData = uncompressedData.compressedDataUsingCompression(Compression.ZLIB)
		verifiedData = testDataOfType("zlib")
		XCTAssertTrue(compressedData!.isEqualToData(verifiedData))
		
		// Test LZMA
		compressedData = uncompressedData.compressedDataUsingCompression(Compression.LZMA)
		verifiedData = testDataOfType("lzma")
		XCTAssertTrue(compressedData!.isEqualToData(verifiedData))
		
		// Test LZFSE
		compressedData = uncompressedData.compressedDataUsingCompression(Compression.LZFSE)
		verifiedData = testDataOfType("lzfse")
		XCTAssertTrue(compressedData!.isEqualToData(verifiedData))
	}
	
	
	/// Basic in memory Compression and Uncompression test
	func test_simpleStringCompression() {
		
		let testString = "Hello World"
		
		guard let testStringData = testString.dataUsingEncoding(NSUTF8StringEncoding) else {
			assertionFailure("FATAL ERROR: Failed convert string to data")
			exit(EXIT_FAILURE)
		}
		
		guard let compressedData = testStringData.compressedDataUsingCompression(Compression.LZFSE) else {
			assertionFailure("FATAL ERROR: Failed to compress data")
			exit(EXIT_FAILURE)
		}
		
		guard let uncompressedData = compressedData.uncompressedDataUsingCompression(Compression.LZFSE) else {
			assertionFailure("FATAL ERROR: Failed to uncompress data")
			exit(EXIT_FAILURE)
		}
		
		guard let uncompressedString = NSString(bytes: uncompressedData.bytes, length: uncompressedData.length, encoding: NSUTF8StringEncoding) else {
			assertionFailure("FATAL ERROR: Failed to convert to string")
			exit(EXIT_FAILURE)
		}
		
		print("\(testString) == \(uncompressedString)")
		XCTAssertEqual(uncompressedString, testString)
	}
	
	
	
	//--------------------------------------------------------
	// Support Methods
	//--------------------------------------------------------
	
	/// Test Support method
	func testDataOfType(type : String) -> NSData {
		
		let bundle = NSBundle.mainBundle()
		
		guard let testDataPath = bundle.pathForResource("TestData", ofType: type) else {
			assertionFailure("FATAL ERROR: Failed to load test data")
			exit(EXIT_FAILURE)
		}
		
		guard let testData = NSData(contentsOfFile: testDataPath) else {
			assertionFailure("FATAL ERROR: Failed to load test data")
			exit(EXIT_FAILURE)
		}
		
		// Verify Test Data isn't empty
		guard testData.length > 0 else {
			assertionFailure("FATAL ERROR: Test Data is empty")
			exit(EXIT_FAILURE)
		}
		
		return testData
	}
	
}

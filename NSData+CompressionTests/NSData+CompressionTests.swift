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
	
	
	/// init(contentsOfArchive: usedCompression:) tests
	func test_initContentsOfArchiveUsedCompression() {
		
		let verifiedData = testDataOfType("txt")
		guard let archivePath = Bundle.main.path(forResource: "TestData", ofType: "lzfse") else {
			assertionFailure("FATAL ERROR: Failed to get path to archive Test Data")
			exit(EXIT_FAILURE)
		}
		
		
		// Test explicit compression NSData(contentsOfArchive: usedCompression:)
		let explicitData = Data(contentsOfArchive: archivePath, usedCompression: Compression.lzfse)
		XCTAssertTrue(explicitData! == verifiedData)
		
		// Test incorrect explicit compression
		let incorrectData = Data(contentsOfArchive: archivePath, usedCompression: Compression.lz4)
		XCTAssertNil(incorrectData)
		
		// Test implicit compression NSData(contentsOfArchive:)
		let implicitData = Data(contentsOfArchive: archivePath)
		XCTAssertTrue(implicitData! == verifiedData)
	}
	
	
	/// uncompressedDataUsingCompression tests
	func test_uncompressedDataUsingCompression() {
		
		var compressedData : Data
		var uncompressedData : Data?
		let verifiedData = testDataOfType("txt")
		
		
		// Test LZ4
		compressedData = testDataOfType("lz4")
		uncompressedData = compressedData.uncompressedDataUsingCompression(Compression.lz4)
		XCTAssertTrue(uncompressedData!.isEqual(to: verifiedData))
		
		// Test ZLIB
		compressedData = testDataOfType("zlib")
		uncompressedData = compressedData.uncompressedDataUsingCompression(Compression.zlib)
		XCTAssertTrue(uncompressedData!.isEqual(to: verifiedData))
		
		// Test LZMA
		compressedData = testDataOfType("lzma")
		uncompressedData = compressedData.uncompressedDataUsingCompression(Compression.lzma)
		XCTAssertTrue(uncompressedData!.isEqual(to: verifiedData))
		
		// Test LZFSE
		compressedData = testDataOfType("lzfse")
		uncompressedData = compressedData.uncompressedDataUsingCompression(Compression.lzfse)
		XCTAssertTrue(uncompressedData!.isEqual(to: verifiedData))
	}
	
	
	/// compressedDataUsingCompression tests
	func test_compressedDataUsingCompression() {
		
		let uncompressedData = testDataOfType("txt")
		var compressedData : Data?
		var verifiedData : Data
		
		// Test LZ4
		compressedData = uncompressedData.compressedDataUsingCompression(Compression.lz4)
		verifiedData = testDataOfType("lz4")
		XCTAssertTrue(compressedData!.isEqual(to: verifiedData))
		
		// Test ZLIB
		compressedData = uncompressedData.compressedDataUsingCompression(Compression.zlib)
		verifiedData = testDataOfType("zlib")
		XCTAssertTrue(compressedData!.isEqual(to: verifiedData))
		
		// Test LZMA
		compressedData = uncompressedData.compressedDataUsingCompression(Compression.lzma)
		verifiedData = testDataOfType("lzma")
		XCTAssertTrue(compressedData!.isEqual(to: verifiedData))
		
		// Test LZFSE
		compressedData = uncompressedData.compressedDataUsingCompression(Compression.lzfse)
		verifiedData = testDataOfType("lzfse")
		XCTAssertTrue(compressedData!.isEqual(to: verifiedData))
	}
	
	
	/// Basic in memory Compression and Uncompression test
	func test_simpleStringCompression() {
		
		let testString = "Hello World"
		
		guard let testStringData = testString.data(using: String.Encoding.utf8) else {
			assertionFailure("FATAL ERROR: Failed convert string to data")
			exit(EXIT_FAILURE)
		}
		
		guard let compressedData = testStringData.compressedDataUsingCompression(Compression.lzfse) else {
			assertionFailure("FATAL ERROR: Failed to compress data")
			exit(EXIT_FAILURE)
		}
		
		guard let uncompressedData = compressedData.uncompressedDataUsingCompression(Compression.lzfse) else {
			assertionFailure("FATAL ERROR: Failed to uncompress data")
			exit(EXIT_FAILURE)
		}
		
		guard let uncompressedString = NSString(bytes: (uncompressedData as NSData).bytes, length: uncompressedData.count, encoding: String.Encoding.utf8) else {
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
	func testDataOfType(_ type : String) -> Data {
		
		let bundle = Bundle.main
		
		guard let testDataPath = bundle.path(forResource: "TestData", ofType: type) else {
			assertionFailure("FATAL ERROR: Failed to load test data")
			exit(EXIT_FAILURE)
		}
		
		guard let testData = try? Data(contentsOf: URL(fileURLWithPath: testDataPath)) else {
			assertionFailure("FATAL ERROR: Failed to load test data")
			exit(EXIT_FAILURE)
		}
		
		// Verify Test Data isn't empty
		guard testData.count > 0 else {
			assertionFailure("FATAL ERROR: Test Data is empty")
			exit(EXIT_FAILURE)
		}
		
		return testData
	}
	
}

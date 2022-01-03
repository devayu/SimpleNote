//
//  SimpleNoteAddNoteTests.swift
//  SimpleNoteTests
//
//  Created by Mphrx on 03/01/22.
//

import XCTest
@testable import SimpleNote

class SimpleNoteAddNoteTests: XCTestCase {

    func testAddNoteWithoutTitleTxt() {
        let note = AddNoteModel(noteId: "test-id", title: "", author: "test-author", date: Date.now, importance: "low", description: "test-desc", imgURL: nil, fileURL: nil)
        let addNoteVM = AddNoteViewModel()
        let result = addNoteVM.validateFields(title: note.title, author: note.author, description: note.description)
        XCTAssertNotNil(result.error, "")
        XCTAssertFalse(result.success)
    }
    func testAddNoteWithoutAuthorTxt() {
        let note = AddNoteModel(noteId: "test-id", title: "test-title", author: "", date: Date.now, importance: "low", description: "test-desc", imgURL: nil, fileURL: nil)
        let addNoteVM = AddNoteViewModel()
        let result = addNoteVM.validateFields(title: note.title, author: note.author, description: note.description)
        XCTAssertNotNil(result.error)
        XCTAssertFalse(result.success)
    }
    func testAddNoteWithoutDescriptionTxt() {
        let note = AddNoteModel(noteId: "test-id", title: "test-title", author: "test-author", date: Date.now, importance: "low", description: "", imgURL: nil, fileURL: nil)
        let addNoteVM = AddNoteViewModel()
        let result = addNoteVM.validateFields(title: note.title, author: note.author, description: note.description)
        XCTAssertNotNil(result.error, "")
        XCTAssertFalse(result.success)
    }
    func testAddNoteWithValidRequest() {
        let note = AddNoteModel(noteId: "test-id", title: "test-title", author: "test-author", date: Date.now, importance: "low", description: "test-description", imgURL: nil, fileURL: nil)
        let addNoteVM = AddNoteViewModel()
        let result = addNoteVM.validateFields(title: note.title, author: note.author, description: note.description)
        XCTAssertNil(result.error)
        XCTAssertTrue(result.success)
    }

}

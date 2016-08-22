import XCTest
@testable import Uniflow

class ListenerTests: XCTestCase {

  var listener: Listener!

  // MARK: - Tests

  func testInit() {
    var string: String?

    listener = Listener(identifier: "id", callback: { value  in
      string = value as? String
    })

    XCTAssertEqual(listener.identifier, "id")

    try! listener.callback("test")
    XCTAssertEqual(string, "test")
  }
}
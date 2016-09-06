import XCTest
@testable import Aftermath

class ReactionTests: XCTestCase {

  var reaction: Reaction<Calculator>!
  var state: State?

  override func setUp() {
    super.setUp()

    state = nil

    reaction = Reaction(
      progress: {
        self.state = .Progress
      },
      done: { result in
        self.state = .Data
      },
      fail: { error in
        self.state = .Error
      }
    )
  }

  override func tearDown() {
    super.tearDown()
  }

  // MARK: - Tests

  func testInitWithoutParameters() {
    reaction = Reaction()

    XCTAssertNil(reaction.progress)
    XCTAssertNil(reaction.done)
    XCTAssertNil(reaction.fail)
  }

  func testInitWithParameters() {
    XCTAssertNotNil(reaction.progress)
    XCTAssertNotNil(reaction.done)
    XCTAssertNotNil(reaction.fail)
  }

  func testInvokeWithProgress() {
    let event = Event<AdditionCommand>.Progress
    reaction.invoke(with: event)

    XCTAssertEqual(state, .Progress)
  }

  func testInvokeWithData() {
    let event = Event<AdditionCommand>.Data(Calculator(result: 11))
    reaction.invoke(with: event)

    XCTAssertEqual(state, .Data)
  }

  func testInvokeWithError() {
    let event = Event<AdditionCommand>.Error(TestError.Test)
    reaction.invoke(with: event)

    XCTAssertEqual(state, .Error)
  }
}

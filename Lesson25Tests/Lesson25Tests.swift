import XCTest
@testable import Lesson25

class Lesson25Tests: XCTestCase
{
    var sut: ViewController!
    
    override func setUpWithError() throws
    {
        super.setUp()
        sut = ViewController()
    }

    override func tearDownWithError() throws
    {
        sut = nil
        super.tearDown()
    }
    
    func testLowestVolumeShouldBeZero()
    {
        sut.setVolume(value: -100)
        let volume = sut.volume
        XCTAssert(volume == 0, "\nМинимальная громкость должна быть 0")
    }
    
    func testHighestVolumeShouldBeZero()
    {
        sut.setVolume(value: 200)
        let volume = sut.volume
        XCTAssert(volume == 100, "\nМаксимальная громкость должна быть 100")
    }
    
    func testCharactersInStringsAreTheSame()
    {
        //given
        let strOne = "asdfghjkl"
        let strTwo = "lkjhgfdsa"
        //when
        let bool = sut.chacarterCompare(strOne: strOne, strTwo: strTwo)
        //then
        XCTAssert(bool, "\nСимволы должны быть одинаковыми в двух строках")
    }
    
    func testCharactersInStringsAreDifferent()
    {
        //given
        let strOne = "asdfghjkl"
        let strTwo = "lkjhgfdsn"
        //when
        let bool = sut.chacarterCompare(strOne: strOne, strTwo: strTwo)
        //then
        XCTAssertFalse(bool, "\nСимволы должны быть разными в двух строках")
    }
}

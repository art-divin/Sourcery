import Foundation

class Foo {
    typealias Bar = [String: String]
    var name: String = ""
    var value: Int = 0
}

protocol AutoEquatable {}

class FooSubclass: Foo, AutoEquatable {
    var other: String = ""
}

func performFoo(value: Foo) {

}

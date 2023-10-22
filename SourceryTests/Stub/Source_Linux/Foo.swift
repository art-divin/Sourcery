import Foundation

class FooBarBaz {
    typealias Bar = [String]
    var name: String = ""
    var value: Int = 0
}

protocol AutoEquatable {}

class FooSubclass: Foo, AutoEquatable {
    var other: String = ""
}

func performFoo(value: Foo) {

}
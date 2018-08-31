//: [Previous](@previous)

import Foundation

///装饰者模式: 动态地将责任附加到对象上, 若要扩展功能, 装饰者提供了比继承更有弹性的替代方法

///设计原则: 类应该对扩展开放,  对修改关闭

//MARK: - 饮料
protocol Beverage{
    var description: String { get }
    func cost()->Double
}

class Espresso: Beverage{
    func cost() -> Double {
        return 1.99
    }
    
    var description: String{
        return "Espresso"
    }
}

class HouseBlend: Beverage{
    func cost() -> Double {
        return 0.89
    }
    
    var description: String{
        return "House Blend Coffee"
    }
}

//MARK: - 调料

protocol CondimentDecorator: Beverage{ }


class Mocha: CondimentDecorator{
    var beverage: Beverage
    init(beverage: Beverage) {
        self.beverage = beverage
    }
    
    var description: String{
        return beverage.description + ", Mocha"
    }
    
    func cost() -> Double {
        return 0.20 + beverage.cost()
    }
}

class Soy: CondimentDecorator{
    var beverage: Beverage
    init(beverage: Beverage) {
        self.beverage = beverage
    }
    
    var description: String{
        return beverage.description + ", Soy"
    }
    
    func cost() -> Double {
        return 0.30 + beverage.cost()
    }
}


class Whip: CondimentDecorator{
    var beverage: Beverage
    init(beverage: Beverage) {
        self.beverage = beverage
    }
    
    var description: String{
        return beverage.description + ", Whip"
    }
    
    func cost() -> Double {
        return 0.25 + beverage.cost()
    }
}




//coffee
var beverage: Beverage = Espresso()
print(beverage.description + " $\(beverage.cost())")

var beverage2: Beverage = HouseBlend()
beverage2 = Mocha(beverage: beverage2)
beverage2 = Whip(beverage: beverage2)
beverage2 = Soy(beverage: beverage2)
print(beverage2.description + " $\(beverage2.cost())")


//: [Next](@next)

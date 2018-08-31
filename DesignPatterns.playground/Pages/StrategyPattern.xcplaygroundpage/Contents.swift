//: [Previous](@previous)

import Foundation


/// 设计原则: 找出应用中可能需要变化之处, 把它们独立出来,不要和那些不需要变化的代码混在一起.
/// 设计原则: 针对借口编程, 而不是针对实现编程
/// 设计原则: 多用组合, 少用继承

protocol FlyBehavior{
    func fly()
}

protocol QuackBehavior{
    func quack()
}

struct FlyWithWings: FlyBehavior{
    func fly() {
        print("i am flying")
    }
}

struct FlyNoWay: FlyBehavior{
    func fly() {
        print("i can't fly")
    }
}

struct Quack: QuackBehavior{
    func quack() {
        print("Quack")
    }
}

struct Squeak: QuackBehavior{
    func quack() {
        print("Squeak")
    }
}

struct MuteQuack: QuackBehavior{
    func quack() {
        print("MuteQuack")
    }
}

class Duck{
    var flyBehavior: FlyBehavior
    var quackBehavior: QuackBehavior
    
    init(fly:FlyBehavior, quack:QuackBehavior) {
        self.flyBehavior = fly
        self.quackBehavior = quack
    }
    
    func performFly(){
        self.flyBehavior.fly()
    }
    
    func performQuack(){
        self.quackBehavior.quack()
    }
    
    func display(){
        
    }
}

class MallardDuck: Duck{
    override func display() {
        print("看起来像绿头鸭子")
    }
}

class RedheadDuck: Duck{
    override func display() {
        print("看起来像红头鸭子")
    }
}

class RubberDuck: Duck{
    override func display() {
        print("看起来像橡皮鸭")
    }
}

class DecoyDuck: Duck{
    override func display() {
        print("看起来像诱饵鸭")
    }
}


let decoyDuck = DecoyDuck(fly: FlyNoWay(), quack: MuteQuack())
decoyDuck.display()
decoyDuck.performFly()
decoyDuck.performQuack()

decoyDuck.quackBehavior = Quack()
decoyDuck.performQuack()


//: [Next](@next)

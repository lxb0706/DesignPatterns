//: Playground - noun: a place where people can play

import UIKit
///观察者模式: 定义了对象之间的一对多的依赖, 这样一来,当一个对象改变状态时,它的所有依赖者都会收到通知并自动更新.

///设计原则: 为了交互对象之间的松耦合设计而努力

@objc protocol Observer{
    ///所有观察者都必须实现update 方法,以实现观察者接口.
    func update(temp: Double, humidity: Double, pressure: Double)
}


/// DisplayElement 接口只包含了一个方法, display(). 当布告板需要显示时调用此方法
@objc protocol DisplayElement{
    func display()
}

@objc protocol Subject{
    func register(observer: Observer) ///< 注册观察者
    func remove(observer: Observer) ///< 移除观察者
    func notifyObservers() ///< 当主题状态改变的时候,这个方法会被调用,以通知所有观察者
}


class WeatherData: Subject{
    
    //MARK: - let & var
    var observers: Array<Observer> = []
    var temperature = 0.0
    var humidity = 0.0
    var pressure = 0.0
    
    //MARK: - implemement
    func register(observer: Observer) {
        observers.append(observer)
    }
    
    func remove(observer: Observer) {
        
        guard let index = observers.index(where: { $0 === observer }) else {
            return ;
        }
        observers.remove(at: index)
    }
    
    func notifyObservers() {
        let _ = observers.map {
            $0.update(temp: temperature, humidity: humidity, pressure: pressure)
        }
    }
    
    //MARK: - private methods
    func measurementsChanged(){
        notifyObservers()
    }
    
    func setMeasures(temp: Double, humidity: Double, pressure: Double){
        self.temperature = temp
        self.humidity = humidity
        self.pressure = pressure
        
        measurementsChanged()
    }
}

class CurrentConditionsDisplay: Observer, DisplayElement{
    var temperature: Double = 0
    var humidity: Double = 0
    var pressure: Double = 0
    
    var weatherData: Subject
    
    init(subject: Subject) {
        weatherData = subject
        weatherData.register(observer: self)
    }
    
    func update(temp: Double, humidity: Double, pressure: Double) {
        self.temperature = temp
        self.humidity = humidity
        self.pressure = pressure
        
        display()
    }
    
    ///移除注册
    func remove(){
        weatherData.remove(observer: self)
    }
    
    func display() {
        print("Current conditions: \(temperature) F degree, \(humidity) humidity, \(pressure) preesure")
    }
    
}


let weatherData = WeatherData()
let currentDisplay = CurrentConditionsDisplay(subject: weatherData)
weatherData.setMeasures(temp: 80, humidity: 65, pressure: 30.4)
currentDisplay.remove()
weatherData.setMeasures(temp: 79, humidity: 93, pressure: 29.2)
//: [Next](@next)

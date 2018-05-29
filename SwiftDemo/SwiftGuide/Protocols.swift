//
//  Protocols.swift
//  SwiftDemo
//
//  Created by liyiping on 2018/5/26.
//  Copyright © 2018年 情风. All rights reserved.
//
/*
 协议 定义了一个蓝图，规定了用来实现某一特定任务或者功能的方法、属性，以及其他需要的东西。类、结构体 或枚举都可以遵循协议，并为协议定义的这些要求提供具体实现。某个类型能够满足某个协议的要求，就可以说 该类型遵循这个协议。
 
 除了遵循协议的类型必须实现的要求外，还可以对协议进行扩展，通过扩展来实现一部分要求或者实现一些附加功能，这样遵循协议的类型就能够使用这些功能。
 */
import UIKit

//MARK:-协议语法
protocol SomeProtocol {//协议的定义方式与类、结构体和枚举的定义非常相似
    // 这里是协议的定义部分
}

protocol OtherProtocol {
    
}

//要让自定义类型遵循某个协议，在定义类型时，需要在类型名称后加上协议名称，中间以冒号( : )分隔。遵循 多个协议时，各协议之间用逗号( , )分隔:
struct SomeStruct2: SomeProtocol, OtherProtocol {
    
}

class SomeSuperClass {//父类
    
}

class SomeClass2: SomeSuperClass, SomeProtocol, OtherProtocol {
    // 这里是类的定义部分
}

//MARK:-属性要求
/*
 协议可以要求遵循协议的类型提供特定名称和类型的实例属性或类型属性。协议不指定属性是存储型属性还是计算型属性，它只指定属性的名称和类型。此外，协议还指定属性是可读的还是可读可写的。
 
 如果协议要求属性是可读可写的，那么该属性不能是常量属性或只读的计算型属性。如果协议只要求属性是可读的，那么该属性不仅可以是可读的，如果代码需要的话，还可以是可写的。
 
 协议总是用 var 关键字来声明变量属性，在类型声明后加上 { set get } 来表示属性是可读可写的，可读属性则用 { get 来表示:
 */
protocol ProtocolProperty {
    var mustBeSettable: Int { set get }
    var doesNotNeedToBesettable: Int {get}
}

/*
 协议中定义类型属性时，总是使用 static 关键字作为前缀。当类类型遵循协议时，除了 static 关键 字，还可以使用 class 关键字来声明类型属性:
 */
protocol AnotherProtocol {
    static var someTypeProperty: Int {set get}
    
}

//这是个只含有一个实例属性要求的协议:
protocol FullyNamed {
    var fullName: String { get }
    //FullyNamed 协议除了要求遵循协议的类型提供 fullName 属性外，并没有其他特别的要求。这个协议表示，任 何遵循 FullyNamed 的类型，都必须有一个可读的 String 类型的实例属性 fullName 。
}


//下面是一个遵循 FullyNamed 协议的简单结构体:
struct Person: FullyNamed {
    var fullName: String
    //Person 结构体的每一个实例都有一个 String 类型的存储型属性 fullName 。这正好满足了 FullyNamed 协 议的要求，也就意味着 Person 结构体正确地符合了协议。(如果协议要求未被完全满足，在编译时会报错。
}

class Starship: FullyNamed {
    var prefix: String?
    var name: String
    init(name: String, prefix: String? = nil) {
        self.name = name
        self.prefix = prefix
    }
    
    var fullName: String {
        return (prefix != nil ? prefix! + " " : " ") + name
    }
}

//MARK:-方法要求
/*
 协议可以要求遵循协议的类型实现某些指定的实例方法或类方法。这些方法作为协议的一部分，像普通方法一样放在协议的定义中，但是不需要大括号和方法体。可以在协议中定义具有可变参数的方法，和普通方法的定义方式相同。但是，不支持为协议中的方法的参数提供默认值。
 
 正如属性要求中所述，在协议中定义类方法的时候，总是使用 static 关键字作为前缀。当类类型遵循协议 时，除了 static 关键字，还可以使用 class 关键字作为前缀:
 */
protocol MethodProtocol {
    static func someTypeMethod()
}

protocol RandomNumberGenerator {
    func random() -> Double
}

class LinearCongruentialGenerator: RandomNumberGenerator {
    var lastRandom = 42.0
    let m = 139968.0
    let a = 3887.0
    let c = 2973.0
    func random() -> Double {
        lastRandom = ((lastRandom * a + c).truncatingRemainder(dividingBy: m))
        return lastRandom / m
    }
}

//MARK:-Mutating 方法要求
/*
 有时需要在方法中改变方法所属的实例。例如，在值类型(即结构体和枚举)的实例方法中，将 mutating 关键 字作为方法的前缀，写在 func 关键字之前，表示可以在该方法中修改它所属的实例以及实例的任意属性的 值。
 
 如果你在协议中定义了一个实例方法，该方法会改变遵循该协议的类型的实例，那么在定义协议时需要在方法前 加 mutating 关键字。这使得结构体和枚举能够遵循此协议并满足此方法要求。
 */
protocol Togglable {
    mutating func toggle()
}
enum OnOffSwitch: Togglable {
    case Off, On
    mutating func toggle() {
        switch self {
        case .Off:
            self = .On
        case .On:
            self = .Off
        }
    }
}

//MARK:-构造器要求
/*
 协议可以要求遵循协议的类型实现指定的构造器。你可以像编写普通构造器那样，在协议的定义里写下构造器的声明，但不需要写花括号和构造器的实体
 */
protocol InitializeProtocol {
    init(someParamter: Int)
}

/*
 构造器要求在类中的实现
 
 你可以在遵循协议的类中实现构造器，无论是作为指定构造器，还是作为便利构造器。无论哪种情况，你都必须 为构造器实现标上 required 修饰符:
*/
class InitializeProtocolClass: InitializeProtocol {
    required init(someParamter: Int) {
        // 这里是构造器的实现部分
        //使用 required 修饰符可以确保所有子类也必须提供此构造器实现，从而也能符合协议。
    }
}
//如果一个子类重写了父类的指定构造器，并且该构造器满足了某个协议的要求，那么该构造器的实现需要同时标 注 required 和 override 修饰符:
protocol SomesProtocol {
    init()
}
class SomesSuperClass {
    init() {
        // 这里是构造器的实现部分
    }
}
class SomesSubClass: SomesSuperClass, SomesProtocol {
    // 因为遵循协议，需要加上 required
    // 因为继承自父类，需要加上 override
    required override init() {
        // 这里是构造器的实现部分
    }
}
//可失败构造器要求
//遵循协议的类型可以通过可失败构造器( init? )或非可失败构造器( init )来满足协议中定义的可失败构造器 要求。协议中定义的非可失败构造器要求可以通过非可失败构造器( init )或隐式解包可失败构造器( init! )来满足

//MARK:-协议作为类型
/*
 尽管协议本身并未实现任何功能，但是协议可以被当做一个成熟的类型来使用。
 
 协议可以像其他普通类型一样使用，使用场景如下:
 
 • 作为函数、方法或构造器中的参数类型或返回值类型
 • 作为常量、变量或属性的类型
 • 作为数组、字典或其他容器中的元素类型
 
 协议是一种类型，因此协议类型的名称应与其他类型(例如 Int ， Double ， String )的写法相同，使用大写 字母开头的驼峰式写法，例如(FullyNamed 和RandomNumberGenerator)。
 */
class Dice {
    let sides: Int
    let generator: RandomNumberGenerator
    init(side: Int, generator: RandomNumberGenerator) {
        self.sides = side
        self.generator = generator
    }
    
    func roll() -> Int {
        return Int(generator.random() * Double(sides)) + 1
    }
}

//MARK:-委托(代理)模式
/*
 委托是一种设计模式，它允许类或结构体将一些需要它们负责的功能委托给其他类型的实例。委托模式的实现很简单:定义协议来封装那些需要被委托的功能，这样就能确保遵循协议的类型能提供这些功能。委托模式可以用来响应特定的动作，或者接收外部数据源提供的数据，而无需关心外部数据源的类型。
 下面的例子定义了两个基于骰子游戏的协议:
 */
protocol DiceGame {
    var dice: Dice { get }
    func play()
}

protocol DiceGameDelegate {
    func gameDidStart(_ game: DiceGame)
    func game(_ game: DiceGame, didStartNewTurnWithDiceRoll diceRoll: Int)
    func gameDidEnd(_ game: DiceGame)
    /*
     DiceGame 协议可以被任意涉及骰子的游戏遵循。DiceGameDelegate 协议可以被任意类型遵循，用来追踪 Game 的游戏过程。
     */
}

class SnakesAndLadders: DiceGame {
    let finalSquare = 25
    let dice = Dice(side: 6, generator: LinearCongruentialGenerator())
    var square = 0
    var board: [Int]
    init() {
        board = [Int](repeating: 0, count: finalSquare + 1)
        board[03] = +08; board[06] = +11; board[09] = +09; board[10] = +02
        board[14] = -10; board[19] = -11; board[22] = -02; board[24] = -08
    }
    
    var delegate: DiceGameDelegate?
    func play() {
        square = 0
        delegate?.gameDidStart(self)
        gameLoop: while square != finalSquare {
            let diceRoll = dice.roll()
            delegate?.game(self, didStartNewTurnWithDiceRoll: diceRoll)
            switch square + diceRoll {
            case finalSquare:
                break gameLoop
            case let newSquare where newSquare > finalSquare:
                break gameLoop
            default:
                square += diceRoll
                square += board[square]
            }
        }
        delegate?.gameDidEnd(self)
    }
    /*
     This version of the game is wrapped up as a class called SnakesAndLadders, which adopts the DiceGame protocol. It provides a gettable dice property and a play() method in order to conform to the protocol. (The dice property is declared as a constant property because it doesn’t need to change after initialization, and the protocol only requires that it must be gettable.)
     
     The Snakes and Ladders game board setup takes place within the class’s init() initializer. All game logic is moved into the protocol’s play method, which uses the protocol’s required dice property to provide its dice roll values.
     
     Note that the delegate property is defined as an optional DiceGameDelegate, because a delegate isn’t required in order to play the game. Because it’s of an optional type, the delegate property is automatically set to an initial value of nil. Thereafter, the game instantiator has the option to set the property to a suitable delegate. Because the DiceGameDelegate protocol is class-only, you can declare the delegate to be weak to prevent reference cycles.
     
     DiceGameDelegate provides three methods for tracking the progress of a game. These three methods have been incorporated into the game logic within the play() method above, and are called when a new game starts, a new turn begins, or the game ends.
     
     Because the delegate property is an optional DiceGameDelegate, the play() method uses optional chaining each time it calls a method on the delegate. If the delegate property is nil, these delegate calls fail gracefully and without error. If the delegate property is non-nil, the delegate methods are called, and are passed the SnakesAndLadders instance as a parameter.
     */
}

class DiceGameTracker: DiceGameDelegate {
    var numberOfTurns = 0
    func gameDidStart(_ game: DiceGame) {
        numberOfTurns = 0
        if game is SnakesAndLadders {
            print("Started a new game of Snakes and Ladders")
        }
        print("The game is using a \(game.dice.sides)-sided dice")
    }
    
    func game(_ game: DiceGame, didStartNewTurnWithDiceRoll diceRoll: Int) {
        numberOfTurns += 1
        print("Rolled a \(diceRoll)")
    }
    
    func gameDidEnd(_ game: DiceGame) {
        print("The game lasted for \(numberOfTurns) turns")
    }

    /*
     DiceGameTracker实现了DiceGameDelegate协议要求的三个方法用来记录游戏已经进行的轮数。当游戏开始时，numberOfTurn属性被赋值为0，然后在每一轮中递增，游戏结束之后，打印游戏的总轮数
     
     gameDidStart(_:)方法从game参数获取游戏信息并且打印。game参数是DiceGame类型，而不是SnakeAndLadders类型，所以在gameDidStart(_:)发方法中只能访问DiceGame协议中的内容。当然，SnakeAdnLadders的方法也可以在类型转换之后调用。在上例代码中，通过is操作符game是否为SnakeAndLadders类型的实例，如果是，则打印出相应的消息。
     
     无论当前进行的是何种游戏，由于game符合DiceGame协议，可以确保game含有dice属性。因此，在gameDidStart(_:)方法中可以通过传入的game参数类访问dice属性，进而打印dice的sides属性的值。
     */
}

//MARK:-通过扩展添加协议一致性
/*
 即便无法修改源代码，依然可以通过扩展令已有类型遵循并符合协议。扩展可以为已有类型添加属性、方法、下标以及构造器，因此可以符合协议中的相应要求
 
 下面这个 TextRepresentable 协议，任何想要通过文本表示一些内容的类型都可以实现该协议。这些想要表 示的内容可以是实例本身的描述，也可以是实例当前状态的文本描述:
 */
protocol TextRepresentable {
    var textualDescription: String { get }
}

//可以通过扩展，令先前提到的 Dice 类遵循并符合 TextRepresentable 协议:
extension Dice: TextRepresentable {
    var textualDescription: String {
        return "A \(sides) - sided dice"
    }
}

//MARK:-通过扩展遵循协议
//当一个类型已经符合了某个协议中的所有要求，却还没有声明遵循该协议时，可以通过空扩展体的扩展来遵循该协议
struct Hamster {
    var name: String
    var textualDescription: String {
        return "A hamster named \(name)"
    }
}

extension Hamster: TextRepresentable{
    //从现在起，Hamster 的实例可以作为 TextRepresentable 类型使用:
}

//MARK:-协议的继承
//协议能够继承一个或多个其他协议，可以在继承的协议的基础上增加新的要求。协议的继承语法与类的继承相似，多个被继承的协议间用逗号分隔
protocol InheritingProtocol: SomesProtocol, OtherProtocol {
     // protocol definition goes here
}

protocol PrettyTextRepresentable: TextRepresentable {
    var prettyTextualDescription: String {get}
}

extension SnakesAndLadders: PrettyTextRepresentable {
    var textualDescription: String {
        return "textualDescription"
    }
    
    var prettyTextualDescription: String {
        var output = textualDescription + ":\n"
        for index in 1...finalSquare {
            switch board[index] {
            case let ladder where ladder > 0:
                output += "▲ "
            case let snake where snake < 0:
                output += "▼ "
            default:
                output += "○ "
            }
        }
        return output
    }
    /*
     上述扩展令 SnakesAndLadders 遵循了 PrettyTextRepresentable 协议，并提供了协议要求的
     prettyTextualDescription 属性。每个 PrettyTextRepresentable 类型同时也是 TextRepresentable 类型，所以在 tualDescription 的实现中，可以访问prettyTextextualDescription 属性。然后，拼接上了冒号和换行符。接着，遍历 数组中的元素，拼接一个几何图形来表示每个棋盘方格的内容:
     
     • 当从数组中取出的元素的值大于 0 时，用 ▲ 表示。
     • 当从数组中取出的元素的值小于 0 时，用 ▼ 表示。
     • 当从数组中取出的元素的值等于 0 时，用 ○ 表示。
     */
}

//MARK:-类类型专属协议
//在协议的继承列表中，通过添加 class 关键字来限制协议只能被类类型遵循，而结构体或枚举不能遵循 该协议。class 关键字必须第一个出现在协议的继承列表中，在其他继承的协议之前:
protocol SomeProtocolOnlyProtocol: class, SomesProtocol {
    // 这里是类类型专属协议的定义部分

/*
 在以上例子中，协议 SomeClassOnlyProtocol 只能被类类型遵循。如果尝试让结构体或枚举类型遵循该协议，则 会导致编译错误。
     
     当协议定义的要求需要遵循协议的类型必须是引用语义而非值语义时，应该采用类类型专属协议。关于引用语义 和值语义的更多内容，请查看:结构体和枚举是值类型和类是引用类型。
 */
}


//MARK:-协议合成
/*
 有时候需要同时遵循多个协议，你可以将多个协议采用 SomeProtocol & AnotherProtocol 这样的格式进行组合，称为 协议合成(protocol composition)。你可以罗列任意多个你想要遵循的协议，以与符号( & )分隔。

 下面的例子中，将 Named 和 Aged 两个协议按照上述语法组合成一个协议，作为函数参数的类型:
 */
protocol Named {
    var name: String { get }
}

protocol Aged {
    var age: Int { get }
}

struct ProtocolPerson: Named, Aged {
    var name: String
    var age: Int
}

//MARK:-检查协议一致性
/*
 你可以使用类型转换中描述的 is 和 as 操作符来检查协议一致性，即是否符合某协议，并且可以转换到指定 的协议类型。检查和转换到某个协议类型在语法上和类型的检查和转换完全相同:
 
 • is 用来检查实例是否符合某个协议，若符合则返回 true ，否则返回 false 。
 • as? 返回一个可选值，当实例符合某个协议时，返回类型为协议类型的可选值，否则返回 nil 。
 • as! 将实例强制向下转换到某个协议类型，如果强转失败，会引发运行时错误。
 
 下面的例子定义了一个 HasArea 协议，该协议定义了一个 Double 类型的可读属性 area :
 */
protocol HasArea {
    var area: Double { get }
}

class Circle: HasArea {
    let pi = 3.1415926
    var radius: Double
    var area: Double { return pi * radius * radius }
    init(radius: Double) {
        self.radius = radius
    }
}

class Country: HasArea {
    var area: Double
    init(area: Double) {
        self.area = area
    }
}
/*
 Circle类把area属性实现为基于存储属性的radius的计算属性；Country类把area属性实现为存储属性。这两个类都正确地符合了HasArea协议
 */

class ProtocolAnimal {
    var legs: Int
    init(legs: Int) {
        self.legs = legs
    }
}

//MARK:-可选的协议要求
/*
 协议可以定义可选要求，遵循协议的类型可以选择是否实现这些要求。在协议中使用 optional 关键字作为前缀 来定义可选要求。可选要求用在你需要和 Objective-C 打交道的代码中。协议和可选要求都必须带上 @objc 属 性。标记 @objc 特性的协议只能被继承自 Objective-C 类的类或者 @objc 类遵循，其他类以及结构体和枚举 均不能遵循这种协议。
 
 使用可选要求时(例如，可选的方法或者属性)，它们的类型会自动变成可选的。比如，一个类型为(int) -> String 的方法会变成 ((Int) -> String)? 。需要注意的是整个函数类型是可选的，而不是函数的返回值。
 
 协议中的可选要求可通过可选链式调用来使用，因为遵循协议的类型可能没有实现这些可选要求。类似 someOptionalMethod?(someArgument) 这样，你可以在可选方法名称后加上 ? 来调用可选方法。详细内容可在可选链式 调用章节中查看。

 下面的例子定义了一个名为 Counter 的用于整数计数的类，它使用外部的数据源来提供每次的增量。数据源由 CounterDataSource 协议定义，包含两个可选要求:
 */
@objc protocol CounterDataSource {
    @objc optional func increment(forCount count: Int) -> Int
    @objc optional var fixedIncrement:Int { get }
    //CounterDataSource 协议定义了一个可选方法 increment(forCount:) 和一个可选属性 fiexdIncrement ，它们 使用了不同的方法来从数据源中获取适当的增量值。
}
class ProtocolCounter {
    var count = 0
    var dataSource: CounterDataSource?
    func increment() {
        if let amount = dataSource?.increment?(forCount: count) {
            count += amount
        } else if let amount = dataSource?.fixedIncrement {
            count += amount
        }
    }
}

class ThreeSource: NSObject, CounterDataSource {
    let fixedIncrement = 3
}

//下面是一个更为复杂的数据源 TowardsZeroSource ，它将使得最后的值变为 0 :
@objc class TowardsZeroSource: NSObject, CounterDataSource {
    func increment(forCount count: Int) -> Int {
        if count == 0 {
            return 0
        } else if count < 0 {
            return 1
        } else {
            return -1
        } }
}

//MARK:-协议扩展
/*
 协议可以通过扩展来为遵循协议的类型提供属性、方法以及下标的实现。通过这种方式，你可以基于协议本身来实现这些功能，而无需在每个遵循协议的类型中都重复同样的实现，也无需使用全局函数。
 
 例如，可以扩展 RandomNumberGenerator 协议来提供 randomBool() 方法。该方法使用协议中定义的 rando m() 方法来返回一个随机的 Bool 值:
 */
extension RandomNumberGenerator {
    func randomBool() -> Bool {
        return random() > 0.5
    }
    
}

//MARK:-提供默认实现
/*
 可以通过协议扩展来为协议要求的属性、方法以及下标提供默认的实现。如果遵循协议的类型为这些要求提供了自己的实现，那么这些自定义实现将会替代扩展中的默认实现被使用。
 
 例如，PrettyTextRepresentable 协议继承自 TextRepresentable 协议，可以为其提供一个默认的 ualDescription 属性，只是简单地返回 textualDescription 属性的值:
 */
extension PrettyTextRepresentable {
    var prettyTextualDescription: String {
        return textualDescription
    }
}

//MARK:-为协议扩展添加限制条件
/*
 在扩展协议的时候，可以指定一些限制条件，只有遵循协议的类型满足这些限制条件时，才能获得协议扩展提供的默认实现。这些限制条件写在协议名之后，使用 where 子句来描述，正如Where子句 (页 0)中所描述的。
 
 例如，你可以扩展Collection协议，但是只适用于合中的元素遵循了Equatable协议的情况:
 */

extension Collection where Element: Equatable {
    func allEqual() -> Bool {
        for element in self {
            if element != self.first {
                return false
            }
        }
        return true
    }
}


//MARK:-Main ViewController
class Protocols: UIViewController {

    func wishHappyBirthday(to celebrator: Named & Aged) {
        print("Happy birthday,\(celebrator.name),you are \(celebrator.age)")
        
        /*
         Named协议包含String类型的name属性，Aged协议包含String类型的age属性。ProtocolPerson结构体遵 循了这两个协议。
         
         wishHappyBirthday(to:)函数的参数celebrator的类型为：Named & Aged；这意味着它不关心参数的具体类型，只要参数符合这两个协议即可
         */
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.white
        
        let john = Person(fullName: "John Applessed")
        print(john.fullName)
        
        let ncc1701 = Starship(name: "Enterprise", prefix: "USS")
        print(ncc1701.fullName)
        
        let generator = LinearCongruentialGenerator()
        for i in 0...10 {
            print("the \(i) random number is:\(generator.random()) ")
        }
        
        var lightSwitch = OnOffSwitch.Off
        lightSwitch.toggle()
        if lightSwitch == .On {
            print("On")
        } else {
            print("Off")
        }
    
        lightSwitch.toggle()
        if lightSwitch == .On {
            print("On")
        } else {
            print("Off")
        }
        
        let d6 = Dice(side: 6, generator: LinearCongruentialGenerator())
        for _ in 1...5 {
            print("Random dice roll is \(d6.roll())")
        }
        
        let tracker = DiceGameTracker()
        let game = SnakesAndLadders()
        game.delegate = tracker
        game.play()
        
        let d12 = Dice(side: 12, generator: LinearCongruentialGenerator())
        print(d12.textualDescription)
        
        let simonTheHanster = Hamster(name: "Simon")
        let somethingTextRepresentable: TextRepresentable = simonTheHanster
        print(somethingTextRepresentable.textualDescription)
        
        print("------------------------------------------")
        //MARK:-协议类型的集合
        //协议类型可以在数组或者字典这样的集合中使用，下面的例子创建了一个 元素类型为 TextRepresentable 的数组:
        let things: [TextRepresentable] = [d12, simonTheHanster]
        for thing in things {
            print(thing.textualDescription)
        }
        print("------------------------------------------")
        
        print(game.prettyTextualDescription)
        
        let birthdayPerson = ProtocolPerson(name: "Malcolm", age: 21)
        wishHappyBirthday(to: birthdayPerson)
        //这个例子创建了一个名为birthdayPerson的ProtocolPerson类型的实例，作为参数传递给wishHappyBirthday(to:)函数。因为ProtocolPerson同时符合这两个协议，所以这个参数合法，函数将打印生日问候语。
        
//        Circle，Country，Animal 并没有一个共同的基类，尽管如此，它们都是类，它们的实例都可以作为 ect 类型的值，存储在同一个数组中:
        let objects: [AnyObject] = [
            Circle(radius: 2.0),
            Country(area:243_610),
            ProtocolAnimal(legs: 4)
            //objects 数组使用字面量初始化，数组包含一个 radius 为 2 的 Circle 的实例，一个保存了英国国土面 积的 Country 实例和一个 legs 为 4 的 Animal 实例
        ]
        //如下所示，objects 数组可以被迭代，并对迭代出的每一个元素进行检查，看它是否符合 HasArea 协议:
        for object in objects {
            if let objectWithArea = object as? HasArea {
                print("Area is \(objectWithArea.area)")
            } else {
                print("Something that does not have an area")
            }
            /*
             当迭代出的元素符合 HasArea 协议时，将 as? 操作符返回的可选值通过可选绑定，绑定到 objectWithArea 常量上。objectWithArea 是 HasArea 协议类型的实例，因此 area 属性可以被访问和打印。
             objects 数组中的元素的类型并不会因为强转而丢失类型信息，它们仍然是 Circle，Country，Animal 类 型。然而，当它们被赋值给 objectWithArea 常量时，只被视为 HasArea 类型，因此只有 area 属性能够被 访问。
             */
            
            let counter = ProtocolCounter()
            counter.dataSource = ThreeSource()
            for _ in 1...4 {
                counter.increment()
                print(counter.count)
            }
            //上述代码新建了一个 Counter 实例，并将它的数据源设置为一个 ThreeSource 的实例，然后调用 incremen t() 方法四次。和预期一样，每次调用都会将 count 的值增加 3 .
            
            //你可以使用 TowardsZeroSource 实例将 Counter 实例来从 -4 增加到 0 。一旦增加到 0 ，数值便不会再 有变动:
            counter.count = -4
            counter.dataSource = TowardsZeroSource()
            for _ in 1...5 {
                counter.increment()
                print(counter.count)
            }
         
//            通过协议扩展，所有遵循协议的类型，都能自动获得这个扩展所增加的方法实现，无需任何额外修改:
            let generator = LinearCongruentialGenerator()
            print("Here's a random number: \(generator.random())")
            print("And here's a random Boolean: \(generator.randomBool())")
            
            let equalNumbers = [100, 100, 100, 100, 100]
            let differentNumbers = [100, 100, 200, 100, 200]
            print(equalNumbers.allEqual())//true
            print(differentNumbers.allEqual())//false
        }
    
    }
}











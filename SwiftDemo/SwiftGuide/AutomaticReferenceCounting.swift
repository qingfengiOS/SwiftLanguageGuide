//
//  AutomaticReferenceCounting.swift
//  SwiftDemo
//
//  Created by liyiping on 2018/6/2.
//  Copyright © 2018年 情风. All rights reserved.
//

import UIKit

//MARK:-ARC的工作机制
/*
 当你每次创建一个类的新的实例的时候，ARC 会分配一块内存来储存该实例信息。内存中会包含实例的类型信息，以及这个实例所有相关的存储型属性的值。
 
 此外，当实例不再被使用时，ARC 释放实例所占用的内存，并让释放的内存能挪作他用。这确保了不再被使用的实例，不会一直占用内存空间。
 
 然而，当 ARC 收回和释放了正在被使用中的实例，该实例的属性和方法将不能再被访问和调用。实际上，如果你试图访问这个实例，你的应用程序很可能会崩溃。
 
 为了确保使用中的实例不会被销毁，ARC 会跟踪和计算每一个实例正在被多少属性，常量和变量所引用。哪怕实例的引用数为1，ARC都不会销毁这个实例。
 
 为了使上述成为可能，无论你将实例赋值给属性、常量或变量，它们都会创建此实例的强引用。之所以称之为“强”引用，是因为它会将实例牢牢地保持住，只要强引用还在，实例是不允许被销毁的。
 */

//MARK:-ARC实践
class ARCPerson {
    let name: String
    
    init(name: String) {
        self.name = name
        print("\(name) is beging initialized")
    }
    
    deinit {
        print("\(name) is being deinitialized")
    }
}

//MARK:-类实例之间的循环强引用
/*
 然而，我们可能会写出一个类实例的强引用数永远不能变成0的代码。如果两个类实例互相持有对方的强引用，因而每个实例都让对方一直存在，就是这种情况。这就是所谓的循环强引用。
 
 你可以通过定义类之间的关系为弱引用或无主引用，以替代强引用，从而解决循环强引用的问题。
 */
class StrongReferencePerson {
    let name: String
    init(name: String) {
        self.name = name
    }
    
    var apartment: StrongReferenceApartment?
    deinit {
        print("\(name) is being deinitialized")
    }
}

class StrongReferenceApartment {
    let unit: String
    init(unit: String) {
        self.unit = unit
    }
    
    var tenant: StrongReferencePerson?
    deinit {
        print("Apartment \(unit) is being deinitialized")
    }
}

//MARK:-解决实例之间的循环强引用
/*
 Swift提供了两种办法来解决你在使用类属性时所遇到的循环强引用问题：弱引用(weak reference)和无助引用(unowned reference)
 
 弱引用和无主引用允许循环引用中的一个实例引用另外一个实例不保持请引用。这样实例能够互相引用而不产生循环强引用。
 
 当其他的实例有更短的生命周期时，使用弱引用，也就是说，当其他实例析构在先时。在上面公寓的例子中，很显然一个公寓在它的生命周期内会在某个时间段没有它的主人，所以一个弱引用就加在公寓类里面，避免循环引用。相比之下，当其他实例有相同的或者更长生命周期时，请使用无主引用。
 */

//MARK:-弱引用
/*
 弱引用不会对其引用的实例保持强引用，因而不会阻止 ARC 销毁被引用的实例。这个特性阻止了引用变为循环强引用。声明属性或者变量时，在前面加上weak关键字表明这是一个弱引用。
 
 因为弱引用不会保持所引用的实例，即使引用存在，实例也有可能被销毁。因此，ARC 会在引用的实例被销毁后自动将其赋值为nil。并且因为弱引用可以允许它们的值在运行时被赋值为nil，所以它们会被定义为可选类型变量，而不是常量。
 
 你可以像其他可选值一样，检查弱引用的值是否存在，你将永远不会访问已销毁的实例的引用。
 
 注意:
 当 ARC 设置弱引用为nil时，属性观察不会被触发。
*/
class WeakReferencePerson {
    let name: String
    init(name: String) {
        self.name = name
    }
    
    var apartment: WeakReferenceApartment?
    deinit {
        print("\(name) is being deinitialized")
    }
}

class WeakReferenceApartment {
    let unit: String
    init(unit: String) {
        self.unit = unit
    }
    
    weak var tenant: WeakReferencePerson?//WeakReferenceApartment的tenant属性被声明为弱引用：
    deinit {
        print("Apartment \(unit) is being deinitialized")
    }
}

//MARK:-无主引用
/*
 和弱引用类似，无主引用不会牢牢保持住引用的实例。和弱引用不用的是，无主引用在其他实例有相同或者更长的生命周期时使用。你可以在生命属性或者变量时，在前面加上unowned表示这是一个无主引用。
 
 无主引用通常都被期望拥有值。不过ARC无法在实例被销毁后将无主引用设为nil，因为非可选类型的变量不允许被赋值为nil。
 
 care：
 1、使用无主引用，必须确保引用始终指向一个未销毁的实例
 2、如果试图在实例被销毁后访问该实例的无主引用，会触发运行时错误。
 */

/*
 下面的例子定义了两个类，Customer和CreditCard，模拟了银行客户和客户的信用卡。这两个类中，每一个都将另外一个类的实例作为自身的属性。这种关系可能会造成循环强引用。
 
 Customer和CreditCard之间的关系与前面弱引用例子中Apartment和Person的关系略微不同。在这个数据模型中，一个客户可能有或者没有信用卡，但是一张信用卡总是关联着一个客户。为了表示这种关系，Customer类有一个可选类型的card属性，但是CreditCard类有一个非可选类型的customer属性。
 
 此外，只能通过将一个number值和customer实例传递给CreditCard构造函数的方式来创建CreditCard实例。这样可以确保当创建CreditCard实例时总是有一个customer实例与之关联。
 
 由于信用卡总是关联着一个客户，因此将customer属性定义为无主引用，用以避免循环强引用：
 */
class Customer {
    let name: String
    var card: CreditCard?
    
    init(name: String) {
        self.name = name
    }
    
    deinit {
        print("\(name) is being deinitialized")
    }
}

class CreditCard {
    let number: UInt64
    unowned let customer: Customer
    init(number: UInt64, customer: Customer) {
        self.number = number
        self.customer = customer
    }
    
    deinit {
        print("Card #\(number) is being deinitialized")
    }
}

//MARK:-闭包引起的循环强引用
/*
 循环强引用还发生在当你将一个闭包赋值给类实例的某个属性，并且这个闭包体中又使用了这个类的实例方法时。这个闭包体中可能访问了实例的某个属性，例如self.someProperty,或者闭包中调用了某个实例方法，例如self.someMethod()。这两种情况下都导致了闭包“捕获”self，从而产生了循环强引用
 
 循环强引用的产生，是因为闭包和类相似，都是引用类型。当你把一个闭包赋值给某个属性时，你是将这个闭包的引用赋值给了属性。实质上，这跟之前的问题是一样的——两个强引用让彼此一直有效。但是，和两个类实例不同，这次一个是类实例，另一个是闭包。
 
 Swift提供了一种优雅的方法来解决这个问题，称之为闭包捕获列表（closure capture list）
 
 下面的例子展示了当一个闭包引用self之后如何产生一个循环强引用的。例子中定义了一个叫HTMLElement的类，用一种简单的模型表示 HTML 文档中的一个单独的元素：
 */
class HTMLElement {
    let name: String
    let text: String?
    
    lazy var asHTML: () -> String = {
        if let text = self.text {
            return "<\(self.name)>\(text)</\(self.name)>"
        } else {
            return "<\(self.name) />"
        }
    }
    
    init(name: String, text: String? = nil) {
        self.name = name
        self.text = text
    }
    
    deinit {
        print("\(name) is being deinitialized")
    }
    /*
     HTMLElement类定义了一个name属性来表示这个元素的名称，例如代表头部元素的"h1"，代表段落的"p"，或者代表换行的"br"。HTMLElement还定义了一个可选属性text，用来设置 HTML 元素呈现的文本。
     
     除了上面的两个属性，HTMLElement还定义了一个lazy属性asHTML。这个属性引用了一个将name和text组合成 HTML 字符串片段的闭包。该属性是Void -> String类型，或者可以理解为“一个没有参数，返回String的函数”。
     
     默认情况下，闭包赋值给了asHTML属性，这个闭包返回一个代表 HTML 标签的字符串。如果text值存在，该标签就包含可选值text；如果text不存在，该标签就不包含文本。对于段落元素，根据text是"some text"还是nil，闭包会返回"<p>some text</p>"或者"<p />"。
     
     可以像实例方法那样去命名、使用asHTML属性。然而，由于asHTML是闭包而不是实例方法，如果你想改变特定 HTML 元素的处理方式的话，可以用自定义的闭包来取代默认值。
      */
    
}

//MARK:-解决闭包引起的循环强引用
/*
 在定义闭包时同时定义捕获列表作为闭包的一部分，通过这种方式可以解决闭包和类实例之间的循环强引用。捕获列表定义了闭包体内捕获一个或者多个引用类型的规则。跟解决两个类实例间的循环强引用一样，声明每个捕获的引用为弱引用或无主引用，而不是强引用。应当根据代码关系来决定使用弱引用还是无主引用。
 
 Swift 有如下要求：只要在闭包内使用self的成员，就要用self.someProperty或者self.someMethod()（而不只是someProperty或someMethod()）。这提醒你可能会一不小心就捕获了self。
 */

//MARK:-定义捕获列表
/*
 捕获列表中的每一项都由一对元素组成，一个元素是weak或unowned关键字，另一个元素是类实例的引用（例如self）或初始化过的变量（如delegate = self.delegate!）。这些项在方括号中用逗号分开。
 
 如果闭包有参数列表和返回类型，把捕获列表放在它们前面：
 lazy var someClosure: (Int, String) -> String = {
     [unowned self, weak delegate = self.delegate!] (index: Int, stringToProcess: String) -> String in
     // 这里是闭包的函数体
 }
 
 如果闭包没有指明参数列表或者返回类型，即它们会通过上下文推断，那么可以把捕获列表和关键字in放在闭包最开始的地方
 lazy var someClosure: Void -> String = {
     [unowned self, weak delegate = self.delegate!] in
     // 这里是闭包的函数体
 }
 */

/*
 弱引用和无主引用
 
 在闭包和捕获的实例总是互相引用并且总是同时销毁时，将闭包内的捕获定义为无主引用。
 
 相反的，在被捕获的引用可能会变为nil时，将闭包内的捕获定义为弱引用。弱引用总是可选类型，并且当引用的实例被销毁后，弱引用的值会自动置为nil。这使我们可以在闭包体内检查它们是否存在。
 
 如果被捕获的引用绝对不会变为nil，应该用无主引用，而不是弱引用
 */
class HTMLElement2 {
    let name: String
    let text: String?
    
    lazy var asHTML: () -> String = {
        [unowned self] in
        
        if let text = self.text {
            return "<\(self.name)>\(text)</\(self.name)>"
        } else {
            return "<\(self.name) />"
        }
    }
    
    init(name: String, text: String? = nil) {
        self.name = name
        self.text = text
    }
    
    deinit {
        print("\(name) is being deinitialized")
    }
}
    




//MARK:-MainController
class AutomaticReferenceCounting: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.white

        var reference1: ARCPerson?
        var reference2: ARCPerson?
        var reference3: ARCPerson?
     
        reference1 = ARCPerson(name: "John Appleseed")
        //由于Person类的新实例被赋值给了reference1变量，所以reference1到Person类的新实例之间建立了一个强引用。正是因为这一个强引用，ARC 会保证Person实例被保持在内存中不被销毁。
        
        
        reference2 = reference1
        reference3 = reference1//现在这一个Person实例已经有三个强引用了。
        
        
        reference2 = nil
        reference1 = nil//如果你通过给其中两个变量赋值nil的方式断开两个强引用（包括最先的那个强引用），只留下一个强引用，Person实例不会被销毁：
        
        print("----------------------")
        reference3 = nil//在你清楚地表明不再使用这个Person实例时，即第三个也就是最后一个强引用被断开时，ARC 会销毁它
        
        print("----------strong------------")
        var john: StrongReferencePerson?
        var unit4A: StrongReferenceApartment?
        john = StrongReferencePerson(name: "John Applessed")
        unit4A = StrongReferenceApartment(unit: "4A")
        
        john!.apartment = unit4A
        unit4A!.tenant = john//这两句导致循环引用
        
        print("----------------------")
        john = nil
        unit4A = nil//虽然手动设置为nil，由于循环引用，两者并不会被释放
     
        print("----------weak------------")
        var weakJohn: WeakReferencePerson?
        var weakUnit4A: WeakReferenceApartment?
        
        weakJohn = WeakReferencePerson(name: "John Appleseed")
        weakUnit4A = WeakReferenceApartment(unit: "4A")
        
        weakJohn!.apartment = weakUnit4A
        weakUnit4A!.tenant = weakJohn//这里面weakUnit4A的是弱引用了weakJohn，不会造成循环强引用，所以二者的析构函数会执行
        
        print("----------unowned------------")
        var taylor: Customer?
        taylor = Customer(name: "Taylor Swift")
        taylor?.card = CreditCard(number: 123_5678_0192_2335, customer: taylor!)
        
        taylor = nil//由于再也没有指向Customer实例的强引用，该实例被销毁了。其后，再也没有指向CreditCard实例的强引用，该实例也随之被销毁了
        
        /*
         可以将一个闭包赋值给asHTML属性，这个闭包能在text属性是nil时使用默认文本，这是为了避免返回一个空的 HTML 标签：
         */
        let heading = HTMLElement(name: "h1")
        let defaultText = "some default text"
        heading.asHTML = {
            return "<\(heading.name)>\(heading.text ?? defaultText)</\(heading.name)>"
        }
        print(heading.asHTML())
        
        /*
         HTMLElement类只提供了一个构造函数，通过name和text（如果有的话）参数来初始化一个新元素。该类也定义了一个析构函数，当HTMLElement实例被销毁时，打印一条消息。
         */
        var paragraph: HTMLElement? = HTMLElement(name: "p", text:"hello, world")
        print(paragraph!.asHTML)
        /*
         实例的asHTML属性持有闭包的强引用。但是，闭包在其闭包体内使用了self（引用了self.name和self.text），因此闭包捕获了self，这意味着闭包又反过来持有了HTMLElement实例的强引用。这样两个对象就产生了循环强引用。
         
         如果设置paragraph变量为nil，打破它持有的HTMLElement实例的强引用，HTMLElement实例和它的闭包都不会被销毁，也是因为循环强引用：
         */
        paragraph = nil//HTMLElement的析构函数中的消息并没有被打印，证明了HTMLElement实例并没有被销毁。
        
        var paragraph2: HTMLElement2? = HTMLElement2(name: "p(解决循环强引用的)", text:"hello, world")
        print(paragraph2!.asHTML)
        
        paragraph = nil//这一次，闭包以无主引用的形式捕获self，并不会持有HTMLElement实例的强引用。如果将paragraph赋值为nil，HTMLElement实例将会被销毁，并能看到它的析构函数打印出的消息：

        
    }
}

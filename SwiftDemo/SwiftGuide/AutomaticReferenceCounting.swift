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
        
    }
}

//
//  OptionalChaining.swift
//  SwiftDemo
//
//  Created by 李一平 on 2018/5/18.
//  Copyright © 2018年 情风. All rights reserved.
//

import UIKit
/*
 可选链式调用是一种可以在当前值可能为 nil 的可选值上请求和调用属性、方法及下标的方法。如果可选值有 值，那么调用就会成功;如果可选值是 nil ，那么调用将返回 nil 。多个调用可以连接在一起形成一个调用 链，如果其中任何一个节点为 nil ，整个调用链都会失败，即返回 nil 。
 */
class OptionalChaining: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.white
        
        let john = Personer()
        //如果使用叹号( ! )强制展开获得这个 john 的 residence 属性中的 numberOfRooms 值，会触发运行时错误，因为 这时 residence 没有可以展开的值:
//        let roomCount = john.residence!.numberOfRooms// 这会引发运行时错误(因为此时的residence为nil，不能强制解包)
        
        
        /*
         john.residence 为非 nil 值的时候，上面的调用会成功，并且把 roomCount 设置为 Int 类型的房间数量。正如上 面提到的，当 residence 为 nil 的时候上面这段代码会触发运行时错误。
         可选链式调用提供了另一种访问 numberOfRooms 的方式，使用问号( ? )来替代原来的叹号( ! ):
         */
        if let roomCount = john.residence?.numberOfRooms {
            print("John's residence has \(roomCount) room(s).")
        } else {
            print("Unable to retrieve the number of rooms.")
        }
        /*
         在residence后面加上问号之后，Swift会在residence不为nil的情况下访问numberOfRooms。
         因为访问numberOfRooms有可能失败，可选脸是调用会返回Int？类型，或称为“可选的Int”。如上所示，当 residence为nil的时候，可选的 Int 将会为 nil ，表明无法访问 numberOfRooms 。访问成功时，可选的Int 值会通过可选绑定展开，并赋值给非可选类型的 roomCount 常量。
         
         要注意的是，即使 numberOfRooms 是非可选的 Int 时，这一点也成立。只要使用可选链式调用就意味着numberOfRooms会返回一个 Int? 而不是 Int 。
         */
        john.residence = Residence()
        if let roomCount = john.residence?.numberOfRooms {
            print("John's residence has \(roomCount) room(s).")
        } else {
            print("Unable to retrieve the number of rooms.")
        }
        
        
        accessingPropertiesThroughOptionalChaining()
        callingMethodThroughOptionChaining()
        accessingSubscriptsThroughOptionalChaining()
        accessingSubscriptsOfOptionalType()
        linkingMultipleLevelOfChaining()
        chainingOnMethodsWithOptionalReturnValues()
    }
    
    //MARK:--通过可选链式调用访问属性
    func accessingPropertiesThroughOptionalChaining() {
        let john = Personer2()
        if let roomCount = john.residence?.numberOfRooms {
            print("John's residence has \(roomCount) room(s).")
        } else {
             print("Unable to retrieve the number of rooms.")
        }
        //因为 john.residence 为 nil ，所以这个可选链式调用依旧会像先前一样失败
        
        
        //还可以通过可选链式调用来设置属性值:
        let someAddress = Address()
        someAddress.buildingNumber = "29"
        someAddress.buildingName = "Acacia Road"
        john.residence?.address = someAddress//通过 john.residence 来设定 address 属性也会失败，因为 john.residence 当前为 nil 。
        
        john.residence?.address = createAddress()//没有任何打印消息，可以看出 createAddress() 函数并未被执行。
    }
    
    /*
     上面代码中的赋值过程是可选链式调用的一部分，这意味着可选链式调用失败时，等号右侧的代码不会被执 行。对于上面的代码来说，很难验证这一点，因为像这样赋值一个常量没有任何副作用。下面的代码完成了同样 的事情，但是它使用一个函数来创建 Address 实例，然后将该实例返回用于赋值。该函数会在返回前打印“Funct ion was called”，这使你能验证等号右侧的代码是否被执行。
     */
    func createAddress() -> Address {
        print("Func was called")
        
        let someAddress = Address()
        someAddress.buildingNumber = "29"
        someAddress.buildingName = "Acacia Road"
        
        return someAddress
    }
    
    
    //MARK:--通过可选链式调用调用方法
    func callingMethodThroughOptionChaining() {
        let john = Personer2()
        if john.residence?.printNumberOfRooms() != nil {
            print("It was possible to print the number of rooms.")
        } else {
             print("It was not possible to print the number of rooms.")
        }
        
        let someAddress = Address()
        someAddress.buildingNumber = "29"
        someAddress.buildingName = "Acacia Road"
        if (john.residence?.address = someAddress) != nil {
            print("It was possible to set the address.")
        } else {
            print("It was not possible to set the address.")
        }
    }
    
    //MARK:--使用可选链式调用访问下标
    func accessingSubscriptsThroughOptionalChaining() {
        let john = Personer2()
        
        if let firstRoomName = john.residence?[0].name {
            print("The first room name is \(firstRoomName).")
        } else {
            print("Unable to retrieve the first room name")
        }
        
        john.residence?[0] = Room(name: "Bathroom")
        
        let johnHouse = Residence2()
        johnHouse.rooms.append(Room(name: "Living Room"))
        johnHouse.rooms.append(Room(name: "Kitchen"))
        
        if let firstRoom = john.residence?[0].name {
            print("The forst room name is \(firstRoom).")
        } else {
            print("Unable to retrieve the first room name.")
        }
        
    }
    
    //MARK:--访问可选类型的下标
    /*
     如果下标返回可选类型值，比如 Swift 中 类型的键的下标，可以在下标的结尾括号后面放一个问号 来在其可选返回值上进行可选链式调用:
     */
    func accessingSubscriptsOfOptionalType() {
        var testScores = ["Dave": [86,82,84], "Bev": [79,89,90]]
        testScores["Dave"]?[0] = 99
        testScores["Bev"]?[0] += 1
        testScores["Briam"]?[0] = 72
        for (name, score) in testScores {
            print("name is \(name),score = \(score)")
        }
    }
    
    //MARK:--连接多层可选链式调用
    /*
     可以通过连接多个可选链式调用在更深的模型层级中访问属性、方法以及下标。然而，多层可选链式调用不会增加返回值的可选层级。
     
     也就是说:
     • 如果你访问的值不是可选的，可选链式调用将会返回可选值。
     • 如果你访问的值就是可选的，可选链式调用不会让可选返回值变得“更可选”。
     
     因此:
     • 通过可选链式调用访问一个 Int 值，将会返回 Int? ，无论使用了多少层可选链式调用。
     • 类似的，通过可选链式调用访问 Int? 值，依旧会返回 Int? 值，并不会返回 Int?? 。
     */
    func linkingMultipleLevelOfChaining() {
        let john = Personer2()
        if let johnsStreet = john.residence?.address?.street {
            print("John's street name is \(johnsStreet).")
        } else {
            print("Unable to retrieve the address.")
        }
        
        
        let johnsAddress = Address()
        johnsAddress.buildingName = "The Larches"
        johnsAddress.buildingNumber = "99"
        johnsAddress.street = "Laurel Street"
        john.residence?.address = johnsAddress
        
        if let johnsStreet = john.residence?.address?.street {
            print("John's street name is \(johnsStreet).")
        } else {
            print("Unable to retrieve the address.")
        }
    }
    
    //MARK:--在方法的可选返回值上进行可选链式调用
    func chainingOnMethodsWithOptionalReturnValues() {
        //下面的例子中，通过可选链式调用来调用 Address 的 buildingIdentifier() 方法。这个方法返回 String? 类型 的值。如上所述，通过可选链式调用来调用该方法，最终的返回值依旧会是 String? 类型:
        
        let john = Personer2()
        
        john.residence = Residence2()
        
        let johnsAddress = Address()
        johnsAddress.buildingName = "The Larches"
        johnsAddress.buildingNumber = "99"
        johnsAddress.street = "Laurel Street"
        john.residence?.address = johnsAddress
        
        if let buildingIdentifier = john.residence?.address?.buildingIdentifier() {
            print("John's building identifier is \(buildingIdentifier).")
        }
        
        if let beginsWithThe =
            john.residence?.address?.buildingIdentifier()?.hasPrefix("The") {
            if beginsWithThe {
                print("John's building identifier begins with \"The\".")
            } else {
                print("John's building identifier does not begin with \"The\".")
            }
            //在上面的例子中，在方法的圆括号后面加上问号是因为你要在 buildingIdentifier() 方法的可选返回值上进行 可选链式调用，而不是方法本身。
        }
    }
    
}

//MARK:--使用可选链式调用代替强制展开
/*
 通过在想调用的属性、方法、或下标的可选值后面放一个问号( ? )，可以定义一个可选链。这一点很像在可选 值后面放一个叹号( ! )来强制展开它的值。它们的主要区别在于当可选值为空时可选链式调用只会调用失败，然而强制展开将会触发运行时错误。
 
 为了反映可选链式调用可以在空值( nil )上调用的事实，不论这个调用的属性、方法及下标返回的值是不是可 选值，它的返回结果都是一个可选值。你可以利用这个返回值来判断你的可选链式调用是否调用成功，如果调用 有返回值则说明调用成功，返回 nil 则说明调用失败。
 
 特别地，可选链式调用的返回结果与原本的返回结果具有相同的类型，但是被包装成了一个可选值。例如，使用 可选链式调用访问属性，当可选链式调用成功时，如果属性原本的返回结果是 Int 类型，则会变为 Int? 类型。
 */
class Personer {
    var residence: Residence?
}

class Residence {
    var numberOfRooms = 1
}


//MARK:--为可选链式调用定义模型类
class Personer2 {
    var residence: Residence2?
}

class Residence2 {
    var rooms = [Room]()
    var numberOfRooms: Int {
        return rooms.count
    }
    
    subscript(i: Int) -> Room {
        get {
            return rooms[i]
        }
        set {
            rooms[i] = newValue
        }
    }
    
    func printNumberOfRooms() {
        print("The number of rooms is \(numberOfRooms)")
    }
    var address: Address?
    
}

class Room {
    var name: String
    init(name: String) {
        self.name = name
    }
}

class Address {
    var buildingName: String?
    var buildingNumber: String?
    var street: String?
    func buildingIdentifier() -> String? {
        if let buildingNumber = buildingNumber, let street = street {
            return "\(buildingNumber) \(street)"
        } else if buildingName != nil {
            return buildingName
        } else {
            return nil
        }
    }
}

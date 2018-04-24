//
//  CollectionTypes.swift
//  SwiftDemo
//
//  Created by liyiping on 2018/4/24.
//  Copyright © 2018年 情风. All rights reserved.
//

import UIKit

class CollectionTypes: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.white
        
        mutabilityOfCollections()
        creatingAnEmptyArray()
        creatingAnArrayWithDefaultValue()
        creatingAnArrayByAddingTwoArraysTogether()
        creatingAnArrayWithAnArrayLiteral()
        accessingAndModifyingAnArray()
        
        creatingAndInitializingAnEmptySet()
        creatingSetWithArrayLiteral()
        accessingAndModifyingAnSet()
        
        creatingAnEmptyDictionary()
        creatingDictionaryWithDictionaryLiteral()
        accessingAndModifyingAnDictionary()
        
    }

    //MARK:--Array
    /// 集合的可变性
    func mutabilityOfCollections() {
       /*
         如果创建一个 Arrays 、 Sets 或 Dictionaries 并且把它分配成一个变量，这个 合将会是可变的。这意味着我们 可以在创建之后添加更多或移除已存在的数据项，或者改变 合中的数据项。如果我们把 Arrays 、 Sets 或 ionaries 分配成常量，那么它就是不可变的，它的大小和内容都不能被改变。
         注意:
         在我们不需要改变 合的时候创建不可变 合是很好的实践。如此 Swift 编译器可以优化我们创建的 合。
         */
        
    }
    
    func creatingAnEmptyArray() {
        var someInts = [Int]()
        print("someInts is of type [Int] with \(someInts.count) items.")
        /*
         注意，通过构造函数的类型， someInts 的值类型被推断为 [Int] 。
         或者，如果代码上下文中已经提供了类型信息，例如一个函数参数或者一个已经定义好类型的常量或者变量，我 们可以使用空数组语句创建一个空数组，它的写法很简单: [] (一对空方括号):
         */
        someInts.append(3)// someInts 现在包含一个 Int 值
        someInts = []// someInts 现在是空数组，但是仍然是 [Int] 类型的。
    }
    
    /// 创建一个带有默认值的数组
    func creatingAnArrayWithDefaultValue() {
        let threeDoubles = Array(repeatElement(0.0, count: 3))
        print(threeDoubles)
    }
    
    
    /// 通过两个数组相加创建一个数组
    func creatingAnArrayByAddingTwoArraysTogether() {
        let threeDoubles = Array(repeatElement(0.0, count: 3))
        let otherThreeDoubles = Array(repeatElement(3.0, count: 2))
        let sixDoubles = threeDoubles + otherThreeDoubles
        print(sixDoubles)
        
    }
    
    /// 通过字面量创建数组
    func creatingAnArrayWithAnArrayLiteral() {
        let shoppingList: [String] = ["Milk","Eggs"]
        let shopList = ["Milk","Eggs"]
        print(shopList,shoppingList)
        /*
         因为所有数组字面量中的值都是相同的类型，Swift 可以推断出 [String] 是 shoppingList 中变量的正确类型。
         */
        
    }
    
    
    /// 访问和修改数组
    func accessingAndModifyingAnArray() {
        var shoppingList: [String] = ["Milk","Eggs"]
        print("The shopping list contains \(shoppingList.count) items.")
        
        //使用布尔属性 isEmpty 作为一个缩写形式去检查 count 属性是否为 0 :
        if shoppingList.isEmpty {
            print("The shopping list is empty.")
        } else {
            print("The shopping list is not empty.")
        }
        
        //使用 append(_:) 方法在数组后面添加新的数据项:
        shoppingList.append("Flour")
        
        //使用加法赋值运算符( += )也可以直接在数组后面添加一个或多个拥有相同类型的数据项
        shoppingList += ["Baking Powder"]//此时的+=需要用“[]”
        shoppingList += ["Chocolate Spread", "Cheese", "Butter"]//追加多个
        
        //直接使用下标语法来获取数组中的数据项，把我们需要的数据项的索引值放在直接放在数组名称的方括号中:
        var firstItem = shoppingList[0]//第一项在数组中的索引值是 0 而不是 1 。 Swift 中的数组索引总是从零开始。
        print(firstItem)
        
        //用下标来改变某个已有索引值对应的数据值:
        shoppingList[0] = "Six eggs"
        
        //还可以利用下标来一次改变一系列数据值，即使新数据和原有数据的数量是不一样的。下面的例子把 "Chocolate Spread" ， "Cheese" ，和 "Butter" 替换为 "Bananas" 和 "Apples" :
        shoppingList[4...6] = ["Bananas", "Apples"]
        /*
         care:不可以用下标访问的形式去在数组尾部添加新项。
         */
        
        //调用数组的 insert(_:at:) 方法来在某个具体索引值之前添加数据项:
        shoppingList.insert("Maple Syrup", at: 0)
        
        //可以使用 remove(at:) 方法来移除数组中的某一项。这个方法把数组在特定索引值中存储的数据项移 除并且返回这个被移除的数据项(我们不需要的时候就可以无视它):
        shoppingList.remove(at: 0)
        
        //如果我们只想把数组中的最后一项移除，可以使用 removeLast() 方法而不是 remove(at:) 方法来避免我们需要获 取数组的 count 属性
        shoppingList.removeLast()
        
        //数组的遍历
        for item in shoppingList {
            print(item)
        }
        
        //如果我们同时需要每个数据项的值和索引值，可以使用 enumerated() 方法来进行数组遍历。 enumerated() 返回 一个由每一个数据项索引值和数据值组成的元组。我们可以把这个元组分解成临时常量或者变量来进行遍历:
        for (index, value) in shoppingList.enumerated() {
             print("Item \(String(index)): \(value)")
        }
        
    }

    //MARK:--Set
    
    /// 创建和初始化空集合
    func creatingAndInitializingAnEmptySet() {
        var letters = Set<Character>()
        print("letters is of type Set<Character> with \(letters.count) items.")
        //如果上下文提供了类型信息，比如作为函数的参数或者已知类型的变量或常量，我们可以通过一个空的数 组字面量创建一个空的 Set :
        letters.insert("a")// letters 现在含有1个 Character 类型的值
        letters = []// letters 现在是一个空的 Set, 但是它依然是 Set<Character> 类型
    }
    
    
    /// 用数组字面量创建集合
    func creatingSetWithArrayLiteral() {
        //你可以使用数组字面量来构造 合，并且可以使用简化形式写一个或者多个值作为 合元素
        var favoriteGenre: Set<String> = ["Rock", "Classical", "Hip hop"] // favoriteGenres 被构造成含有三个初始值的集合
        
        //一个 Set 类型不能从数组字面量中被单独推断出来，因此 Set 类型必须显式声明。然而，由于 Swift 的类型推 断功能，如果你想使用一个数组字面量构造一个 Set 并且该数组字面量中的所有元素类型相同，那么你无须写出Set 的具体类型。 favoriteGenres 的构造形式可以采用简化的方式代替:
        var favoriteGenres: Set = ["Rock", "Classical", "Hip hop"]
    }
    
    
    func accessingAndModifyingAnSet() {
        var favoriteGenre: Set<String> = ["Rock", "Classical", "Hip hop"]
        var favoriteGenres: Set = ["Rock", "Classical", "Hip hop"]
        //访问和修改一个集合
        //为了找出一个 Set 中元素的数量，可以使用其只读属性 count :
        print("I have \(favoriteGenres.count) favorite music genres.")
        
        //使用布尔属性 isEmpty 作为一个缩写形式去检查 count 属性是否为 0
        if favoriteGenre.isEmpty {
            print("As far as music goes, I'm not picky.")
        } else {
            print("I have particular music preferences.")
        }
        
        //通过调用 Set 的 insert(_:) 方法来添加一个新元素:
        favoriteGenres.insert("Jazz")
        
        //你可以通过调用 Set 的 remove(_:) 方法去删除一个元素，如果该值是该 Set 的一个元素则删除该元素并且返回 被删除的元素值，否则如果该 Set 不包含该值，则返回 nil 。另外， Set 中的所有元素可以通过它的 removeAl l() 方法删除。
        if let removedGenre = favoriteGenres.remove("Rock") {
            print("\(removedGenre)? I'm over it.")
        } else {
            print("I never much cared for that.")
        }
        
        favoriteGenre.removeAll()
        print(favoriteGenres,favoriteGenre)
        
        //使用 contains(_:) 方法去检查 Set 中是否包含一个特定的值:
        if favoriteGenres.contains("Rock") {
            print("I get up on the good foot.")
        } else {
            print("It's too funky in here.")
        }
        
        //遍历一个集合
        for genre in favoriteGenres {
            print(genre)
        }
        
        //遍历一组的值在一个特定的顺序,使用排序()方法,它返回的元素设置为一个数组
        for genre in favoriteGenres.sorted() {
            print(genre)
        }
        
        //执行集合操作
        /*
         • 使用 intersection(_:) 方法根据两个 合中都包含的值创建的一个新的 合。
         • 使用 symmetricDifference(_:) 方法根据在一个 合中但不在两个 合中的值创建一个新的 合。
         • 使用 union(_:) 方法根据两个 合的值创建一个新的 合。
         • 使用 subtracting(_:) 方法根据不在该 合中的值创建一个新的 合。
         */
        let oddDigits: Set = [1, 3, 5, 7, 9]
        let evenDigits: Set = [0, 2, 4, 6, 8]
        let singleDigitPrimeNumbers: Set = [2, 3, 5, 7]
        
        print(oddDigits.union(evenDigits).sorted())// [0, 1, 2, 3, 4, 5, 6, 7, 8, 9]
        print(oddDigits.intersection(evenDigits).sorted())// []
        print(oddDigits.subtracting(singleDigitPrimeNumbers).sorted())// [1, 9]
        print(oddDigits.symmetricDifference(singleDigitPrimeNumbers).sorted())// [1, 2, 9]
        
        //成员关系和相等性
        /*
         • 使用“是否相等”运算符( == )来判断两个 合是否包含全部相同的值。
         • 使用 isSubset(of:) 方法来判断一个 合中的值是否也被包含在另外一个 合中。
         • 使用 isSuperset(of:) 方法来判断一个 合中包含另一个 合中所有的值。
         • 使用 isStrictSubset(of:) 或者 isStrictSuperset(of:) 方法来判断一个 合是否是另外一个 合的子 合或 者父 合并且两个 合并不相等。
         • 使用 isDisjoint(with:) 方法来判断两个 合是否不含有相同的值(是否没有交 )。
         */
        let houseAnimals: Set = ["🐶", "🐱"]
        let farmAnimals: Set = ["🐮", "🐔", "🐑", "🐶", "🐱"]
        let cityAnimals: Set = ["🐦", "🐭"]
        
        
        print(houseAnimals.isSubset(of: farmAnimals))// true
        print(farmAnimals.isSuperset(of: houseAnimals))// true
        print(farmAnimals.isDisjoint(with: cityAnimals))// true
    }
    
    //MARK:--Dictionary
    func creatingAnEmptyDictionary() {
        var namesOfIntegers = [Int: String]()// namesOfIntegers 是一个空的 [Int: String] 字典
        namesOfIntegers[16] = "sixteen" // namesOfIntegers 现在包含一个键值对
        namesOfIntegers = [:] // namesOfIntegers 又成为了一个 [Int: String] 类型的空字典
    }
    
    func creatingDictionaryWithDictionaryLiteral() {
        var airport: [String: String] = ["成都":"双流机场","北京":"首都机场"]
        var airports = ["成都":"双流机场","北京":"首都机场"]
        print(airport,airports)
    }
    
    
    /// 访问和修改字典
    func accessingAndModifyingAnDictionary() {
        var airports = ["YYZ": "Toronto Pearson", "DUB": "Dublin"]
        
        print("The airports dictionary contains \(airports.count) items.")
        
        //使用布尔属性 isEmpty 作为一个缩写形式去检查 count 属性是否为 0 :
        if airports.isEmpty {
            print("The airports dictionary is empty.")
        } else {
            print("The airports dictionary is not empty.")
        }
        
        //我们也可以在字典中使用下标语法来添加新的数据项。可以使用一个恰当类型的键作为下标索引，并且分配恰当类型的新值:
        airports["LHR"] = "London"
        
        //我们也可以使用下标语法来改变特定键对应的值:
        airports["LHR"] = "London Heathrow"
        
        //updateValue(_:forKey:) 方法会返回对应值的类型的可选值。举例来说:对于存储 String 值的字典，这个函数会 返回一个 String? 或者“可选 String ”类型的值。
        if let oldValue = airports.updateValue("Dublin Airport", forKey: "DUB") {
            print("The old value for DUB was \(oldValue).")
        }
        
        //我们也可以使用下标语法来在字典中检索特定键对应的值。因为有可能请求的键没有对应的值存在，字典的下标 访问会返回对应值的类型的可选值。如果这个字典包含请求键所对应的值，下标会返回一个包含这个存在值的可 选值，否则将返回 nil :
        if let airportName = airports["DUB"] {
            print("The name of the airport is (airportName).")
        } else {
            print("That airport is not in the airports dictionary.")
        }
        
        //可以使用下标语法来通过给某个键的对应值赋值为 nil 来从字典里移除一个键值对:
        airports["APL"] = "Apple Internation"
        // "Apple Internation" 不是真的 APL 机场, 删除它
        airports["APL"] = nil
        // APL 现在被移除了
        
        //removeValue(forKey:) 方法也可以用来在字典中移除键值对。这个方法在键值对存在的情况下会移除该键 值对并且返回被移除的值或者在没有值的情况下返回 nil :
        if let removedValue = airports.removeValue(forKey: "DUB") {
            print("The removed airport's name is (removedValue).")
        } else {
            print("The airports dictionary does not contain a value for DUB.")
        }
        // prints "The removed airport's name is Dublin Airport."
        
        //字典遍历
        for (airportCode, airportName) in airports {
            print("(airportName): \(airportName)")
        }
        
        //通过访问key或者value属性，我们也可以遍历字典的键或者值:
        for airportCode in airports.keys {
            print("Airport code: \(airportCode)")
        }
        // Airport code: YYZ
        // Airport code: LHR
        
        for airportName in airports.values {
            print("Airport name: \(airportName)")
        }
        // Airport name: Toronto Pearson
        // Airport name: London Heathrow
        
        //如果我们只是需要使用某个字典的键 合或者值 合来作为某个接受   实例的 API 的参数，可以直接使用 key 或者   value属性构造一个新数组
        let airportCodes = [String](airports.keys)
        // airportCodes 是 ["YYZ", "LHR"]
        let airportNames = [String](airports.values)
        // airportNames 是 ["Toronto Pearson", "London Heathrow"]
    }
    
}

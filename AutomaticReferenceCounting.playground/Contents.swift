/* Automatic Reference Counting (ARC)
 Reference Counting applies only to the instances of the Class because it is Reference Type. This means that multiple objects can refer to the same object. Where as Structures and Enumerations are Value Types.
*/
/*
 class Employee {
    let empName: String
    
    init(employeeName empName: String) {
        self.empName = empName
        print("\(empName) is being initialized")
    }
    deinit {
            print("\(empName) is being deinitialized")
    }
}
var emp1: Employee?
var emp2: Employee?
var emp3: Employee?

emp1 =  Employee(employeeName: "John Appleseed")

emp2 = emp1
emp3 = emp1

emp1 = nil
emp2 = nil

emp3 =  nil
*/
/*
//What are Reference Cycles?
class Employee {
    let empName: String
    var dept: Department?
    
    init(employeeName empName: String) {
        self.empName = empName
        print("\(empName) is being initialized")
    }
    
    deinit {
        print("\(empName) is being deinitialized")
    }
}
//class Department {
//    let deptName: String
//    weak var emp: Employee?
//
//    init(departmentName deptName: String) {
//        self.deptName = deptName
//        print("\(deptName) is being initialized")
//    }
//
//    deinit {
//        print("\(deptName) is being deinitialized")
//    }
//
//}
class Department {
    let deptName: String
    weak var emp: Employee?
    init(departmentName deptName: String) {
        self.deptName = deptName
        print("\(deptName) is being initialized")
    }
    
    deinit {
        print("\(deptName) is being deinitialized")
    }
}
var john: Employee? = Employee(employeeName: "john")
var iOS: Department? = Department(departmentName: "iOS")


john!.dept = iOS
iOS!.emp = john

john!.dept = nil
iOS = nil


//iOS!.emp already nil

// *********
//Unowned Reference

class Owner {
    let ownerName: String
    var vehicle: Vehicle?
    
    init(ownerName name: String) {
        self.ownerName = name
        print("\(ownerName) is being initialized")
    }
    deinit {
        print("\(ownerName) is being deinitialized")
    }
}
class Vehicle {
    let vehicleNumber: String
    unowned let owner: Owner
    init(vehicleNumber number: String, owner: Owner) {
        self.vehicleNumber = number
        self.owner = owner
        print("\(vehicleNumber) is being initialized")
    }
    deinit {
        print("\(vehicleNumber) is being deinitialized")
    }
}
var appleseed: Owner?
appleseed = Owner(ownerName: "John Appleseed")
appleseed?.vehicle = Vehicle(vehicleNumber: "TE 12 MP 5678", owner: appleseed!)

appleseed = nil
 */
class Country {
    let countryName: String
    var countryPresident: President!
    init(countryName: String, presidentName: String) {
        self.countryName = countryName
        self.countryPresident = President(presidentName: presidentName, country: self)
        print("Country is being initialised")
    }
    deinit {
        print("Country is being de-initialised")
    }
}
class President {
    let presidentName: String
    unowned let country: Country
    
    init(presidentName: String, country: Country) {
        self.presidentName = presidentName
        self.country = country
        print("President is being initialised")
    }
    deinit {
        print("President is being de-initialised")
    }
}


var country:Country? = Country(countryName: "India", presidentName: "Ram Nath Kovind")

country = nil
print("************")

//Strong Reference Cycle in Closures
//class Person {
//    var firstName: String?
//    var lastName: String?
//    lazy var fullName: ()->String = {
//        return ("\(self.firstName!) \(self.lastName!)")
//    }
//    init(firstName: String, lastName: String) {
//        self.firstName = firstName
//        self.lastName = lastName
//        print("Person Class is being initialised")
//    }
//    deinit {
//        print("Person Class is being de-initialised")
//    }
//}
//var person: Person? = Person(firstName: "Rahul", lastName: "Singh")
//
//print(person!.fullName())
//
//person = nil //did not deinitialize
//
////How to resolve the Strong Reference between Class and Closure?
//print("************")


class Person {
    var firstName: String?
    var lastName: String?
    
    lazy var fullName: ()-> String = {[unowned self] in
        return ("\(self.firstName!) \(self.lastName!)")
    }
    init(firstName: String, lastName: String) {
        self.firstName = firstName
        self.lastName = lastName
        print("Person Class is being initialised")
    }
    deinit {
        print("Person Class is being de-initialised")
    }
}
var person: Person? = Person(firstName: "Rahul", lastName: "Singh")
// Prints "Person Class is being initialised"
print(person!.fullName())


person = nil




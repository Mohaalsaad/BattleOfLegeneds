// 1. Define the `Item` protocol with the following requirements:
// - `name` property of type `String`
// - `description` property of type `String`
//
//


protocol Item {
  var name: String { get }
  var description: String { get }
}

// 2. Define the `Chest` struct with the following requirements:
// - `items` property of type `Array<Item>`

struct Chest {
  var items: Array<Item> = []
}

// 3. Define the `Player` protocol which confirm to `AnyObject` protocol and with the following requirements:
// - `name` property of type `String`
// - `health` property of type `Int`
// - `attack<P: Player>(_ player: P)` function
// - `splash<P: Player>(_ player: P)` function
// - `heal()` function

protocol Player: AnyObject {
  var name: String { get }
  var health: Int { get set }
  var chest: Chest { get set }

  // use random `Weapon` from chest against `player`
  // this function should decrease player health by effectPoints
  func attack<P: Player>(_ player: P)

  // use random `PoisonPotion` from chest  against `player`
  // this function should decrease player health by effectPoints
  func splash<P: Player>(_ player: P)

  // use random `HealthPotion` from chest  to `self`
  // this function should increase self health by effectPoints
  func heal()
}

// 4. Define the `Weapon` protocol which confirm to `Item` protocol and with the following requirements:
// - `effectPoints` property of type `Int`
// - `attack<P: Player>(_ player: P)` function
// this function should decrease player health by effectPoints


protocol Weapon: Item{
    var effectPoints: Int { get set }
    func attack<P: Player>(_ player: P)
}

// 5. Define the `Potion` protocol which confirm to `Item` protocol and with the following requirements:
// - `effectPoints` property of type `Int`
// - `splash<P: Player>(_ player: P)` function
// this function should decrease player health by effectPoints

protocol Potion: Item{
    var effectPoints: Int { get set }
    func splash<P: Player>(_ player: P)
}



// 6. Define the `Sword` struct which confirm to `Weapon` protocol
// - the `effectPoints` should be 10

struct Sword: Weapon {
    var name: String
    var description: String
    var effectPoints: Int

    func attack<P: Player>(_ player: P) {
        if player.health > effectPoints {
            print("Attacking \(player.name) with \(name)!")
            player.health -= effectPoints
            print("\(player.name)'s health is now \(player.health).")
        } else{
            print("you can not play!! your health less than effectPoints! ")
        }
    }
}



// 7. Define the `Axe` struct which confirm to `Weapon` protocol
// - the `effectPoints` should be 20

struct Axe: Weapon {
    var name: String
    var description: String
    var effectPoints: Int

    func attack<P: Player>(_ player: P) {
        if player.health > effectPoints {
            print("Attacking \(player.name) with \(name)!")
            player.health -= effectPoints
            print("\(player.name)'s health is now \(player.health).")
        } else{
            print("you can not play!! your health less than effectPoints! ")
        }
    }
}



// 8. Define the `Knife` struct which confirm to `Weapon` protocol
// - the `effectPoints` should be 5

struct Knife: Weapon {
    var name: String
    var description: String
    var effectPoints: Int

    func attack<P: Player>(_ player: P) {
        if player.health > effectPoints {
            print("Attacking \(player.name) with \(name)!")
            player.health -= effectPoints
            print("\(player.name)'s health is now \(player.health).")
        } else{
            print("you can not play!! your health less than effectPoints! ")
        }
    }
}


// 9. Define the `Wand` struct which confirm to `Weapon` protocol
// - the `effectPoints` should be 30
struct Wand: Weapon {
    var name: String
    var description: String
    var effectPoints: Int

    func attack<P: Player>(_ player: P) {
        if player.health > effectPoints {
            print("Attacking \(player.name) with \(name)!")
            player.health -= effectPoints
            print("\(player.name)'s health is now \(player.health).")
        } else{
            print("you can not play!! your health less than effectPoints! ")
        }
    }
}




// 10. Define the `HealthPotion` struct which confirm to `Potion` protocol
// - the `effectPoints` should be 20

struct HealthPotion: Potion {
    var name: String
    var description: String
    var effectPoints: Int

    func splash<P: Player>(_ player: P) {
        if player.health > effectPoints {
            print("Give \(player.name) a \(name)!")
            player.health += effectPoints
            print("\(player.name)'s health is now \(player.health).")
        } else{
            print("you can not play!! your health is \(player.health), less than effectPoints! ")
        }
    }
}



// 11. Define the `PoisonPotion` struct which confirm to `Potion` protocol
// - the `effectPoints` should be 20

struct PoisonPotion: Potion {
    var name: String
    var description: String
    var effectPoints: Int

    func splash<P: Player>(_ player: P) {
        if player.health > effectPoints {
            print("Attacking \(player.name) with \(name)!")
            player.health -= effectPoints
            print("\(player.name)'s health is now \(player.health).")
        } else{
            print("you can not play!! your health is \(player.health), less than effectPoints! ")
        }
    }
}





// 12. Define the `Warrior` class which confirm to `Player` protocol
// - the `health` should be 100

class Warrior: Player {
    var name: String
    var health: Int
    var chest: Chest = Chest()

    init(name: String, health: Int = 100, chest: Chest = Chest()) {
        self.name = name
        self.health = health
        self.chest = chest
    }

    func attack<P: Player>(_ player: P) {
        for item in chest.items where item is Weapon{
            if let weapon = item as? Weapon {
                print("Attacking \(player.name) with \(weapon.name)!")
                player.health -= weapon.effectPoints
                print("\(player.name)'s health is now \(player.health).")
            }
        }
    }

    func splash<P: Player>(_ player: P) {
        for item in chest.items where item is PoisonPotion {
            if let potion = item as? Potion {
                print("Splashing \(potion.name) on \(player.name)!")
                player.health -= potion.effectPoints
                print("\(player.name)'s health is now \(player.health).")
            }
        }
    }

    func heal() {
        for item in chest.items where item is HealthPotion {
            if let healthPotion = item as? HealthPotion {
                healthPotion.splash(self)
            }
        }
    }

//     func randomWeapon() -> Weapon? {
//        let weapons = chest.items.compactMap { $0 as? Weapon }
//        return weapons.randomElement()
//    }

}


// 13. Define the `Wizard` class which confirm to `Player` protocol
// - the `health` should be 100

class Wizard: Player {
    var name: String
    var health: Int
    var chest: Chest

    init(name: String, health: Int = 100, chest: Chest = Chest()) {
        self.name = name
        self.health = health
        self.chest = chest
    }

    func attack<P: Player>(_ player: P) {
        for item in chest.items where item is Weapon {
            if let weapon = item as? Weapon {
                weapon.attack(player)
            }
        }
    }

    func splash<P: Player>(_ player: P) {
        for item in chest.items where item is PoisonPotion {
            if let potion = item as? Potion {
                potion.splash(player)
            }
        }
    }

    func heal() {
        for item in chest.items where item is HealthPotion {
            if let healthPotion = item as? HealthPotion {
                healthPotion.splash(self)
            }
        }
    }

//     func randomWeapon() -> Weapon? {
//        let weapons = chest.items.compactMap { $0 as? Weapon }
//        return weapons.randomElement()
//    }

}

// use the following code to demonstrate the usage of your solution:
let warrior = Warrior(name: "Creeper")
let wizard = Wizard(name: "villager")

warrior.chest.items.append(Axe(name: "Axe", description: "A heavy axe", effectPoints: 100))
//warrior.chest.items.append(PoisonPotion(name: "Poison Potion", description: "Poison description", effectPoints: 15))
warrior.chest.items.append(HealthPotion(name: "Health Potion", description: "Health description" , effectPoints: 30))

// Add items to Wizard's chest
wizard.chest.items.append(Wand(name: "Wand", description: "Wand description", effectPoints: 30))
wizard.chest.items.append(HealthPotion(name: "Health Potion", description: "Health description" , effectPoints: 20))
//wizard.chest.items.append(PoisonPotion(name: "Poison Potion", description: "Poison description", effectPoints: 15))

// Simulating a battle
print("Initial Health - Warrior: \(warrior.health), Wizard: \(wizard.health)")
warrior.attack(wizard)

warrior.attack(wizard)
wizard.splash(warrior)
wizard.heal()

//wizard.heal()
if wizard.health == warrior.health{
    print("Gg 🥹 , no one wine the battle \nwizard health: \( wizard.health) \nwarrior health: \(warrior.health).")
} else if warrior.health > wizard.health{
    print("Congratulation 🫡 , The Warrior wine the battle \nwizard health: \( wizard.health) \nwarrior health: \(warrior.health)")
}else{
    print("Congratulation 🫡 , The Wizard wine the battle \nwizard health: \(wizard.health) \nwarrior health: \(warrior.health)")
}

// Brinly Xavier
//  main.swift
//  Project 02
// 2316142
// xavier@chapman.edu

import Foundation

class Project{
    init()
    {
        var reply = ""
        var keepRunning = true
        var dict = [String: String]()


        print("Would you like to View all password names(1),View a single password(2), Delete a password(3), or Add a password(4)")
        var optioninput = readLine()
        //this keeps the program looping
        while keepRunning{
            //option to view all keys
            if optioninput == "1" {
                for key in dict.keys {
                    print("\(key)")
                }
                //asking to loop the program
                reply = Mainmenu.Option(menuText:"Do you want to keep running the app?", acceptableReplies: ["no", "yes"])
                if reply == "no"
                {
                    keepRunning = false
                }
                else if reply == "yes"
                {
                    print("Would you like to View all password names(1),View a single password(2), Delete a password(3) or Add a password(4)")
                    optioninput = readLine()
                    continue
                }
                //option to print out a single key and password
            } else if optioninput == "2" {
                print("Enter the key of the password you would like to view: ")
                let keyval = readLine()
                if dict.keys.contains(keyval!){
                    print("enter the passphrase")
                    let passreveal = dict[keyval!]
                    let str2 = String(passreveal!)
                    var strShift2 = ""
                    let shift2 = str2.count
                    print("Please enter the passphrase: ")
                    let passphrase2 = readLine()
                    print(passphrase2!)
                    func untranslate(first: Character, trans: Int) -> Character
                    {
                        if let ascii = first.asciiValue
                        {
                            var outputInt = ascii
                            if ascii >= 97 && ascii <= 122
                            {
                                outputInt = ((ascii+97-UInt8(trans))*26)-97
                            }
                            else if (ascii >= 65 && ascii <= 90)
                            {
                                outputInt = ((ascii+65-UInt8(trans))*26)-65
                            }
                            
                            return Character(UnicodeScalar(outputInt))
                        }
                        return Character("")
                    }
                    for letter in str2 {
                        strShift2 += String(untranslate(first: letter, trans: shift2))
                    }
                    print("Here is the password: \(strShift2)")
                }
                else {
                    print("That does not exist")
                }
                reply = Mainmenu.Option(menuText:"Do you want to keep running the app?", acceptableReplies: ["no", "yes"])
                if reply == "no"
                {
                    keepRunning = false
                }
                else if reply == "yes"
                {
                    print("Would you like to View all password names(1),View a single password(2), Delete a password(3) or Add a password(4)")
                    optioninput = readLine()
                    continue
                }
                //option to delete a password
            } else if optioninput == "3" {
                print("Enter the key of the password you would like to delete: ")
                let keyval = readLine()
                if dict.keys.contains(keyval!){
                    dict.removeValue(forKey: keyval!)
                    print("Password is deleted")
                } else {
                    print("That does not exist")
                }
                reply = Mainmenu.Option(menuText:"Do you want to keep running the app?", acceptableReplies: ["no", "yes"])
                if reply == "no"
                {
                    keepRunning = false
                }
                else if reply == "yes"
                {
                    print("Would you like to View all password names(1),View a single password(2), Delete a password(3) or Add a password(4)")
                    optioninput = readLine()
                    continue
                }
                //option to store a password
            } else if optioninput == "4"{
                print("Please enter username: ")
                let keyinput = readLine()
                print("Please enter password: ")
                let passinput = readLine()
                let str = String(passinput!)
                var strShift = ""
                let shift = str.count
                print("Please enter the passphrase: ")
                let passphrase = readLine()
                print(passphrase!)
                
                //scrambling the password
                func translate(first: Character, trans: Int) -> Character
                {
                    if let ascii = first.asciiValue
                    {
                        var outputInt = ascii
                        if ascii >= 97 && ascii <= 122
                        {
                            outputInt = ((ascii-97+UInt8(trans))%26)+97
                        }
                        else if (ascii >= 65 && ascii <= 90)
                        {
                            outputInt = ((ascii-65+UInt8(trans))%26)+65
                        }
                        
                        return Character(UnicodeScalar(outputInt))
                    }
                    return Character("")
                }
                for letter in str {
                    strShift += String(translate(first: letter, trans: shift))
                }
                //storing the scrambled input into the dictionary
                dict[keyinput!] = strShift
                
                reply = Mainmenu.Option(menuText:"Do you want to keep running the app?", acceptableReplies: ["no", "yes"])
                if reply == "no"
                {
                    keepRunning = false
                }
                else if reply == "yes"
                {
                    print("Would you like to View all password names(1),View a single password(2), Delete a password(3) or Add a password(4)")
                    optioninput = readLine()
                    continue
                }
            }
        }
        //storing the dictionary in a json file
        do{
            let fileURL = try FileManager.default
                .url(for: .applicationSupportDirectory, in:
                        .userDomainMask,
                     appropriateFor: nil,
                     create: true)
                .appendingPathComponent("allmypasswords.json")
                
            try JSONSerialization.data(withJSONObject:dict).write(to: fileURL)
        } catch{
            print(error)
        }
        print("goodbye!")
    }
}
let p = Project()


//this goes through the motion of looping the program and handling invalid user input
class Mainmenu
{
    static func Option(menuText output:
        String, acceptableReplies inputArr:
        [String], caseSensitive: Bool = false) ->
        String
    {
        print(output)
        
        guard let response = readLine() else {
            print("Invalid input")
            return Option(menuText: output,
                acceptableReplies: inputArr)
        }
        
        if (inputArr.contains(response) ||
                inputArr.isEmpty)
        {
            return response
        }
        else{
            print("Invalid input")
            return Option(menuText: output,
                acceptableReplies: inputArr)
        }
        
    }
}

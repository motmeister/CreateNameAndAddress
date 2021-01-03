//
//  ViewController.swift
//  CreateNameAndAddress
//
//  Created by Dennis Schaefer on 12/29/20.
//

import Cocoa
// a change at github.com


class ViewController: NSViewController {
    public var saveFilepath = ""

    public class nameAndAddress {
        var firstName:String = ""
        var middleName:String = ""
        var lastName:String = ""
        var streetAddress:String = ""
        var citySTZip:String = ""
        var homePhone:String = ""
        var mobilePhone:String = ""
        
        init() {
            firstName = ""
            middleName = ""
            lastName = ""
            streetAddress = ""
            citySTZip = ""
            homePhone = ""
            mobilePhone = ""
        }
        
        // clear may be unnecessary
        func clear() {
            firstName = ""
            middleName = ""
            lastName = ""
            streetAddress = ""
            citySTZip = ""
            homePhone = ""
            mobilePhone = ""
        }
        func phoneFix() {
            return
        }
        func nameCombine() {
            return
        }
        func textEntry() {
        }
    }

    public var personRecord = nameAndAddress()
    public var myFixedText:String = ""
    
    @IBOutlet var textBox: NSTextView!
    @IBOutlet weak var filenameBox: NSTextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        textBox.font = NSFont(name: "Arial Bold", size: 13)
        // Do any additional setup after loading the view.
    }

    override var representedObject: Any? {
        didSet {
        // Update the view, if already loaded.
        }
    }

    @IBAction func fileButton(_ sender: Any) {
        
        print("openDocument ViewController")

        
        var xfileName:String = filenameBox.stringValue
        print(xfileName)
        if xfileName == "" {
            print("no text?")
            let myAlert = NSAlert()
            myAlert.window.title = "Missing File Name"
            myAlert.messageText = "You must enter a File name!"
            myAlert.addButton(withTitle:"OK")
            myAlert.runModal()
        } else {
            xfileName = xfileName + ".txt"
            if let url = NSOpenPanel().getDirectory {
                //imageView2.image = NSImage(contentsOf: url)
                print("directory selected:", url.path)
                let mypath = "\(url.path)/\(xfileName)"
                print("full path is ", mypath)
                let completeURL = URL(fileURLWithPath:mypath)
                let fileManager = FileManager.default
                if fileManager.fileExists(atPath: mypath) {
                    print("\(mypath) exists.")
                
                    let myAlert = NSAlert()
                    myAlert.window.title = "File Overwrite Question"
                    myAlert.messageText = "File Exists!\nOverwrite it?"
                    myAlert.addButton(withTitle:"Yes")
                    myAlert.addButton(withTitle:"No")
                
                    let modalResult = myAlert.runModal()
                
                    switch modalResult {
                    case .alertFirstButtonReturn: // NSApplication.ModalResponse.alertFirstButtonReturn
                        print("Overwrite")
                        let mytext:String = textBox.string
                        print(mytext)
                        do {
                            try mytext.write(to: completeURL, atomically: true, encoding: .utf8)
                            print("successful")
                        } catch {
                            print(error)
                        }
                    default:
                        print("No overwrite")
                    }
                } else {
                    let mytext:String = textBox.string
                        print(mytext)
                        do {
                            try mytext.write(to: completeURL, atomically: true, encoding: .utf8)
                            print("successful")
                        } catch {
                            print(error)
                        }
                }
            } else {
                print("directory selection was canceled")
            }
        }
    filenameBox.stringValue = ""
    }

    @IBAction func processButton(_ sender: Any) {
        
        let myInputText:String = textBox.string
        myFixedText = ""
        String(myInputText)
            .split(separator: "\n")
            .forEach { line in
                //print("line: \(line)")
                let linepieces:Array = line.components(separatedBy: ": ")
                switch linepieces[0] {
                    case "/*":
                        // do something with the whole record
                        var recordOutput:String = ""
                        if (personRecord.firstName != "") {
                            recordOutput += "\(personRecord.firstName) "
                        }
                        if (personRecord.middleName != "") {
                            recordOutput += "\(personRecord.middleName) "
                        }
                        if (personRecord.lastName != "") {
                            recordOutput += "\(personRecord.lastName) "
                        }
                        if (recordOutput != "") {
                            recordOutput += "\n"
                        }
                        if (personRecord.streetAddress != "") {
                            recordOutput += "\(personRecord.streetAddress)\n"
                        }
                        if (personRecord.citySTZip != "") {
                            recordOutput += "\(personRecord.citySTZip)\n"
                        }
                        if (personRecord.homePhone != "") {
                            recordOutput += "Home: \(personRecord.homePhone)\n"
                        }
                        if (personRecord.mobilePhone != "") {
                            recordOutput += "Mobile: \(personRecord.mobilePhone)\n"
                        }
                        recordOutput += "\n"
                        print(recordOutput)
                        myFixedText += recordOutput
                        personRecord.clear()
                    case "FirstName":
                        //this is a first name
                        //print("FirstNamecase \(linepieces[0]) and \(linepieces[1])")
                        personRecord.firstName = linepieces[1]
                    case "MiddleName":
                        // this is a middle name
                        //print("MiddleNamecase \(linepieces[0]) and \(linepieces[1])")
                        personRecord.middleName = linepieces[1]
                    case "LastName":
                        // this is a last name
                        //print("LastNamecase \(linepieces[0]) and \(linepieces[1])")
                        personRecord.lastName = linepieces[1]
                    case "StreetAddress":
                        // this is a street address
                        //print("StreetAddresscase \(linepieces[0]) and \(linepieces[1])")
                        personRecord.streetAddress = linepieces[1]
                    case "CitySTZip":
                        // this is a city state zip
                        //print("CitySTZipcase \(linepieces[0]) and \(linepieces[1])")
                        personRecord.citySTZip = linepieces[1]
                    case "HomePhone":
                        // this is a home phone
                        //print("HomePhonecase \(linepieces[0]) and \(linepieces[1])")
                        personRecord.homePhone = linepieces[1]
                    case "MobilePhone":
                        // this is a mobile phone
                        //print("MobilePhonecase \(linepieces[0]) and \(linepieces[1])")
                        personRecord.mobilePhone = linepieces[1]
                    default:
                        // this is an invalid line
                        print("defaultcase \(line)")
                }
            }
        textBox.string = myFixedText
    }
    
    @IBAction func readButton(_ sender: Any) {
        print("openDocument ViewController")
        if let url = NSOpenPanel().selectUrl {
            //imageView2.image = NSImage(contentsOf: url)
            print("file selected:", url.path)
            let mypieces:Array = url.pathComponents
            var filenamewithextension:String = ""
            for mypart in mypieces {
              filenamewithextension = mypart
            }
            let filenamepieces:Array = filenamewithextension.components(separatedBy: ".txt")
            let filenamewithoutextension:String = filenamepieces[0]
            
            print(filenamewithoutextension)
            filenameBox.stringValue = filenamewithoutextension
            var mytext:String = ""
                        
            try? String(contentsOf: url, encoding: .utf8)
                .split(separator: "\n")
                .forEach { line in
                    if mytext.isEmpty {
                        mytext = String(line)
                    } else {
                        mytext = mytext + "\n" + String(line)
                    }
                    //print("line: \(line)")
                }
            textBox.string = mytext
        } else {
            print("file selection was canceled")
        }
    }
}

extension NSOpenPanel {
    var getDirectory: URL? {
        title = "Select Directory"
        allowsMultipleSelection = false
        canChooseDirectories = true
        canChooseFiles = false
        canCreateDirectories = false
        //allowedFileTypes = ["txt"]  // to allow only images, just comment out this line to allow any file type to be selected
        return runModal() == .OK ? urls.first : nil
    }
    var selectUrl: URL? {
        title = "Select File"
        allowsMultipleSelection = false
        canChooseDirectories = false
        canChooseFiles = true
        canCreateDirectories = false
        //allowedFileTypes = ["txt"]  // to allow only images, just comment out this line to allow any file type to be selected
        return runModal() == .OK ? urls.first : nil
    }
}

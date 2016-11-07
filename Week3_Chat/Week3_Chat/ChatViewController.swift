//
//  ViewController.swift
//  Week3_Chat
//
//  Created by CongTruong on 10/26/16.
//  Copyright © 2016 congtruong. All rights reserved.
//

import UIKit
import Parse

class ChatViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    
    @IBOutlet weak var inputTextField: UITextField!
    
    var messages = [String]()
    
    
    
    @IBAction func onSend(_ sender: AnyObject) {
        
        print(inputTextField.text)
        
        var message = PFObject(className:"Message_Swift_102016")
        message["text"] = inputTextField.text

        
        message.saveInBackground { (success, error) in
            if (success) {
                
                self.messages.insert(self.inputTextField.text!, at: 0)
                
                self.inputTextField.text = ""
                
                self.tableView.reloadData()
                
            } else {
                print(error)
            }
        }
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
        
        tableView.delegate = self
        tableView.dataSource = self

        tableView.estimatedRowHeight = 100
        tableView.rowHeight = UITableViewAutomaticDimension
        
        
        
        let query = PFQuery(className:"Message_Swift_102016")
        
        query.order(byDescending: "createdAt")
        query.findObjectsInBackground { (objects, error) in
            if error == nil {
                
                self.messages.removeAll()
                
                // The find succeeded.
                print("Successfully retrieved \(objects!.count) scores.")
                // Do something with the found objects
                if let objects = objects {
                    for object in objects {
                        print(object)
                        var text = ""
                        
                        print(object["user"])
                        
                        if let user = (object["user"] as? PFUser)?.email {
                            text = text + user + ": "
                        }
                        if let msg = object["text"] as? String {
                            text = text + msg
                        }
                        self.messages.append(text)
                    }
                    
                    self.tableView.reloadData()
                }
            } else {
                // Log details of the failure
                print("Error: \(error!)")
            }
        }
        
        let timer = Timer(timeInterval: 1000, target: self, selector: #selector(onTimer), userInfo: nil, repeats: true)
        timer.fire()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func onTimer(){
        let query = PFQuery(className:"Message_Swift_102016")
        
        query.order(byDescending: "createdAt")
        query.findObjectsInBackground { (objects, error) in
            if error == nil {
                
                self.messages.removeAll()
                
                // The find succeeded.
                print("Successfully retrieved \(objects!.count) scores.")
                // Do something with the found objects
                if let objects = objects {
                    for object in objects {
                        
                        var text = ""
                        if let user = object["user"] as? String {
                            text = text + user + ": "
                        }
                        if let msg = object["text"] as? String {
                            text = text + msg
                        }
                        self.messages.append(text)
                    }
                    
                    self.tableView.reloadData()
                }
            } else {
                // Log details of the failure
                print("Error: \(error!)")
            }
        }
    }

}

extension ChatViewController: UITableViewDataSource, UITableViewDelegate{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return messages.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! Cell
        cell.messageLabel.text = messages[indexPath.row]
        return cell
    }
}


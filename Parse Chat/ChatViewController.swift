//
//  ChatViewController.swift
//  Parse Chat
//
//  Created by 蒋逍琦 on 2/23/17.
//  Copyright © 2017 蒋逍琦. All rights reserved.
//

import UIKit
import Parse

class ChatViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var messageField: UITextField!
    
    var messages: [PFObject]!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        tableView.dataSource = self
        tableView.estimatedRowHeight = 50
        tableView.rowHeight = UITableViewAutomaticDimension
        
    Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(ChatViewController.refresh), userInfo: nil, repeats: true)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func createNewMessage(_ sender: Any) {
        let myMessage = PFObject(className:"Message")
        myMessage["text"] = messageField.text
        myMessage.saveInBackground {
            (success: Bool, error: Error?) -> Void in
            if (success) {
                // The object has been saved.
                print("Save Successfully! \(myMessage["text"])")
            } else {
                // There was a problem, check error.description
            }
        }
    }
    
    func refresh() {
        let query = PFQuery(className:"Message")
        query.whereKeyExists("text")
        query.findObjectsInBackground {
            (objects: [PFObject]?, error: Error?) -> Void in
            
            if error == nil {
                // The find succeeded.
                print("Successfully find messages")
                query.order(byDescending: "createdAt")

                // Do something with the found objects
                if let objects = objects {
                    self.messages = objects
                    self.tableView.reloadData()
                }
            } else {
                // Log details of the failure
                print("Error: \(error!) \((error as! NSError).userInfo)")
            }
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if messages != nil {
            return messages.count
        } else {
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MessageCell", for: indexPath) as! ChatCellTableViewCell
        
        cell.myMessage = self.messages[indexPath.row]
        //cell.myMessage = self.messages.i
        
        return cell
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}

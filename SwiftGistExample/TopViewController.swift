//
//  TopViewController.swift
//  SwiftGistExample
//
//  Created by 5t111111 on 2014/06/15.
//  Copyright (c) 2014 5t111111. All rights reserved.
//

import UIKit

class TopViewController: UIViewController {
    
    @IBOutlet var usernameField : UITextField = nil
    var items: NSArray = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func shouldPerformSegueWithIdentifier(identifier: String!, sender: AnyObject!) -> Bool {
        if usernameField.text == "" {
            var alert = UIAlertController(title: "Error", message: "Username field is required", preferredStyle: UIAlertControllerStyle.Alert)
            alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.Default, handler: nil))
            self.presentViewController(alert, animated: true, completion: nil)
            return false
        } else {
            return true
        }
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue!, sender: AnyObject!) {
        if (segue.identifier == "toListViewController") {
            let viewController: ListViewController = segue!.destinationViewController as ListViewController
            viewController.userID = usernameField.text
        }
    }
}

//
//  ListViewController.swift
//  SwiftGistExample
//
//  Created by 5t111111 on 2014/06/15.
//  Copyright (c) 2014 5t111111. All rights reserved.
//

import UIKit

class ListViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var tableView: UITableView!
    
    var userID: String = ""
    var items: NSArray = []
    var selectedGistURL:String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        self.fetchGists()
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int  {
        return items.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: UITableViewCellStyle.Subtitle, reuseIdentifier: "GistCell")
        self.configureCell(cell, atIndexPath: indexPath)
        return cell
    }
    
    func tableView(tableView: UITableView?, didSelectRowAtIndexPath indexPath:NSIndexPath!) {
        let item = self.items[indexPath.row] as NSDictionary
        selectedGistURL = item["html_url"] as String
        self.performSegueWithIdentifier("toWebViewController", sender: self)
    }
    
    func configureCell(cell: UITableViewCell, atIndexPath indexPath: NSIndexPath) {
        let item = self.items[indexPath.row] as NSDictionary
        let files = item["files"] as NSDictionary
        let keys: Array = files.allKeys
        cell.textLabel!.text = keys[0] as String
        cell.detailTextLabel!.text = item["description"] as String
        cell.detailTextLabel!.font = UIFont.systemFontOfSize(10.0)
        println(item)
    }
    
    func fetchGists() {
        let manager = AFHTTPRequestOperationManager()
        manager.GET("https://api.github.com/users/\(self.userID)/gists", parameters: nil,
            success: { (operation: AFHTTPRequestOperation!, responseObject:AnyObject!) in
                // Set JSON object to items variable.
                self.items = responseObject as NSArray
                // Reload TableView after fetching data
                self.tableView.reloadData()
            }, failure: { (operation: AFHTTPRequestOperation!, error: NSError!) in
                println("error: \(error)")
                var alert = UIAlertController(title: "Error", message: "User does not exist.", preferredStyle: UIAlertControllerStyle.Alert)
                alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.Default, handler: nil))
                self.presentViewController(alert, animated: true, completion: nil)
            })
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue!, sender: AnyObject!) {
        if (segue.identifier == "toWebViewController") {
            // pass data to next view
            let viewController: WebViewController = segue!.destinationViewController as WebViewController
            viewController.gistURL = selectedGistURL
        }
    }
}

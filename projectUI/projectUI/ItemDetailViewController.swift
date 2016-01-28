//
//  ItemDetailViewController.swift
//  projectUI
//
//  Created by Sarah Sherman on 1/28/16.
//  Copyright © 2016 Sarah Sherman. All rights reserved.
//

import UIKit

class ItemDetailsViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    let found = [Found]()
    
    @IBAction func cancelButtonPressed(sender: UIBarButtonItem) {
        cancelButtonDelegate?.cancelButtonPressedFrom(self)
    }
    
    
    @IBOutlet weak var itemImageView: UIImageView!
    
    
    @IBOutlet weak var itemLabel: UILabel!
    
    
    @IBOutlet weak var detailsLabel: UILabel!
    
    @IBOutlet weak var requestDateLabel: UILabel!
    
    
    @IBOutlet weak var replyTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        replyTableView.dataSource = self
        replyTableView.delegate = self
        
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("ReplyCell")! as! ReplyCell
        
        
        return cell
    }
    
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }

    weak var cancelButtonDelegate: CancelButtonDelegate?
}

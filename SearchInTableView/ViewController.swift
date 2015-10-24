//
//  ViewController.swift
//  SearchInTableView
//
//  Created by WindOfNet on 10/24/15.
//  Copyright © 2015 WindOfNet. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, UISearchBarDelegate {
    @IBOutlet weak var table: UITableView!
    
    //defalut data
    var data: Array<String> = ["Google", "Apple", "Facebook", "Amazon", "Twiter", "Youtube", "Yahoo", "Flick", "Microsoft", "Wiki"]
    //search data
    var s_data: Array<String> = []
    
    var isSearch = false
    
    // search delegate
    func searchBarTextDidBeginEditing(searchBar: UISearchBar) {
        isSearch = true
    }
    
    func searchBar(searchBar: UISearchBar, textDidChange searchText: String) {
        self.s_data.removeAll()
        
        if searchText.characters.count != 0 {
            isSearch = true
            
            self.search(searchText)
        }
        else {
            isSearch = false
        }
    }
    
    func searchBarCancelButtonClicked(searchBar: UISearchBar) {
        isSearch = false
    }
    
    func searchBarResultsListButtonClicked(searchBar: UISearchBar) {
        isSearch = false
    }
    
    func search(text: String) -> Void {
        s_data = data.filter({
            (txt: String) -> Bool in
            let tmp: String = txt
            let range = tmp.rangeOfString(text, options: NSStringCompareOptions.CaseInsensitiveSearch)
            return range != nil
        })
    }
    
    //tableview delegate
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if !isSearch {
            return data.count
        }
        else {
            return s_data.count
        }
    }
    
    func tableView(tableView: UITableView, sectionForSectionIndexTitle title: String, atIndex index: Int) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = self.table.dequeueReusableCellWithIdentifier("cell")
        if !isSearch {
            cell?.textLabel?.text = data[indexPath.row]
        }
        else {
            cell?.textLabel?.text = s_data[indexPath.row]
        }
        
        return cell!
    }
    
    //native
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        table.dataSource = self
        table.delegate = self
        
        //set search bar at top in tableview
        table.setContentOffset(CGPointMake(0, 44), animated: true)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}


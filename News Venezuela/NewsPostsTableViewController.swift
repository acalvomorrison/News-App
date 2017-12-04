//
//  NewsPostsTableViewController.swift
//  News Venezuela
//
//  Created by Andres Calvo on 11/14/17.
//  Copyright © 2017 Andres Calvo. All rights reserved.
//

import UIKit
import FirebaseDatabase

extension String {
    func index(of string: String, options: CompareOptions = .literal) -> Index? {
        return range(of: string, options: options)?.lowerBound
    }
}

class NewsPostsTableViewController: UITableViewController {
    @IBOutlet var tableViewForNews: UITableView!
    @IBOutlet weak var currentDate: UILabel!
    
    var newsTable = [[String: AnyObject]]()
    
    let refresh = UIRefreshControl()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableViewForNews.refreshControl = refresh
        
        refresh.addTarget(self, action: #selector(refreshData(_:)), for: .valueChanged)
        loadData()
        
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false
        
        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }
    
    
    @objc private func refreshData(_ sender: Any) {
        // Fetch Weather Data
        loadData()
    }
    
    private func loadData() {
        self.newsTable.removeAll()
        
        self.refresh.tintColor = UIColor(red:0.25, green:0.72, blue:0.85, alpha:1.0)
        self.refresh.attributedTitle = NSAttributedString(string: "Fetching News Data ...")
        let date = Date()
        let formatter = DateFormatter()
        
        formatter.dateFormat = "MM-dd-yyyy"
        self.currentDate.text = formatter.string(from: date)
        //let calendar = Calendar.current
        
        
        Database.database().reference().observeSingleEvent(of: .value, with: { (DataSnapshot) in
            if let newsDictionary = DataSnapshot.value as? [String: AnyObject] {
                for news in newsDictionary {
                    if let newAsDictionaryValue = news.value as? [String: AnyObject] {
                        self.newsTable.append(newAsDictionaryValue)
                    }
                }
                
                self.tableViewForNews.reloadData()
            }
        })
        
        self.tableViewForNews.reloadData()
        self.refresh.endRefreshing()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - Table view data source
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return self.newsTable.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let currentNew = self.newsTable[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell1", for: indexPath) as! PostsTableViewCell
        
        let title = currentNew["Title"] as? String
        let creator = currentNew["Creator"] as? String
        let date = currentNew["Date"] as? String
        let content = currentNew["Content"] as? String
        
        cell.author.text = creator
        cell.title.text = title
        cell.time.text = date
        cell.descriptionForPost.text = content
        cell.urlFacebok = (currentNew["FacebookLink"] as? String)!
//        cell.urlTwitter = (currentNew["TwitterLink"] as? String)!
//
//        print(cell.urlTwitter)
        
        cell.title.sizeToFit()
        cell.title.adjustsFontSizeToFitWidth = true
        cell.title.adjustsFontForContentSizeCategory = true
        
//        cell.expandNews.titleLabelForPost?.text = title
//        cell.expandNews.authorLabelForPost?.text = creator
//        cell.expandNews.timeLabelForPost?.text = date
//        cell.expandNews.descriptionLabelForPost?.text = content
//
//        cell.expandNews.addTarget(self, action: #selector(myClickEvent(_:)), for: .touchUpInside)
        
        // Configure the cell...
        
        return cell
    }
    
    func tableView(tableView: UITableView, estimatedHeightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return UITableViewAutomaticDimension
    }
    
    /*
     // Override to support conditional editing of the table view.
     override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
     // Return false if you do not want the specified item to be editable.
     return true
     }
     */
    
    /*
     // Override to support editing the table view.
     override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
     if editingStyle == .delete {
     // Delete the row from the data source
     tableView.deleteRows(at: [indexPath], with: .fade)
     } else if editingStyle == .insert {
     // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
     }
     }
     */
    
    /*
     // Override to support rearranging the table view.
     override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {
     
     }
     */
    
    /*
     // Override to support conditional rearranging of the table view.
     override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
     // Return false if you do not want the item to be re-orderable.
     return true
     }
     */
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destinationViewController.
     // Pass the selected object to the new view controller.
     }
     */
    
    
//    @objc func myClickEvent(_ senderButton: customButton) {
//        let view = ExpandPostViewController()
//
//        view.titleForPost.text = senderButton.titleLabelForPost?.text
//        view.timeForPost.text = senderButton.timeLabelForPost?.text
//        view.authorForPost.text = senderButton.authorLabelForPost?.text
//        view.descriptionForPost.text = senderButton.descriptionLabelForPost?.text
//
//        self.present(view, animated:true, completion:nil)
//    }
    
}

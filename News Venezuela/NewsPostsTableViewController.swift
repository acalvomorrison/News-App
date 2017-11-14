//
//  NewsPostsTableViewController.swift
//  News Venezuela
//
//  Created by Andres Calvo on 11/14/17.
//  Copyright © 2017 Andres Calvo. All rights reserved.
//

import UIKit

extension String {
    func index(of string: String, options: CompareOptions = .literal) -> Index? {
        return range(of: string, options: options)?.lowerBound
    }
}

class NewsPostsTableViewController: UITableViewController {
    @IBOutlet var tableViewForNews: UITableView!
    
    var posts = [String]()
    var responseString = ""
    let myGroup = DispatchGroup()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        myGroup.enter()
        //// Do your task
        getNewPosts()
        
        myGroup.notify(queue: DispatchQueue.main) {
            print("Done with post")
            
            if let index = self.responseString.index(of: "<item>") {
                let domains = self.responseString.suffix(from: index)
                let splitValues = domains.components(separatedBy: "</item>")
                var local = splitValues
                local.remove(at: (splitValues.count)-1)
                
                for string in local {
                    //print(string + "\n</item>")
                    self.posts.append(string)
                }
            }
            
            print(self.posts.count)
            self.tableViewForNews.reloadData()
            ////// do your remaining work
        }

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
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
        return posts.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let currentNew = posts[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell1", for: indexPath) as! PostsTableViewCell
        
        cell.title.text = "Fuck this shit"
        
        let date = Date()
        let calendar = Calendar.current
        let minutes = calendar.component(.minute, from: date)
        
        cell.time.text = String(minutes)
        
        cell.author.text = "Your daddy"
        cell.descriptionForPost.text = currentNew
        

        // Configure the cell...

        return cell
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
    
    private func getNewPosts() {
        var request = URLRequest(url: URL(string: "http://eltiempo.com.ve/venezuela/feed/")!)
        
        request.httpMethod = "GET"
        
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            guard let data = data, error == nil else {                                                 // check for fundamental networking error
                print("error=\(String(describing: error))")
                return
            }
            
            if let httpStatus = response as? HTTPURLResponse, httpStatus.statusCode != 200 {           // check for http errors
                print("statusCode should be 200, but is \(httpStatus.statusCode)")
                print("response = \(String(describing: response))")
            }
            
            self.responseString = String(data: data, encoding: .utf8)!
            
            print("Done with it")
            self.myGroup.leave() //// When your task completes
            
        }
        task.resume()
    }

}

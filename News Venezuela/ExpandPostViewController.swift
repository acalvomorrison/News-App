//
//  ExpandPostViewController.swift
//  News Venezuela
//
//  Created by Andres Calvo on 12/4/17.
//  Copyright © 2017 Andres Calvo. All rights reserved.
//

import UIKit

class ExpandPostViewController: UIViewController {
    @IBOutlet weak var titleForPost: UILabel!
    @IBOutlet weak var backButton: UIButton!
    @IBOutlet weak var authorForPost: UILabel!
    @IBOutlet weak var timeForPost: UILabel!
    @IBOutlet weak var descriptionForPost: UILabel!
    @IBOutlet weak var viewOnWebButton: UIButton!
    @IBOutlet weak var twitterButton: UIButton!
    @IBOutlet weak var facebookButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
    @IBAction func backButtonClicked(_ sender: Any) {
        self.performSegue(withIdentifier: "BackToAllNews", sender: nil)
    }
    @IBAction func facebookButtonClicked(_ sender: Any) {
    }
    @IBAction func twitterButtonClicked(_ sender: Any) {
    }
    @IBAction func viewOnWebClicked(_ sender: Any) {
    }
    
}

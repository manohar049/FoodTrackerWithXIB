//
//  ListViewController.swift
//  FoodTracker
//
//  Created by Administrator on 05/01/16.
//  Copyright © 2016 Administrator. All rights reserved.
//

import UIKit

class ListViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    // Mark Properties

    @IBOutlet weak var tableView: UITableView!
    
    var meals = [Meal]()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // MARK: Embedding Navigation Controller Properties
        self.navigationItem.title = "Ratings List"
        let rgtBarButton = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.Add, target: self, action: "addRating:")
        let leftBarButton = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.Edit, target: self, action: "editRating:")
        self.navigationItem.rightBarButtonItem = rgtBarButton
        self.navigationItem.leftBarButtonItem = leftBarButton
        
        // Mark: Table view
//        loadSampleMeals()
        let cellnib = UINib(nibName: "RatingTableViewCell", bundle: nil)
        tableView.registerNib(cellnib, forCellReuseIdentifier: "RatingCell")
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func addRating(button: UIButton) {
        let addEditViewController = ViewController(nibName: "ViewController", bundle: nil)
        addEditViewController.tableViewDelegate = tableView
        addEditViewController.mealsList = meals
        self.navigationController?.pushViewController(addEditViewController, animated: true)
    }
    
    func editRating(button: UIButton) {
        let leftBarDoneButton = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.Done, target: self, action: "doneEditing:")
        self.navigationItem.leftBarButtonItem = leftBarDoneButton
        tableView.editing = true
    }
    
    func doneEditing(button: UIButton) {
        let leftBarButton = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.Edit, target: self, action: "editRating:")
        self.navigationItem.leftBarButtonItem = leftBarButton
        tableView.editing = false
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return meals.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("RatingCell") as! RatingTableViewCell
        let meal = meals[indexPath.row]
        cell.nameLabel.text = meal.name
        cell.photoView.image = meal.photo
        cell.ratingControl.rating = meal.rating
        return cell
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        let viewController = ViewController(nibName: "ViewController", bundle: nil)
        let cellValues = meals[indexPath.row]
        viewController.meal = cellValues
        viewController.tableViewDelegate = tableView
        viewController.mealsList = meals
        self.navigationController?.pushViewController(viewController, animated: true)
    }
    
    func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {
            meals.removeAtIndex(indexPath.row)
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
        }
    }
    
    func loadSampleMeals() {
        let photo1 = UIImage(named: "meal")!
        let meal1 = Meal(name: "Caprese Salad", photo: photo1, rating: 4)!
        
        meals += [meal1]
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}

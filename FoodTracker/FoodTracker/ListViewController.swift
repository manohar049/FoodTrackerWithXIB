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
        let rgtBarButton = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.add, target: self, action: #selector(ListViewController.addRating(_:)))
        let leftBarButton = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.edit, target: self, action: #selector(ListViewController.editRating(_:)))
        self.navigationItem.rightBarButtonItem = rgtBarButton
        self.navigationItem.leftBarButtonItem = leftBarButton
        
        // Mark: Table view
//        loadSampleMeals()
        let cellnib = UINib(nibName: "RatingTableViewCell", bundle: nil)
        tableView.register(cellnib, forCellReuseIdentifier: "RatingCell")
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func addRating(_ button: UIButton) {
        let addEditViewController = ViewController(nibName: "ViewController", bundle: nil)
        addEditViewController.tableViewDelegate = tableView
        addEditViewController.mealsList = meals
        self.navigationController?.pushViewController(addEditViewController, animated: true)
    }
    
    func editRating(_ button: UIButton) {
        let leftBarDoneButton = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.done, target: self, action: #selector(ListViewController.doneEditing(_:)))
        self.navigationItem.leftBarButtonItem = leftBarDoneButton
        tableView.isEditing = true
    }
    
    func doneEditing(_ button: UIButton) {
        let leftBarButton = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.edit, target: self, action: #selector(ListViewController.editRating(_:)))
        self.navigationItem.leftBarButtonItem = leftBarButton
        tableView.isEditing = false
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return meals.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "RatingCell") as! RatingTableViewCell
        let meal = meals[indexPath.row]
        cell.nameLabel.text = meal.name
        cell.photoView.image = meal.photo
        cell.ratingControl.rating = meal.rating
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let viewController = ViewController(nibName: "ViewController", bundle: nil)
        let cellValues = meals[indexPath.row]
        viewController.meal = cellValues
        viewController.tableViewDelegate = tableView
        viewController.mealsList = meals
        self.navigationController?.pushViewController(viewController, animated: true)
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            meals.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
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

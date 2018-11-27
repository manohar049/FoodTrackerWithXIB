//
//  ViewController.swift
//  FoodTracker
//
//  Created by Administrator on 05/01/16.
//  Copyright © 2016 Administrator. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate, UITextFieldDelegate, UIViewControllerTransitioningDelegate {
    
    // Mark: Properties
    
    @IBOutlet weak var mealName: UITextField!
    @IBOutlet weak var mealImage: UIImageView!
    @IBOutlet weak var ratingControl: RatingController!
    
    var meal: Meal?
    var tableViewDelegate: UITableView?
    var mealsList = [Meal]()
    

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        mealName.delegate = self
        
        //Mark: Navigation Bar Properties
        
        let rightBarButton = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.save, target: self, action: #selector(ViewController.saveRatings(_:)))
        let leftBarButton = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.cancel, target: self, action: #selector(ViewController.cancelSave(_:)))
        self.navigationItem.title = "Your Rating"
        self.navigationItem.rightBarButtonItem = rightBarButton
        self.navigationItem.leftBarButtonItem = leftBarButton
        self.navigationController?.navigationBar.isTranslucent = false
        if (meal != nil) {
            mealName.text = meal?.name
            mealImage.image = meal?.photo
            ratingControl.rating = (meal?.rating)!
        }
        validateName()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // Mark: Actions
    
    @IBAction func selectImageFromGalary(_ sender: UITapGestureRecognizer) {
        
        mealName.resignFirstResponder()
        
        let imagePicker = UIImagePickerController()
        imagePicker.sourceType = .photoLibrary
        imagePicker.delegate = self
        present(imagePicker, animated: true, completion: nil)
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        mealName.resignFirstResponder()
        let selectecImg = info[UIImagePickerControllerOriginalImage] as! UIImage
        mealImage.image = selectecImg
        dismiss(animated: true, completion: nil)
    }
    
    func cancelSave(_ barButton: UIBarButtonItem) {
        self.navigationController?.popViewController(animated: true)
    }
    
    func saveRatings(_ barButton: UIBarButtonItem) {
        let name = mealName.text
        let image = mealImage.image
        let rating = ratingControl.rating
        let listView = ListViewController(nibName: "ListViewController", bundle: nil)
        if meal == nil {
            meal = Meal(name: name!, photo: image, rating: rating)
            mealsList.append(meal!)
            listView.meals = mealsList
        }
        else {
            meal = Meal(name: name!, photo: image, rating: rating)
            let selectedIndex = tableViewDelegate?.indexPathForSelectedRow
            let selectedMeal = mealsList[(selectedIndex?.row)!]
            selectedMeal.name = name!
            selectedMeal.photo = image
            selectedMeal.rating = rating
            listView.meals = mealsList
        }
        self.navigationController?.pushViewController(listView, animated: true)
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        validateName()
        self.navigationItem.title = textField.text
    }
    
    func validateName() {
        let text = mealName.text ?? ""
        self.navigationItem.rightBarButtonItem?.isEnabled = !text.isEmpty
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

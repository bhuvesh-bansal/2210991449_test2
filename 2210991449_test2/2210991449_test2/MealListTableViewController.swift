//
//  MealListTableViewController.swift
//  2210991449_test2
//
//  Created by student-2 on 23/11/24.
//

import UIKit

class MealListTableViewController: UITableViewController {

    var meals: [Meal] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Weekly Meal Plan"
        
        fetchMeals()
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return meals.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MealCell", for: indexPath) as! MealTableViewCell
        let meal = meals[indexPath.row]
        
        if let recipeNameLabel = cell.recipeNameLabel {
            recipeNameLabel.text = meal.recipeName
        }
        
        if let nutritionalInformationLabel = cell.nutritionalInformationLabel {
            nutritionalInformationLabel.text = "Nutritional Info: \(meal.nutritionalInformation) kcal"
        }
        
        if let preparationTimeLabel = cell.preparationTimeLabel {
            preparationTimeLabel.text = "Prep Time: \(meal.preparationTime)"
        }
        
        if let thumbnailImageView = cell.thumbnailImageView {
            if let thumbnailData = meal.thumbnail {
                thumbnailImageView.image = UIImage(data: thumbnailData)
            } else {
                thumbnailImageView.image = UIImage(systemName: "photo") // Placeholder image
            }
        }
        
        return cell
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showMealDetail" {
            let destinationVC = segue.destination as! MealDetailViewController
            if let indexPath = tableView.indexPathForSelectedRow {
                destinationVC.meal = meals[indexPath.row]
            }
        } else if segue.identifier == "showSummary" {
            let destinationVC = segue.destination as! SummaryViewController
            destinationVC.meals = meals
        } else if segue.identifier == "addMeal" {
            let destinationVC = segue.destination as! MealDetailViewController
            destinationVC.meal = nil
        }
    }

    func fetchMeals() {
        if let savedMeals = UserDefaults.standard.data(forKey: "meals") {
            if let decodedMeals = try? JSONDecoder().decode([Meal].self, from: savedMeals) {
                meals = decodedMeals
            }
        } else {
            meals = getExampleMeals()
            saveMeals()
        }
        tableView.reloadData()
    }

    func saveMeals() {
        let encoder = JSONEncoder()
        if let encodedMeals = try? encoder.encode(meals) {
            UserDefaults.standard.set(encodedMeals, forKey: "meals")
        }
    }
}

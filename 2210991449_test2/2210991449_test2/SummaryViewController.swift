//
//  SummaryViewController.swift
//  2210991449_test2
//
//  Created by student-2 on 23/11/24.
//

import UIKit

class SummaryViewController: UIViewController {

    @IBOutlet weak var totalCaloriesLabel: UILabel!
    @IBOutlet weak var nutritionalBreakdownLabel: UILabel!
    
    var meals: [Meal] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        displaySummary()
    }

    func displaySummary() {
        let totalCalories = meals.reduce(0) { $0 + $1.nutritionalInformation }
        totalCaloriesLabel.text = "Total Calories: \(totalCalories)"
        
        // Calculate and display nutritional breakdown
        var categoriesCount: [String: Int] = [:]
        for meal in meals {
            categoriesCount[meal.category, default: 0] += 1
        }

        var breakdownText = ""
        for (category, count) in categoriesCount {
            breakdownText += "\(category): \(count)\n"
        }
        nutritionalBreakdownLabel.text = breakdownText
    }
}


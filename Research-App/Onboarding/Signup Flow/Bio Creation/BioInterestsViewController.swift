//
//  BioInterestsViewController.swift
//  Research-App
//
//  Created by Levi Harris on 3/10/23.
//

import UIKit

class BioInterestsViewController: UIViewController {
    
    @IBOutlet weak var fitnessButton: UIButton!
    @IBOutlet weak var cookingButton: UIButton!
    @IBOutlet weak var gamingButton: UIButton!
    @IBOutlet weak var outdoorsButton: UIButton!
    @IBOutlet weak var sportsButton: UIButton!
    @IBOutlet weak var musicButton: UIButton!
    @IBOutlet weak var artButton: UIButton!
    @IBOutlet weak var petsButton: UIButton!
    @IBOutlet weak var travelButton: UIButton!
    
    private var fitnessFlag = false
    private var cookingFlag = false
    private var gamingFlag = false
    private var outdoorFlag = false
    private var sportsFlag = false
    private var musicFlag = false
    private var artsFlag = false
    private var petsFlag = false
    private var travelFlag = false
    
    var selectedCount: Int = 0
    var tempInterests: [String] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func fitnessPressed(_ sender: Any) {
        if !(fitnessFlag) {
            if (selectedCount < 3){
                fitnessButton.setImage(UIImage(systemName: "square.fill"), for: UIControl.State.normal)
                tempInterests.append("Fitness")
                selectedCount += 1
                fitnessFlag = true
            }
        }
        else{
            fitnessButton.setImage(UIImage(systemName: "square"), for: UIControl.State.normal)
            tempInterests.removeAll {$0 == "Fitness"}
            selectedCount -= 1
            fitnessFlag = false
        }
    }
    
    @IBAction func cookingPressed(_ sender: Any) {
        if !(cookingFlag) {
            if (selectedCount < 3){
                cookingButton.setImage(UIImage(systemName: "square.fill"), for: UIControl.State.normal)
                tempInterests.append("Cooking")
                selectedCount += 1
                cookingFlag = true
            }
        }
        else{
            cookingButton.setImage(UIImage(systemName: "square"), for: UIControl.State.normal)
            tempInterests.removeAll {$0 == "Cooking"}
            selectedCount -= 1
            cookingFlag = false
        }
    }
    
    @IBAction func gamingButton(_ sender: Any) {
        if !(gamingFlag) {
            if (selectedCount < 3){
                gamingButton.setImage(UIImage(systemName: "square.fill"), for: UIControl.State.normal)
                tempInterests.append("Gaming")
                selectedCount += 1
                gamingFlag = true
            }
        }
        else{
            gamingButton.setImage(UIImage(systemName: "square"), for: UIControl.State.normal)
            tempInterests.removeAll {$0 == "Gaming"}
            selectedCount -= 1
            gamingFlag = false
        }
    }
    
    @IBAction func outdoorsPressed(_ sender: Any) {
        if !(outdoorFlag) {
            if (selectedCount < 3){
                outdoorsButton.setImage(UIImage(systemName: "square.fill"), for: UIControl.State.normal)
                tempInterests.append("Outdoors")
                selectedCount += 1
                outdoorFlag = true
            }
        }
        else{
            outdoorsButton.setImage(UIImage(systemName: "square"), for: UIControl.State.normal)
            tempInterests.removeAll {$0 == "Outdoors"}
            selectedCount -= 1
            outdoorFlag = false
        }
    }
    
    @IBAction func sportsPressed(_ sender: Any) {
        if !(sportsFlag) {
            if (selectedCount < 3){
                sportsButton.setImage(UIImage(systemName: "square.fill"), for: UIControl.State.normal)
                tempInterests.append("Sports")
                selectedCount += 1
                sportsFlag = true
            }
        }
        else{
            sportsButton.setImage(UIImage(systemName: "square"), for: UIControl.State.normal)
            tempInterests.removeAll {$0 == "Sports"}
            selectedCount -= 1
            sportsFlag = false
        }
    }
    
    @IBAction func musicPressed(_ sender: Any) {
        if !(musicFlag) {
            if (selectedCount < 3){
                musicButton.setImage(UIImage(systemName: "square.fill"), for: UIControl.State.normal)
                tempInterests.append("Music")
                selectedCount += 1
                musicFlag = true
            }
        }
        else{
            musicButton.setImage(UIImage(systemName: "square"), for: UIControl.State.normal)
            tempInterests.removeAll {$0 == "Music"}
            selectedCount -= 1
            musicFlag = false
        }
    }
    
    @IBAction func artPressed(_ sender: Any) {
        if !(artsFlag) {
            if (selectedCount < 3){
                artButton.setImage(UIImage(systemName: "square.fill"), for: UIControl.State.normal)
                tempInterests.append("Art")
                selectedCount += 1
                artsFlag = true
            }
        }
        else{
            artButton.setImage(UIImage(systemName: "square"), for: UIControl.State.normal)
            tempInterests.removeAll {$0 == "Art"}
            selectedCount -= 1
            artsFlag = false
        }
    }
    
    @IBAction func petsPressed(_ sender: Any) {
        if !(petsFlag) {
            if (selectedCount < 3){
                petsButton.setImage(UIImage(systemName: "square.fill"), for: UIControl.State.normal)
                tempInterests.append("Pets")
                selectedCount += 1
                petsFlag = true
            }
        }
        else{
            petsButton.setImage(UIImage(systemName: "square"), for: UIControl.State.normal)
            tempInterests.removeAll {$0 == "Pets"}
            selectedCount -= 1
            petsFlag = false
        }
    }
    
    @IBAction func travelPressed(_ sender: Any) {
        if !(travelFlag) {
            if (selectedCount < 3){
                travelButton.setImage(UIImage(systemName: "square.fill"), for: UIControl.State.normal)
                tempInterests.append("Travel")
                selectedCount += 1
                travelFlag = true
            }
        }
        else{
            travelButton.setImage(UIImage(systemName: "square"), for: UIControl.State.normal)
            tempInterests.removeAll {$0 == "Travel"}
            selectedCount -= 1
            travelFlag = false
        }
    }
    @IBAction func continuePressed(_ sender: Any) {
        GlobalConstants.user.interests = tempInterests
        print(GlobalConstants.user.interests)
    }
}

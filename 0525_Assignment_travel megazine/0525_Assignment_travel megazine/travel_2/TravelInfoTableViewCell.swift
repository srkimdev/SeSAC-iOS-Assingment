//
//  TravelInfoTableViewCell.swift
//  0525_Assignment_travel megazine
//
//  Created by 김성률 on 5/27/24.
//

import UIKit

class TravelInfoTableViewCell: UITableViewCell {

    static let identifier = "TravelInfoTableViewCell"
    
    @IBOutlet var title: UILabel!
    @IBOutlet var descriptionLabel: UILabel!
    @IBOutlet var grade: UILabel!
    
    @IBOutlet var travel_image: UIImageView!
    @IBOutlet var likeButton: UIButton!
    
    @IBOutlet var save: UILabel!
    
    func designTravelInfo(transition: Travel) {
        
        // ---- title ----
        title.text = transition.title
        title.font = .boldSystemFont(ofSize: 17)
        
        // ---- description ----
        descriptionLabel.text = transition.description
        descriptionLabel.font = .systemFont(ofSize: 15)
        descriptionLabel.textColor = .darkGray
        descriptionLabel.numberOfLines = 2
    
        // ---- grade ----
        grade.textColor = .lightGray
        grade.font = .systemFont(ofSize: 13)
        
        guard let store = transition.save, let image = transition.travel_image, let like = transition.like else {
            return
        }
        
        // ---- save ----
        let numberFormatter = NumberFormatter()
        numberFormatter.numberStyle = .decimal
        save.text = "저장 " + numberFormatter.string(from: NSNumber(value: store))!
        save.textColor = .lightGray
        save.font = .systemFont(ofSize: 13)
        
        // ---- travel_image ----
        let url = URL(string: image)
        travel_image.kf.setImage(with: url)
        travel_image.contentMode = .scaleAspectFill
        travel_image.layer.cornerRadius = 8
        
        // ---- likeButton ----
        if like {
            likeButton.setImage(UIImage(systemName: "heart.fill"), for: .normal)
            likeButton.tintColor = .red
        } else {
            likeButton.setImage(UIImage(systemName: "heart"), for: .normal)
            likeButton.tintColor = .white
        }
        
        let star: Int = Int(round(transition.grade!))
        grade.text = drawStars(for: star) + " (\(transition.grade!))" + " · "
    }
    
    func drawStars(for rating: Int) -> String {
        
        var starsString = ""
        for _ in 0..<rating {
            starsString += "★"
        }
        for _ in rating..<5 {
            starsString += "☆"
        }
        
        return starsString
    }
    
}


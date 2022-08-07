//
//  DestinationCollectionViewCell.swift
//  LuckyTrip
//
//  Created by Abdullah Munzer on 07/08/2022.
//

import UIKit
import Kingfisher

class DestinationCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var imageViewThump: UIImageView!
    @IBOutlet weak var lblCountryName: UILabel!
    @IBOutlet weak var lblCityName: UILabel!
    @IBOutlet weak var btnPlay: UIButton!

    var clouserPlayBtnTapped: ((String) -> Void)?

    var videoURL = ""

    override var isSelected: Bool {
        didSet {
            if self.isSelected {
                setSelected()
            } else {
                setUnselected()
            }
        }
    }

    func setSelected() {
        contentView.layer.borderWidth = 4
        contentView.layer.borderColor = UIColor.red.withAlphaComponent(0.2).cgColor
        contentView.backgroundColor = .blue.withAlphaComponent(0.2)
    }

    func setUnselected() {
        contentView.layer.borderWidth = 0
        contentView.backgroundColor = .white
    }

    func cellSetup(destination: Destination) {
        if let url = URL(string: destination.thumbnail?.imageURL ?? "") {
            imageViewThump.kf.setImage(with: url)
        }
        if destination.destinationVideo == nil {
            btnPlay.isHidden = true
        } else {
            btnPlay.isHidden = false
            videoURL = destination.destinationVideo?.url ?? ""
        }
        lblCityName.text = destination.city
        lblCountryName.text = destination.countryName
    }
    @IBAction func playBtnTapped(_ sender: Any) {
        clouserPlayBtnTapped?(videoURL)
    }
}

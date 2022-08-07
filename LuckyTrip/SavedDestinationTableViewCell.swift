//
//  SavedDestinationTableViewCell.swift
//  LuckyTrip
//
//  Created by Abdullah Munzer on 07/08/2022.
//

import UIKit

class SavedDestinationTableViewCell: UITableViewCell {
    @IBOutlet weak var lblCountryName: UILabel!
    @IBOutlet weak var lblCityName: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    func cellSetup(destination: Destination) {
        lblCityName.text = destination.city
        lblCountryName.text = destination.countryName
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}

//
//  SongCell.swift
//  CoreDataProject
//
//  Created by Field Employee on 11/6/20.
//

import UIKit

class SongCell: UITableViewCell {

    
    @IBOutlet weak var SongLabel: UILabel!
    @IBOutlet weak var FavoriteBtn: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}

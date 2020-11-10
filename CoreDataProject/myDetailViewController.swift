//
//  myDetailViewController.swift
//  CoreDataProject
//
//  Created by Field Employee on 11/9/20.
//

import UIKit

class myDetailViewController: UIViewController {

    @IBOutlet weak var albumImage: UIImageView!
    @IBOutlet weak var artistName: UILabel!
    @IBOutlet weak var albumName: UILabel!
    @IBOutlet weak var releaseDate: UILabel!
    @IBOutlet weak var favoriteBtn: UIButton!
    var heartfill:String = "heart.fill"
    var heart:String = "heart"
    var viewModel:ViewModel
    var index: Int?
    
    var tuple: (name:String, image:String, artistName:String, albumName:String, date:String, favorite:Bool, index:Int)
    
    @IBAction func favoriteBtnTap(_ sender: Any) {
        tuple.favorite.toggle()
        setFavoriteBtn()
        viewModel.setFavorite(songNumber: tuple.index)
    }
    
    init(details: (name:String, image:String, artistName:String, albumName:String, date:String, favorite:Bool, index:Int), viewModel:ViewModel){
        self.tuple = details
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.viewModel.getSongList()
        var date:String = "Unknown Release Date"
        if(self.tuple.date != "Unknown Release Date")
        {
            date = getDate(date:self.tuple.date)
        }
        
        let url = URL(string: (tuple.image))
        let data = try? Data(contentsOf: url!)
        let image = UIImage(data: data!)
        self.albumImage?.image = image
        self.artistName?.text = tuple.artistName
        self.albumName?.text = tuple.albumName
        self.releaseDate?.text = date
        setFavoriteBtn()
        // Do any additional setup after loading the view.
    }
    
    func setFavoriteBtn() {
        if(tuple.favorite)
        {
            favoriteBtn.setImage(UIImage(systemName: heartfill), for: .normal)
        }
        else{
            favoriteBtn.setImage(UIImage(systemName: heart), for: .normal)
        }
    }
    
    func getDate(date:String) -> String{
        let inputDate = DateFormatter()
        inputDate.dateFormat = "yyyy-MM-dd"
        let outputDate = inputDate.date(from: self.tuple.date)
        inputDate.dateFormat = "MMMM dd, yyyy"
        return inputDate.string(from: outputDate!)
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}


    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */



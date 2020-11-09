//
//  detailViewController.swift
//  CoreDataProject
//
//  Created by Field Employee on 11/8/20.
//

import UIKit

class detailViewController: UIViewController {

    var imageView: UIImageView?
    var artistLabel: UILabel?
    var albumLabel: UILabel?
    var dateLabel: UILabel?
    var favoriteBtn: UIButton?
    var genreLabel: UILabel?
    var viewModel = ViewModel()
    var index: Int?
    
    var tuple: (name:String, image:String, artistName:String, albumName:String, date:String, favorite:Bool, index:Int)
    
    init(details: (name:String, image:String, artistName:String, albumName:String, date:String, favorite:Bool, index:Int)){
        self.tuple = details
        let inputDate = DateFormatter()
        inputDate.dateFormat = "yyyy-MM-dd"
        let outputDate = inputDate.date(from: self.tuple.date)
        inputDate.dateFormat = "MMMM dd, yyyy"
        self.tuple.date = inputDate.string(from: outputDate!)
        print(self.tuple)
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setUp()
        // Do any additional setup after loading the view.
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

extension detailViewController {
    private func setUp(){
        self.view.backgroundColor = .white
        self.navigationItem.title = self.tuple.name
    }
}

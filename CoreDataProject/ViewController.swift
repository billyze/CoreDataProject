//
//  ViewController.swift
//  CoreDataProject
//
//  Created by Field Employee on 11/6/20.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var myTableView: UITableView!
    
    var viewModel = ViewModel()
    //var songList: [Song] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.viewModel.getSongList()
        //self.myTableView.reloadData()
        self.viewModel.bind {
            DispatchQueue.main.async {
                //self.songList = self.viewModel.songList!
                self.myTableView.reloadData()
            }
        }
        // Do any additional setup after loading the view.
    }
    override func viewWillAppear(_ animated: Bool) {
        self.viewModel.getSongList()
        //self.myTableView.reloadData()
    }
}

extension ViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        100
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "songCell", for: indexPath) as? SongCell else { return UITableViewCell() }
        cell.SongLabel.text = "Song #\(indexPath.row)"
        let img = UIImage(systemName: "heart")
        let imgFill = UIImage(systemName: "heart.fill")
        cell.FavoriteBtn.setImage(img, for: .normal)
        cell.FavoriteBtn.addTarget(self, action: #selector(connected(sender:)), for: .touchUpInside)
        cell.FavoriteBtn.tag = indexPath.row
        if((self.viewModel.songList?.indices.contains(indexPath.row)) != nil)
        {
            let url = URL(string: (self.viewModel.songList![indexPath.row].artworkUrl100!))
            let data = try? Data(contentsOf: url!)
            let image = UIImage(data: data!)
            cell.AlbumImg.image = image
            cell.SongLabel.text = self.viewModel.songList![indexPath.row].name
            if(self.viewModel.songList![indexPath.row].favorite){
                cell.FavoriteBtn.setImage(imgFill, for: .normal)
            }
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if(self.viewModel.songList! != []){
            let name = self.viewModel.songList![indexPath.row].name
            let image = self.viewModel.songList![indexPath.row].artworkUrl100
            let artistName = self.viewModel.songList![indexPath.row].artistName
            let albumName = self.viewModel.songList![indexPath.row].collectionName
            let date = self.viewModel.songList![indexPath.row].releaseDate
            let favorite = self.viewModel.songList![indexPath.row].favorite
            let index = indexPath.row
            let vc = myDetailViewController(details: (name:name!, image:image!, artistName:artistName!, albumName:albumName!, date:date ?? "Unknown Release Date", favorite:favorite, index:index), viewModel:self.viewModel)
            self.navigationController?.pushViewController(vc, animated: true)
        }
    }
    
    @objc func connected(sender: UIButton){
        let buttonTag = sender.tag
        viewModel.setFavorite(songNumber: buttonTag)
    }
    
}

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
    var songList: [Song] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        songList = self.viewModel.getSongList()
        self.myTableView.reloadData()
        self.viewModel.bind {
            DispatchQueue.main.async {
                self.myTableView.reloadData()
            }
        }
        // Do any additional setup after loading the view.
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
        if(songList.indices.contains(indexPath.row))
        {
            cell.SongLabel.text = songList[indexPath.row].name
            if(songList[indexPath.row].favorite){
                cell.FavoriteBtn.setImage(imgFill, for: .normal)
            }
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if(songList != []){
            let name = songList[indexPath.row].name
            let image = songList[indexPath.row].artworkUrl100
            let artistName = songList[indexPath.row].artistName
            let albumName = songList[indexPath.row].collectionName
            let date = songList[indexPath.row].releaseDate
            let favorite = songList[indexPath.row].favorite
            let index = indexPath.row
            let vc = detailViewController(details: (name:name!, image:image!, artistName:artistName!, albumName:albumName!, date:date!, favorite:favorite, index:index))
            self.navigationController?.pushViewController(vc, animated: true)
        }
    }
    
    @objc func connected(sender: UIButton){
        let buttonTag = sender.tag
        viewModel.setFavorite(songNumber: buttonTag)
    }
    
}

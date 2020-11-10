//
//  ViewModel.swift
//  CoreDataProject
//
//  Created by Field Employee on 11/6/20.
//

import Foundation

class ViewModel {
    var coredataManager: CoreDataManager
    var songList: [Song]? {
        didSet {
            self.updateHandler?()
        }
    }
    var updateHandler: (() -> ())?

    init(coredataManager: CoreDataManager = CoreDataManager()){
        self.coredataManager = coredataManager
    }
    
    func bind(handler: @escaping () -> ()) {
        self.updateHandler = handler
    }
}

extension ViewModel {
    
    func saveSong(songInformation: songInfo){
        coredataManager.saveSong(songInf: songInformation)
        coredataManager.saveContext()
    }
    
    func getSongList(){
        var songList1:[Song]
        songList1 = coredataManager.getSongList()
        if(songList1 == [])
        {
            NetworkManager.shared.getSongList(url1: ""){ songList2 in
                DispatchQueue.main.async {
                    songList2.forEach{
                        self.saveSong(songInformation: $0)
                    }
                    self.songList = self.coredataManager.getSongList()
                    self.updateHandler?()
                }
            }
        }
        else{
            self.songList = songList1
        }
    }
    
    func setFavorite(songNumber: Int){
        var songList:[Song]
        songList = coredataManager.getSongList()
        if(songList == []) {return}
        else{
            songList[songNumber].favorite.toggle()
        }
        self.songList = songList
        coredataManager.saveContext()
    }
}

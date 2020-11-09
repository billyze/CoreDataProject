//
//  ViewModel.swift
//  CoreDataProject
//
//  Created by Field Employee on 11/6/20.
//

import Foundation

class ViewModel {
    var coredataManager: CoreDataManager
    var songList: [Song?]? {
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
    
    func getSongList() -> [Song] {
        var songList:[Song]
        songList = coredataManager.getSongList()
        if(songList == [])
        {
            NetworkManager.shared.getSongList(url1: ""){ songList in
                DispatchQueue.main.async {
                    songList.forEach{
                        self.saveSong(songInformation: $0)
                    }
                }
            }
            songList = coredataManager.getSongList()
        }
        self.songList = songList
        self.updateHandler?()
        return songList
    }
    
    func setFavorite(songNumber: Int){
        var songList:[Song]
        songList = coredataManager.getSongList()
        if(songList == []) {return}
        else{
            songList[songNumber].favorite.toggle()
        }
        coredataManager.saveContext()
        self.songList = songList
        self.updateHandler?()
    }
}

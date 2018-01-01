//
//  ViewController.swift
//  ConvertAudio
//
//  Created by DoLH on 12/15/17.
//  Copyright © 2017 DoLH. All rights reserved.
//

import UIKit



class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        
    }
   
    
    override func viewDidAppear(_ animated: Bool) {
        
        let input = Bundle.main.url(forResource: "record_93", withExtension: "m4a")
        let outPut = Utility.getDocumentsDirectory().appendingPathComponent("file11.m4a")
        
        
        let ex = SongExporter.init(exportPath: outPut.path)
        ex.exportSongWithURL(input!)
        
//        SongExporter.convertAudio(url!, outputURL: doc)
        

    }
    
    
}


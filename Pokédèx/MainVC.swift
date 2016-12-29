//
//  ViewController.swift
//  Pokédèx
//
//  Created by AKIL KUMAR THOTA on 12/29/16.
//  Copyright © 2016 AKIL KUMAR THOTA. All rights reserved.
//

import UIKit
import AVFoundation

class MainVC: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    @IBOutlet weak var collectionView: UICollectionView!
    
    var pokearray = [Pokemon]()
    var songPlayer: AVAudioPlayer!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        collectionView.delegate = self
        collectionView.dataSource = self
        
        parseCsvFile()
        song()
    }
    
    func song() {
        let path = Bundle.main.path(forResource: "music", ofType: "mp3")!
        
        do {
            songPlayer = try AVAudioPlayer(contentsOf: URL(fileURLWithPath: path))
            songPlayer.prepareToPlay()
            songPlayer.numberOfLoops = -1
            songPlayer.play()
        } catch let err as NSError {
            
            print(err.debugDescription)
            
        }
    }
    
    func parseCsvFile() {
        
        let path = Bundle.main.path(forResource: "pokemon", ofType: "csv")!
        
        do{
            let csv = try CSV(contentsOfURL: path)
            let rows = csv.rows
            //print(rows)
            
            for row in rows {
                let name = row["identifier"]
                let pokedi = Int(row["id"]!)
                let pokemon = Pokemon(name: name!, PokemonId: pokedi!)
                pokearray.append(pokemon)
            }
            
        } catch let err as NSError {
            print(err.debugDescription)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "PokeCell", for: indexPath) as? PokeCell {
            
            let pokemon = pokearray[indexPath.row]
            cell.ConfigureCell(pokemon)
            cell.cornerRadius()
            return cell
        } else {
            return UICollectionViewCell()
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return pokearray.count
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        // code to be writtnen
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        return CGSize(width: 105, height: 105)
    }
   
    @IBAction func songPlayerBtn(_ sender: UIButton) {
        
        if songPlayer.isPlaying {
            songPlayer.pause()
            sender.alpha = 0.3
        } else {
            songPlayer.play()
            songPlayer.numberOfLoops = -1
            sender.alpha = 1.0
        }
    }

}


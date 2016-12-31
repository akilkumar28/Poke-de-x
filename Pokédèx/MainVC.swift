//
//  ViewController.swift
//  Pokédèx
//
//  Created by AKIL KUMAR THOTA on 12/29/16.
//  Copyright © 2016 AKIL KUMAR THOTA. All rights reserved.
//

import UIKit
import AVFoundation

class MainVC: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout,UISearchBarDelegate {
    
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var collectionView: UICollectionView!
    
    var pokearray = [Pokemon]()
    var changingarray = [Pokemon]()
    var songPlayer: AVAudioPlayer!
    var isSearching = false

    override func viewDidLoad() {
        super.viewDidLoad()
        
        collectionView.delegate = self
        collectionView.dataSource = self
        searchBar.delegate = self
        searchBar.returnKeyType = UIReturnKeyType.done
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
//            print(rows)
            
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
            let poke : Pokemon!
            if isSearching {
                 poke = changingarray[indexPath.row]
                cell.ConfigureCell(poke)
                cell.cornerRadius()
                return cell
            }
            poke = pokearray[indexPath.row]
            cell.ConfigureCell(poke)
            cell.cornerRadius()
            return cell
            
        } else {
            return UICollectionViewCell()
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        if isSearching {
            return changingarray.count
        }
        return pokearray.count
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let poke: Pokemon!
        if isSearching {
            poke = changingarray[indexPath.row]
        } else {
            poke = pokearray[indexPath.row]
        }
        performSegue(withIdentifier: "PokemonDetailsVC", sender: poke)
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
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        view.endEditing(true)
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        
        if searchBar.text == nil || searchBar.text == "" {
            isSearching = false
            collectionView.reloadData()
            view.endEditing(true)
        } else {
            isSearching = true
            
           let lower = searchBar.text?.lowercased()
            changingarray = pokearray.filter({$0.name.range(of: lower!) != nil})
            collectionView.reloadData()
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if let destination = segue.destination as? PokemonDetailsVC {
            if let poke = sender as? Pokemon {
                destination.pokemon = poke
            }
        }
    }
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    

}


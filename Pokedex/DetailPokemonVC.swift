//
//  DetailPokemonVC.swift
//  Pokedex
//
//  Created by baytoor on 7/8/17.
//  Copyright © 2017 Baytur. All rights reserved.
//

import UIKit

class DetailPokemonVC: UIViewController {

    @IBOutlet weak var nameLbl: UILabel!
    @IBOutlet weak var mainImg: UIImageView!
    @IBOutlet weak var discriptionLbl: UILabel!
    @IBOutlet weak var typeLbl: UILabel!
    @IBOutlet weak var defenceLbl: UILabel!
    @IBOutlet weak var heightLbl: UILabel!
    @IBOutlet weak var weightLbl: UILabel!
    @IBOutlet weak var idLbl: UILabel!
    @IBOutlet weak var attackLbl: UILabel!
    @IBOutlet weak var currentEvoImg: UIImageView!
    @IBOutlet weak var nextEvoImg: UIImageView!
    @IBOutlet weak var evoLbl: UILabel!
    
    var pokemon: Pokemon!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        nameLbl.text = pokemon.name.capitalized
        idLbl.text = "\(pokemon.id)"
        mainImg.image = UIImage(named: "\(pokemon.id)")
        currentEvoImg.image = UIImage(named: "\(pokemon.id)")
        
        pokemon.downloadPokemonDetail { 
            // Whatever we write will only be called after the network is complete!
            self.updateUI()
        }
        
    }
    
    
    func updateUI() {
        discriptionLbl.text = pokemon.discription
        typeLbl.text = pokemon.type
        attackLbl.text = pokemon.attack
        defenceLbl.text = pokemon.defense
        heightLbl.text = pokemon.height
        weightLbl.text = pokemon.weight
        
        if pokemon.nextEvoId != "x"{
            nextEvoImg.image = UIImage(named: pokemon.nextEvoId)
            evoLbl.text = "Next Evolution: \(pokemon.nextEvoName) - LVL \(pokemon.nextEvoLevel)"
        } else {
            nextEvoImg.image =  UIImage(named: pokemon.nextEvoId)?.maskWithColor(color: UIColor.init(red: 1, green: 88/255, blue: 85/255, alpha: 1))
            evoLbl.text = "No Evolution"
        }
    }

    @IBAction func backBtnPressed(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }

}

extension UIImage {
    
    func maskWithColor(color: UIColor) -> UIImage? {
        let maskImage = cgImage!
        
        let width = size.width
        let height = size.height
        let bounds = CGRect(x: 0, y: 0, width: width, height: height)
        
        let colorSpace = CGColorSpaceCreateDeviceRGB()
        let bitmapInfo = CGBitmapInfo(rawValue: CGImageAlphaInfo.premultipliedLast.rawValue)
        let context = CGContext(data: nil, width: Int(width), height: Int(height), bitsPerComponent: 8, bytesPerRow: 0, space: colorSpace, bitmapInfo: bitmapInfo.rawValue)!
        
        context.clip(to: bounds, mask: maskImage)
        context.setFillColor(color.cgColor)
        context.fill(bounds)
        
        if let cgImage = context.makeImage() {
            let coloredImage = UIImage(cgImage: cgImage)
            return coloredImage
        } else {
            return nil
        }
    }
    
}


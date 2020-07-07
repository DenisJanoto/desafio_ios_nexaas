//
//  CustomTableViewCell.swift
//  desafio_ios_nexaas
//
//  Created by Denis Janoto on 06/07/20.
//  Copyright © 2020 Denis Janoto. All rights reserved.
//

import UIKit
import Kingfisher


class CustomTableViewCell: UITableViewCell {
    
    
    @IBOutlet weak var txtRepositoryName: UILabel!
    @IBOutlet weak var txtRepositoryDescription: UITextView!
    @IBOutlet weak var txtRepositoryFork: UILabel!
    @IBOutlet weak var txtRepositoryStar: UILabel!
    @IBOutlet weak var imgUser: UIImageView!
    @IBOutlet weak var txtRepositoryUserName: UILabel!
    @IBOutlet weak var txtRepositoryLastName: UILabel!
    
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
    func prepareCell(information:Item){
        setImage(pathImage: information.owner.avatarURL)
        
        txtRepositoryName.text = information.name
        txtRepositoryDescription.text = information.itemDescription
        txtRepositoryFork.text = "\(information.forksCount)"
        txtRepositoryStar.text = "\(information.stargazersCount)"
        txtRepositoryUserName.text = information.owner.login
        
    }
    
    
    
    //MARK: - SET IMAGE ON CELL
    func setImage(pathImage:String){
        if let url = URL.init(string:pathImage){
            let resource = ImageResource(downloadURL: url, cacheKey: nil)
            imgUser.kf.indicatorType = .activity //Placeholder nas imagens antes de carregar
            imgUser.kf.setImage(with: resource)
            
        }else{
            imgUser.image = nil
        }
        
        imgUser.layer.cornerRadius = imgUser.frame.size.height/2 //Deixa imagem redonda
        
    }
    
}

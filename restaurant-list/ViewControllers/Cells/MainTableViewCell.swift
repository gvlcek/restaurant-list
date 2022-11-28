//
//  MainTableViewCell.swift
//  restaurant-list
//
//  Created by Guadalupe Vlček on 27/11/2022.
//

import UIKit

protocol MainTableViewCellDelegate: NSObjectProtocol {
    func userDidSelectFavorite(uuid: String, isFavorite: Bool)
}

class MainTableViewCell: UITableViewCell {
    weak var delegate: MainTableViewCellDelegate?
    var isFavorite: Bool = false
    
    var restaurant: Restaurant? {
        didSet {
            nameLabel.text = restaurant?.name
            addressLabel.text = "\(restaurant?.address.street ?? ""), \(restaurant?.address.locality ?? ""), \(restaurant?.address.country ?? "")"
            isFavorite ? favoriteImageView.setImage(UIImage(named: "filled-heart"), for: .normal) : favoriteImageView.setImage(UIImage(named: "empty-heart"), for: .normal)
            if let icon = restaurant?.mainPhoto?.squareImage {
                iconImageView.setImageFromString(stringUrl: icon)
            } else {
                iconImageView.backgroundColor = .secondarySystemFill
            }
            ratingLabel.text = "The fork: \(restaurant?.aggregateRatings.thefork.ratingValue ?? 0) - TripAdvisor: \(restaurant?.aggregateRatings.tripadvisor.ratingValue ?? 0)"
        }
    }
    
    let containerView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.clipsToBounds = true // this will make sure its children do not go out of the boundary
        return view
    }()
    
    let iconImageView: UIImageView = {
        let img = UIImageView()
        img.contentMode = .scaleAspectFill // image will never be strecthed vertially or horizontally
        img.translatesAutoresizingMaskIntoConstraints = false // enable autolayout
        img.layer.cornerRadius = 35
        img.clipsToBounds = true
        return img
    }()
    
    let nameLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 20)
        label.textColor = .label
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let addressLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 14)
        label.textColor =  .secondaryLabel
        label.clipsToBounds = true
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let ratingLabel: UILabel = {
        let label = UILabel()
        label.textColor =  .tertiaryLabel
        label.clipsToBounds = true
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let favoriteImageView: UIButton = {
        let button = UIButton()
        button.contentMode = .scaleAspectFill // without this your image will shrink and looks ugly
        button.translatesAutoresizingMaskIntoConstraints = false
        button.layer.cornerRadius = 13
        button.clipsToBounds = true
        button.addTarget(self, action: #selector(buttonTapped), for: .touchUpInside)
        return button
    }()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        selectionStyle = .none
        
        contentView.addSubview(iconImageView)
        containerView.addSubview(nameLabel)
        containerView.addSubview(addressLabel)
        containerView.addSubview(ratingLabel)
        contentView.addSubview(containerView)
        contentView.addSubview(favoriteImageView)
        
        iconImageView.centerYAnchor.constraint(equalTo: contentView.centerYAnchor).isActive = true
        iconImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 10).isActive = true
        iconImageView.widthAnchor.constraint(equalToConstant: 70).isActive = true
        iconImageView.heightAnchor.constraint(equalToConstant: 70).isActive = true
        
        containerView.centerYAnchor.constraint(equalTo: contentView.centerYAnchor).isActive = true
        containerView.leadingAnchor.constraint(equalTo: iconImageView.trailingAnchor, constant: 10).isActive = true
        containerView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -10).isActive = true
        containerView.heightAnchor.constraint(equalToConstant: 60).isActive = true
        
        nameLabel.topAnchor.constraint(equalTo: containerView.topAnchor).isActive = true
        nameLabel.leadingAnchor.constraint(equalTo: containerView.leadingAnchor).isActive = true
        nameLabel.trailingAnchor.constraint(equalTo: containerView.trailingAnchor).isActive = true
        
        addressLabel.topAnchor.constraint(equalTo: nameLabel.bottomAnchor).isActive = true
        addressLabel.leadingAnchor.constraint(equalTo: containerView.leadingAnchor).isActive = true
        addressLabel.trailingAnchor.constraint(equalTo: favoriteImageView.leadingAnchor).isActive = true
        
        ratingLabel.topAnchor.constraint(equalTo: addressLabel.bottomAnchor).isActive = true
        ratingLabel.leadingAnchor.constraint(equalTo: containerView.leadingAnchor).isActive = true
        
        favoriteImageView.widthAnchor.constraint(equalToConstant: 26).isActive = true
        favoriteImageView.heightAnchor.constraint(equalToConstant: 26).isActive = true
        favoriteImageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20).isActive = true
        favoriteImageView.centerYAnchor.constraint(equalTo: contentView.centerYAnchor).isActive = true
    }
    
    @objc func buttonTapped(sender : UIButton) {
        if let uuid = restaurant?.uuid {
            delegate?.userDidSelectFavorite(uuid: uuid, isFavorite: !isFavorite)
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
}

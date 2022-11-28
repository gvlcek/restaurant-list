//
//  MainTableViewCell.swift
//  restaurant-list
//
//  Created by Guadalupe Vlček on 27/11/2022.
//

import UIKit

protocol MainTableViewCellDelegate: AnyObject {
    func userDidSelectFavorite(uuid: String, isFavorite: Bool)
}

class MainTableViewCell: UITableViewCell {
    weak var delegate: MainTableViewCellDelegate?
    var isFavorite: Bool = false
    
    var restaurant: Restaurant? {
        didSet {
            nameLabel.text = restaurant?.name
            addressLabel.text = "\(restaurant?.address.street ?? ""), \(restaurant?.address.locality ?? ""), \(restaurant?.address.country ?? "")"
            isFavorite ? favoriteButton.setImage(UIImage(named: "filled-heart"), for: .normal) : favoriteButton.setImage(UIImage(named: "empty-heart"), for: .normal)
            if let icon = restaurant?.mainPhoto?.squareImage {
                iconImageView.setImageFromString(stringUrl: icon)
            } else {
                iconImageView.backgroundColor = .secondarySystemFill
            }
            ratingLabel.text = "The fork: \(restaurant?.aggregateRatings.thefork.ratingValue ?? 0) - TripAdvisor: \(restaurant?.aggregateRatings.tripadvisor.ratingValue ?? 0)"
        }
    }
    
    let containerView: UIStackView = {
        let view = UIStackView()
        view.axis = .vertical
        view.translatesAutoresizingMaskIntoConstraints = false
        view.clipsToBounds = true // this will make sure its children do not go out of the boundary
        return view
    }()
    
    let iconImageView: UIImageView = {
        let img = UIImageView()
        img.contentMode = .scaleAspectFill // image will never be strecthed vertially or horizontally
        img.translatesAutoresizingMaskIntoConstraints = false // enable autolayout
        img.layer.cornerRadius = Constants.Constraints.iconImageHeight / 2
        img.clipsToBounds = true
        return img
    }()
    
    let nameLabel: UILabel = {
        let label = UILabel()
        label.textColor = .label
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let addressLabel: UILabel = {
        let label = UILabel()
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
    
    let favoriteButton: UIButton = {
        let button = UIButton()
        button.contentMode = .scaleAspectFill // without this your image will shrink and looks ugly
        button.translatesAutoresizingMaskIntoConstraints = false
        button.layer.cornerRadius = Constants.Constraints.favoriteButtonHeight / 2
        button.clipsToBounds = true
        button.addTarget(self, action: #selector(buttonTapped), for: .touchUpInside)
        return button
    }()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        selectionStyle = .none
        
        containerView.addArrangedSubview(nameLabel)
        containerView.addArrangedSubview(addressLabel)
        containerView.addArrangedSubview(ratingLabel)
        
        contentView.addSubview(iconImageView)
        contentView.addSubview(containerView)
        contentView.addSubview(favoriteButton)
        
        iconImageView.centerYAnchor.constraint(equalTo: contentView.centerYAnchor).isActive = true
        iconImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: Constants.Constraints.leadingAnchor).isActive = true
        iconImageView.widthAnchor.constraint(equalToConstant: Constants.Constraints.iconImageHeight).isActive = true
        iconImageView.heightAnchor.constraint(equalTo: iconImageView.widthAnchor, multiplier: 1/1).isActive = true
        
        containerView.centerYAnchor.constraint(equalTo: iconImageView.centerYAnchor).isActive = true
        containerView.leadingAnchor.constraint(equalTo: iconImageView.trailingAnchor, constant: Constants.Constraints.leadingAnchor).isActive = true
        
        nameLabel.leadingAnchor.constraint(equalTo: containerView.leadingAnchor).isActive = true
        nameLabel.trailingAnchor.constraint(equalTo: containerView.trailingAnchor).isActive = true
        
        addressLabel.leadingAnchor.constraint(equalTo: containerView.leadingAnchor).isActive = true
        addressLabel.trailingAnchor.constraint(equalTo: favoriteButton.leadingAnchor).isActive = true
        
        ratingLabel.topAnchor.constraint(equalTo: addressLabel.bottomAnchor).isActive = true
        ratingLabel.leadingAnchor.constraint(equalTo: containerView.leadingAnchor).isActive = true
        
        favoriteButton.widthAnchor.constraint(equalToConstant: Constants.Constraints.favoriteButtonHeight).isActive = true
        favoriteButton.heightAnchor.constraint(equalTo: favoriteButton.widthAnchor, multiplier: 1/1).isActive = true
        favoriteButton.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: Constants.Constraints.trailingAnchor).isActive = true
        favoriteButton.centerYAnchor.constraint(equalTo: contentView.centerYAnchor).isActive = true
    }
    
    @objc func buttonTapped(_ sender : Any) {
        if let uuid = restaurant?.uuid {
            delegate?.userDidSelectFavorite(uuid: uuid, isFavorite: !isFavorite)
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
}

class Group < ApplicationRecord
        has_many :group_users, dependent: :destroy
        belongs_to :owner, class_name: 'User'
        has_many :users, through: :group_users
      
        validates :name, presence: true
        validates :detail, presence: true
        has_one_attached :image
        
        def is_owned_by?(user)
          owner.id == user.id
        end
        def get_image
            (image.attached?) ? image : 'no_image.jpg'
          end
end

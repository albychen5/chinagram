class User < ActiveRecord::Base
	has_many :posts, dependent: :destroy
	has_many :comments, dependent: :destroy

	validates :user_name, presence: true, length: { minimum: 4, maximum: 16 }

	has_attached_file :avatar, styles: { medium: '152 x 152#' }
	validates_attachment_content_type :avatar, content_type: /\Aimage\/.*\Z/

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
end

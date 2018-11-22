class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable, :confirmable, :trackable, :omniauthable, omniauth_providers: %i[facebook]

  has_one :user_profile

  # Register new user profile entry
  after_create :create_user_profile_entry

  # ... and add some code for that callback.
  def create_user_profile_entry
    @email_name = self.email[/[^@]+/]
    @email_name.gsub!(".","")
    @new_username = "#{@email_name}#{rand(1000)}"
    
    UserProfile.create([{ user_id: self.id, username: @new_username}])
  end
end

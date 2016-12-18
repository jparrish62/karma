class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  searchkick
  enum role: [:user, :editor, :admin]
  after_initialize :set_default_role, :if => :new_record?

  devise :database_authenticatable, :registerable,
  :recoverable, :rememberable, :trackable, :validatable,
  :omniauthable, :omniauth_providers => [:google_oauth2]
  has_many :appointments
  has_many :stylists
  has_many :works

  def set_default_role
    self.role ||= :user
  end

end

class Briefing < ActiveRecord::Base
  has_attached_file :picture, :styles => { :medium => "480>", :small => "196>", :x_medium => "600" },
    :storage => :s3, :bucket => 'azurie-briefings',
    :s3_credentials => {
      :access_key_id => ENV['S3_KEY'],
      :secret_access_key => ENV['S3_SECRET']
    },
    :path => "app/public/system/:attachment/:id/:style/:filename"

  has_paper_trail

  belongs_to :user

  attr_accessible :title, :description, :category, :source, :is_quote, :picture, :video

  validates :title, :presence => true
  validates :description, :presence => true

  scope :top, :limit => 1, :order => :created_at.desc
  scope :all, :order => :created_at.desc

  extend FriendlyId
  friendly_id :title, use: :slugged

  def self.category(category)
    Briefing.all.where(:category => category)
  end
end

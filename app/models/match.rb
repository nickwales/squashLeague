class Match < ActiveRecord::Base
  attr_accessible :index, :playerdiv_id, :rankings_attributes, :results_attributes
  has_many :results, :dependent => :delete_all, :inverse_of => :match
  has_many :rankings, :dependent => :delete_all
  belongs_to :playerdiv
  accepts_nested_attributes_for :rankings, :results, :reject_if => proc {|attributes| attributes.all? {|k,v| v.nil?}}
  
  
  #, :reject_if => proc { |attributes| attributes['score'].blank? }
  
  def score_empty(attributed)
    attributed['score'].blank?
  end
  
end

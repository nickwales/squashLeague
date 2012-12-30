class Blog < ActiveRecord::Base

  belongs_to :player
#  before_filter :authenticate_player!
  attr_accessible :author, :contents, :summary, :title



end

class Blog < ActiveRecord::Base
  
#  before_filter :authenticate_player!
  attr_accessible :author, :contents, :summary, :title

end

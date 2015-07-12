require 'rails_helper'

describe Player do
  it "will accept name and email" do 
    expect(FactoryGirl.create(:player)).to be_valid
  end

  it "will require a password" do 
    expect(FactoryGirl.build(:player_without_password)).not_to be_valid
  end
end

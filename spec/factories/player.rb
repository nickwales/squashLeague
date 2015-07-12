FactoryGirl.define do 

  factory :player do  
    email "nwales@homeaway.com" 
    name "Nick Wales" 
    phone "0123454398"
    password "testing"
  end 

  factory :player_without_password, class: Player do  
    email "nwales@homeaway.com" 
    name "Nick Wales" 
    phone "0123454398"
  end 

end

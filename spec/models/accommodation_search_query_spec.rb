require 'spec_helper'

describe AccommodationSearchQuery do
  
  describe 'query' do
    it 'should find suburb like a suburb in the query parameter' do
      accommodation = AccommodationSearchQuery.new(:suburb => 'Auchenflower')
      accommodation.to_sql_conditions.should eql ['suburb like ?', "%Auchenflower%"]
    end
    
    it 'should not use suburb in query when searching on all' do
      accommodation = AccommodationSearchQuery.new(:suburb => 'All')
      accommodation.to_sql_conditions.should eql [""]
    end
    
    it 'should find number of beds greater than the number of beds in the query parameter' do
      accommodation = AccommodationSearchQuery.new(:number_of_people => '4')
      accommodation.to_sql_conditions.should eql ['number_of_people >= ?', '4']
    end
    
    it 'should ignore any values that are empty' do
      accommodation = AccommodationSearchQuery.new(:number_of_people => '', :suburb => '')
      accommodation.to_sql_conditions.should eql [""]
    end
    
    it 'should build a query for all params available' do
      accommodation = AccommodationSearchQuery.new(:number_of_people => '2', :suburb => 'Carindale')
      accommodation.to_sql_conditions.should eql ['suburb like ? and number_of_people >= ?', "%Carindale%", '2']
    end
    
    it 'should find on pets' do
      accommodation = AccommodationSearchQuery.new(:pets => 'yes')
      accommodation.to_sql_conditions.should eql ['takes_pets = ?', true]
    end
    
    it 'should find on children' do
      accommodation = AccommodationSearchQuery.new(:children => 'yes')
      accommodation.to_sql_conditions.should eql ['takes_children = ?', true]
    end
    
    it 'should find on smokers' do
      accommodation = AccommodationSearchQuery.new(:smokers => 'yes')
      accommodation.to_sql_conditions.should eql ['takes_smokers = ?', true]
    end
    
  end
  
end
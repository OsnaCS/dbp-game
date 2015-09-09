class Rank < ActiveRecord::Base
	belongs_to :user

  def self.rank_list(center, offset)
    allRanks = Array.new
    currentRank = nil

    User.all.each do |u|
      currentRank = Rank.find_by(user_id: u.id)

      if not currentRank
        currentRank = Rank.new
        currentRank.user_id = u.id
        currentRank.score = 0
        Rank.create(:user_id => u.id, :score => 0)
      end
      allRanks << currentRank
    end
    allRanks = allRanks.sort_by{|rank| rank.score}.reverse

    if(center < 0)
      center = 0
    end

    if(offset < 0)
      offset = 0
    end

    lower = center - offset
    if(lower < 0)
      lower = 0
    end
    upper = center + offset
    
    if(upper >= allRanks.length)
      upper = allRanks.length - 1
    end

    rankedNames = Hash.new("Default")

    counter = lower
    allRanks[lower..upper].each do |a|
      counter = counter + 1
      rankedNames[a] = counter
    end

    return rankedNames
  end
end
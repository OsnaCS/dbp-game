class Expidition < ActiveRecord::Base

   belongs_to :fighting_fleet
   @storeroom
   @explore_time
   @value

   #def initialize(time, store, v)
   #   @explore_time = time
   #   @storeroom = store
   #   @value = v
   #end

   def explore
      event = rand(100)
      happen = 1.0-(1.0/(1.0 + @explore_time))
      happen = happen * 100
      puts "#{happen}"
      if(happen>event)
         return occurance
      else
         return nothing
      end
   end

   def occurance
      occ = rand(100)
      case occ
      when 0..20
         return destruction
      when 20..40
         return fight
      when 40..80
         return ressource
      when 80..100
         return salvage
      end
   end

   def nothing
      puts "Nothing"
   end

   def destruction
      puts "destroyed"
   end

   def fight
      random = rand(70..130)
      limit = random * @value/100.0
      puts "Gegnerstärke: #{limit/@value}"
   end

   def ressource
      first = rand(100)
      second = rand(100)
      if(first>second)
         crystal = first - second
         metal = second
         fuel = 100 - first
      elsif (second>first)
         crystal = second - first
         metal = first
         fuel = 100 - second
      else
         metal = first
         crystal = 0;
         fuel = 100 - first
      end
      relative_amount = rand(30..200)
      absolute_amount = @storeroom * relative_amount/10000.0
      metal_got = absolute_amount * metal
      crystal_got = absolute_amount * crystal
      fuel_got = absolute_amount * fuel

      puts "#{metal_got}, #{crystal_got}, #{fuel_got}"
      
   end

   def salvage
      threshold = @value/10.0
      gain = 0.0
      until(threshold<gain)
         ship_got = rand(100)
         case ship_got
         when 0..10
            gain += 100
            puts "Kreuzer"
         when 10..30
            gain += 40
            puts "Fregatte"
         when 30..60
            gain += 8
            puts "mobiler Schild"
         when 60..100
            gain += 4
            puts "Jäger"
         end
      end
   end

  # print "Reisezeit angeben:\n"
  # time = gets.to_i
  # print "Lagerraum angeben:\n"
  # store = gets.to_i
  # print "Kampfstärke angeben:\n"
  # v = gets.to_i
  # exploration = Expidition.new(time, store, v)
  # exploration.explore

end

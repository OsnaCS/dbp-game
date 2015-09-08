class Expidition < ActiveRecord::Base

   has_one :fighting_fleet
   @exp_storeroom
   @fleet_storeroom
   @explore_time
   @value

   #def initialize(time, store, v)
   #   @explore_time = time
   #   @storeroom = store
   #   @value = v
   #end

   def explore
      @value = 0
      @fleet_storeroom = 0
      @exp_storeroom = 0
      fighting_fleet.ship_group.all.each do |g|
        @value += g.unit.total_cost * g.number
        @fleet_storeroom += g.unit.cargo * g.number
        if(g.unit.name == "Expeditionsschiff")
           @exp_storeroom += g.unit.cargo * g.number
        end
      end
      event = rand(100)
      happen = 1.0-(1.0/(1.0 + @explore_time))
      happen = happen * 100
      if(happen>event)
         return occurance
      else
         return nothing
      end
      #TODO Flotte zurueckschicken
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
      #TODO Notification
   end

   def destruction
      fighting_fleet.ship_group.all.each do |g|
         g.number = 0
      end
      #TODO Notification
   end

   def fight
      random = rand(70..130)
      limit = random * @value/100.0
      kreuzer_amount = 0
      jaeger_amount = 0
      fregatte_amount = 0
      schild_amount = 0
      until(limit<enemy_strength)
         ship_got = rand(100)
         case ship_got
         when 0..10
            enemy_strength += 100
            kreuzer_amount += 1
         when 10..30
            enemy_strength += 40
            fregatte_amount += 1
         when 30..60
            enemy_strength += 8
            schild_amount += 1
         when 60..100
            enemy_strength += 4
            jaeger_amount += 1
         end
      end

      shield_strenght = shield_amount * 5 
      gegner_flotte = Fighting_fleet.create(user: User.find_by_username("dummy"),
                                            shield: shield_strength)
      kreuzer_part = Ship_group.create(fighting_fleet: gegner_flotte, ship:
                                       "Kreuzer", number: kreuzer_amount,
                                      group_hitpoints: kreuzer_amount*10) 
      fregatte_part = Ship_group.create(fighting_fleet: gegner_flotte, ship:
                                       "Fregatte", number: fregatte_amount,
                                      group_hitpoints: fregatte_amount*10) 
      schild_part = Ship_group.create(fighting_fleet: gegner_flotte, ship:
                                       "mobiler Schild", number: schild_amount,
                                      group_hitpoints: schild_amount*5) 
      jaeger_part = Ship_group.create(fighting_fleet: gegner_flotte, ship:
                                       "Jäger", number: jaeger_amount,
                                      group_hitpoints: jaeger_amount*1) 
      #TODO Hardcodings entfernen sobald Werte in DB verfügbar
      #TODO Kampf starten
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
      absolute_amount = @exp_storeroom * relative_amount/10000.0
      final_amount = [absolute_amount, @fleet_storeroom].min
      metal_got = final_amount * metal
      crystal_got = final_amount * crystal
      fuel_got = final_amount * fuel
      #TODO Nachrichten fuer die Ereignisse ausgeben
      #TODO Ressourcen adden
      
   end

   def salvage
      threshold = @value/10.0
      gain = 0.0
      kreuzer_amount = 0
      jaeger_amount = 0
      fregatte_amount = 0
      schild_amount = 0
      until(threshold<gain)
         ship_got = rand(100)
         case ship_got
         when 0..10
            gain += 100
            kreuzer_amount += 1
         when 10..30
            gain += 40
            fregatte_amount += 1
         when 30..60
            gain += 8
            schild_amount += 1
         when 60..100
            gain += 4
            jaeger_amount += 1
         end
      end
      #TODO Nachricht erstellen
      fighting_fleet.ship_group.all.each do |g|
         case g.unit.name
         when "Kreuzer"
            g.number += kreuzer_amount
            kreuzer_amount = 0
         when "Fregatte"
            g.number += fregatte_amount
         when "mobiler Schild"
            g.number += schild_amount
         when "Jäger"
            g.number += jaeger_amount
         end
         if(kreuzer_amount != 0)
            #TODO Kreuzer ship_group erstellen und amount adden
         end
         if(fregatte_amount != 0) 
            #TODO fregatte ship_group erstellen und amount adden
         end
         if(schild_amount != 0)
            #TODO schild ship_group erstellen und amount adden
         end
         if(jaeger_amount != 0)
            #TODO jaeger ship_group erstellen und amount adden
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

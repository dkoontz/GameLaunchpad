# Copyright (c) 2009 GameLaunchpad
# All rights reserved.

module GameLaunchpad
  class DefaultUpdateManager < Manager
    def load
      @updatable_game_objects = []
      @scene.game_object_manager.after_game_object_added do |object, options|
        @updatable_game_objects << object if object.respond_to? :update
      end

      @scene.manager(:game_object).after_game_object_removed do |object, options|
        @updatable_game_objects.delete object
      end
    end

    def update(delta)
      @updatable_game_objects.each do |object|
        begin
          object.update(delta)
        rescue NameError => e
          @updatable_game_objects.delete object if e.message =~ /^undefined local variable or method `update'/
          next
        end
      end
    end
  end
end
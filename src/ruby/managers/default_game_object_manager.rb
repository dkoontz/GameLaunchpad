# Copyright (c) 2009 GameLaunchpad
# All rights reserved.

module GameLaunchpad
  class DefaultGameObjectManager < Manager
    has_callbacks :before_game_object_added, :after_game_object_added
    has_callbacks :before_game_object_removed, :after_game_object_removed

    def load
      @game_objects = []
    end
    
    def add_game_object(object)
      run_before_game_object_added_callbacks object
      @game_objects << object
      run_after_game_object_added_callbacks object
    end

    def remove_game_object(object)
      run_before_game_object_removed_callbacks object
      @game_objects.delete object
      run_before_game_object_removed_callbacks object
    end

    def game_objects
      @game_objects.dup
    end

    def each
      @game_objects.each do |object|
        yield object
      end
    end
  end
end
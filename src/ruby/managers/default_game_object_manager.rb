module GameLaunchpad
  class DefaultGameObjectManager < Manager
    define_callbacks :before_game_object_added, :after_game_object_added
    define_callbacks :before_game_object_removed, :after_game_object_removed

    def load
      @game_objects = []
    end
    
    def add_game_object(object)
      run_callbacks(:before_game_object_added, object)
      @game_objects << object
      run_callbacks(:after_game_object_added, object)
    end

    def remove_game_object(object)
      run_callbacks(:before_game_object_removed, object)
      @game_objects.delete object
      run_callbacks(:before_game_object_removed, object)
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
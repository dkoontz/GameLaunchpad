module GameLaunchpad
  class DefaultGameObjectManager < Manager
    def initialize(state)
      super
      @layers = {:default => []}
    end
    
    def add_game_object(object, layer = :default)
      @layers[layer] << object
    end

    def remove_game_object(object, layer = :default)
      @layers[layer].delete object
    end

    def game_objects(layer = :default)
      @layers[layer].dup
    end

    def each(layer = :default)
      @layers[layer].each do |object|
        yield object
      end
    end

    def layers
      @layers.keys
    end
  end
end
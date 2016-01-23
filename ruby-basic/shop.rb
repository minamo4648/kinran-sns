class Shop
  attr_accessor :name

  def initialize(name)
    @name = name
  end

  def print_details
    puts "shop: #{name}"
  end
end

module AnimalModule
  attr_accessor :animals

  def print_animals
    puts "animals: #{animals.join(',')}"
  end
end

class PetShop < Shop
  include AnimalModule

  def print_details
    super
    print_animals
  end
end

module CafeModule
  attr_accessor :menus

  def print_menus
    puts "menus: #{menus.join(',')}"
  end
end

class AnimalCafe < Shop
  include AnimalModule
  include CafeModule

  def print_details
    super
    print_animals
    print_menus
  end
end

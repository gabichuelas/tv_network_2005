require 'minitest/autorun'
require 'minitest/pride'
require './lib/character'
require './lib/show'
require './lib/network'

class NetworkTest < Minitest::Test

  def setup
    @nbc = Network.new("NBC")

    @michael_knight = Character.new({name: "Michael Knight", actor: "David Hasselhoff", salary: 1_600_000})

    @kitt = Character.new({name: "KITT", actor: "William Daniels", salary: 1_000_000})

    @knight_rider = Show.new("Knight Rider", "Glen Larson", [@michael_knight, @kitt])

    @leslie_knope = Character.new({name: "Leslie Knope", actor: "Amy Poehler", salary: 2_000_000})

    @ron_swanson = Character.new({name: "Ron Swanson", actor: "Nick Offerman", salary: 1_400_000})

    @parks_and_rec = Show.new("Parks and Recreation", "Michael Shur & Greg Daniels", [@leslie_knope, @ron_swanson])

    @mitch = Character.new({name: "Mitch Buchannon", actor: "David Hasselhoff", salary: 1_200_000})

    @baywatch = Show.new("Baywatch", "Gregory Bonann", [@mitch])


  end

  def test_it_exists
    assert_instance_of Network, @nbc
  end

  def test_it_has_a_name
    assert_equal "NBC", @nbc.name
  end

  def test_it_has_shows
    assert_equal [], @nbc.shows
  end

  def test_it_can_add_shows
    @nbc.add_show(@knight_rider)
    @nbc.add_show(@parks_and_rec)

    assert_equal [@knight_rider, @parks_and_rec], @nbc.shows
  end

  def test_it_has_main_characters
    @nbc.add_show(@knight_rider)
    @nbc.add_show(@parks_and_rec)

    assert_equal [@kitt], @nbc.main_characters
  end

  def test_it_can_group_actors_by_show
    # skip
    @nbc.add_show(@knight_rider)
    @nbc.add_show(@parks_and_rec)

    assert_instance_of Hash , @nbc.actors_by_show
    assert_equal ["David Hasselhoff", "William Daniels"], @nbc.actors_by_show[@knight_rider]
    assert_equal ["Amy Poehler", "Nick Offerman"], @nbc.actors_by_show[@parks_and_rec]
  end

  def test_it_can_group_shows_by_actor
    @nbc.add_show(@knight_rider)
    @nbc.add_show(@parks_and_rec)
    @nbc.add_show(@baywatch)

    assert_instance_of Hash, @nbc.shows_by_actor
  end

  def test_it_has_prolific_actors
    @nbc.add_show(@knight_rider)
    @nbc.add_show(@parks_and_rec)
    @nbc.add_show(@baywatch)
    
    assert_equal ["David Hasselhoff"], @nbc.prolific_actors
  end

end

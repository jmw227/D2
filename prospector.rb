# Prospector class for gold rush
class Prospector
  attr_accessor :id
  attr_accessor :total_gold
  attr_accessor :total_silver
  attr_accessor :num_loc_visited
  attr_accessor :num_days
  attr_accessor :current_loc
  attr_accessor :current_loc_id
  attr_accessor :gold_found
  attr_accessor :silver_found
  attr_accessor :moving
  attr_accessor :sg
  attr_accessor :s
  def initialize(id, loc, loc_id)
    @id = id
    @current_loc = loc
    @current_loc_id = loc_id
    @total_gold = @total_silver = 0
    @num_loc_visited = 1
    @num_days = 0
    @gold_found = @silver_found = 0
    @moving = false
    @s = @sg = ''
  end

  def sg?(gold)
    @sg = if gold == 1
            ''
          else
            's'
          end
  end

  def s?(silver)
    @s = if silver == 1
           ''
         else
           's'
         end
  end

  def prospect(rng)
    get_gold(rng)
    get_silver(rng)
    @num_days += 1
  end

  def get_gold(rng)
    return 0 if current_loc.max_gold.zero?

    @gold_found = rng.rand(current_loc.max_gold + 1)
    @total_gold += @gold_found
    sg?(@gold_found)
    @gold_found
  end

  def get_silver(rng)
    return 0 if current_loc.max_silver.zero?

    @silver_found = rng.rand(current_loc.max_silver + 1)
    @total_silver += @silver_found
    s?(@silver_found)
    @silver_found
  end

  def reset
    @gold_found = 0
    @silver_found = 0
  end

  def string_findings
    if @gold_found.zero? && @silver_found.zero?
      "Found no precious metals in #{@current_loc.name}"
    elsif @gold_found.zero?
      "Found #{@silver_found} ounce" + @s + " of silver in #{@current_loc.name}"
    elsif @silver_found.zero?
      "Found #{@gold_found} ounce" + @sg + " of gold in #{@current_loc.name}"
    else
      "Found #{@gold_found} ounce" + @sg + ' of gold and '\
      "#{@silver_found} ounce" + @s + " of silver in #{@current_loc.name}"
    end
  end

  def move(rng, map)
    new_loc_id = @current_loc.choose_neighbor(rng)
    new_loc = map.nodes[new_loc_id]
    str = "Heading from #{@current_loc.name} to #{new_loc.name}, "\
    "holding #{@total_gold} ounce" + sg?(@total_gold) + ' of gold and '\
	"#{@total_silver} ounce" + s?(@total_silver) + ' of silver'
    @num_loc_visited += 1
    @current_loc_id = new_loc_id
    @current_loc = new_loc
    str
  end

  def leaving?
    if @num_loc_visited < 4
      leaving_early?
    else
      leaving_late?
    end
  end

  def leaving_early?
    @moving = @silver_found.zero? && @gold_found.zero?
  end

  def leaving_late?
    @moving = @silver_found < 3 && @gold_found < 2
  end

  def cash_out
    total = @total_gold * 20.67 + @total_silver * 1.31
    format('$%#.2f', total)
  end
end

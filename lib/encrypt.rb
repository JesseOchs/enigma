require './generator'

module Encrypt
  include Generator

  def make_keys(key)
    keys = []
      keys << key[0,2].to_i
      keys << key[1,2].to_i
      keys << key[2,2].to_i
      keys << key[3,2].to_i
    return keys
  end

  def make_offsets(date)
    offsets = []
    date = (date.to_i ** 2).to_s
      offsets << date[-4].to_i
      offsets << date[-3].to_i
      offsets << date[-2].to_i
      offsets << date[-1].to_i
      return offsets
  end

  def make_shifts(key, date)
    shifts = make_keys(key).zip(make_offsets(date))
      shifts.map do |pair|
        pair.sum
      end
  end

  def shifted_characters(key, date)
    characters_shifted = []
    shifts = make_shifts(key, date)
    characters = gen_characters
      characters_shifted << characters.rotate(shifts[0])
      characters_shifted << characters.rotate(shifts[1])
      characters_shifted << characters.rotate(shifts[2])
      characters_shifted << characters.rotate(shifts[3])
    return characters_shifted
  end


  def encrypt_message(message, key, date)
    rotated_characters = shifted_characters(key, date)
    output = ""
      message.each_char { |char|
        if message.index(char) % 4 == 0
          output << rotated_characters[0][character_swap(char)]
        elsif message.index(char) % 4 == 1
          output << rotated_characters[1][character_swap(char)]
        elsif message.index(char) % 4 == 2
          output << rotated_characters[2][character_swap(char)]
        elsif message.index(char) % 4 == 3
          output << rotated_characters[3][character_swap(char)]
        end
        }
        return output
  end


  def character_swap(char)
      characters = gen_characters
      characters.index(char)
  end

end

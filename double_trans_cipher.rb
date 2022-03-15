require_relative './credit_card'

module DoubleTranspositionCipher
  def self.encrypt(document, key)
    # TODO: FILL THIS IN!
    ## Suggested steps for double transposition cipher
    # 1. find number of rows/cols such that matrix is almost square
    # 2. break plaintext into evenly sized blocks
    # 3. sort rows in predictibly random way using key as seed
    # 4. sort columns of each row in predictibly random way
    # 5. return joined cyphertext
    process(document, key, true)
  end

  def self.decrypt(ciphertext, key)
    # TODO: FILL THIS IN!
    process(ciphertext, key, false)
  end

  def self.process(document, key, flag)
    document = document.to_s.chars
    row_num, col_num = find_row_col(document.length)
    blocks = document.each_slice(col_num).to_a
    shuffle_rows = (0...row_num).to_a.shuffle(random: Random.new(key))
    shuffle_cols = (0...col_num).to_a.shuffle(random: Random.new(key))
    blocks = reorder(blocks, shuffle_rows,flag)
    blocks.map { | row | reorder(row, shuffle_cols,flag).join('') }.join('')
  end

  def self.reorder(arr, order, flag)
    temp = Array.new(arr.length)
    order.each_with_index { |num, i|
      if flag
      temp[i] = arr[num] 
      else
        temp[num] = arr[i]
      end
    }
    temp
  end

  def self.find_row_col(number)
    root = (number ** 0.5).round
    (root).downto(1) do |i|
      if (number/i) * i == number
        return i, number/i
      end 
    end
  end
end

cc = CreditCard.new('6011672939740296', 'Mar-30-2020', 'Soumya Ray', 'Visa')
key = 3

enc = DoubleTranspositionCipher.encrypt("6011672939740296", key)
dec = DoubleTranspositionCipher.decrypt(enc, key)

puts enc
puts dec
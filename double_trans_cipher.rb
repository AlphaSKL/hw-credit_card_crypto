# frozen_string_literal: true

# DoubleTranspositionCipher encrypt and decrypt algorithm
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
    square_root, padding_doc = find_length_padding(document.to_s)
    slice_doc = padding_doc.to_s.chars.each_slice(square_root).to_a
    blocks = reorder(slice_doc, key, flag)
    result = blocks.map { |row| reorder(row, key, flag).join('') }.join('')
    flag ? result : result.strip
  end

  def self.reorder(arr, key, flag)
    temp = Array.new(arr.length)
    shuffle_arr = (0...arr.length).to_a.shuffle(random: Random.new(key))
    shuffle_arr.each_with_index do |num, i|
      flag ? temp[i] = arr[num] : temp[num] = arr[i]
    end
    temp
  end

  def self.find_length_padding(document)
    number = document.length
    root = (number**0.5).ceil
    padding_num = root**2 - number
    [root, ' ' * padding_num + document]
  end
end

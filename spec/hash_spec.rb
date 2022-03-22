require_relative '../credit_card'
require 'minitest/autorun'

# Feel free to replace the contents of cards with data from your own yaml file
card_details = [
  { num: '4916603231464963',
    exp: 'Mar-30-2020',
    name: 'Soumya Ray',
    net: 'Visa' },
  { num: '6011580789725897',
    exp: 'Sep-30-2020',
    name: 'Nick Danks',
    net: 'Visa' },
  { num: '5423661657234057',
    exp: 'Feb-30-2020',
    name: 'Lee Chen',
    net: 'Mastercard' }
]

cards = card_details.map do |c|
  CreditCard.new(c[:num], c[:exp], c[:name], c[:net])
end

describe 'Test hashing requirements' do
  describe 'Test regular hashing' do
    describe 'Check hashes are consistently produced' do
      # TODO: Check that each card produces the same hash if hashed repeatedly
      it 'Check that each card produces the same hash if hashed repeatedly' do
        cards.each do |card|   
          digest = card.hash
          digest_plum = card.hash
          _(digest).must_equal digest_plum
          _(digest).wont_be_nil
        end
      end
    end

    describe 'Check for unique hashes' do
      # TODO: Check that each card produces a different hash than other cards
      it 'Check that each card produces a different hash than other cards' do
        digests = Array.new
        cards.each do |card|   
          digest = card.hash
          digests.append(digest)
          _(digest).wont_be_nil
        end
        _(digests[0]).wont_equal digests[1]
        _(digests[0]).wont_equal digests[2]
        _(digests[1]).wont_equal digests[2]
      end
    end
  end

  describe 'Test cryptographic hashing' do
    describe 'Check hashes are consistently produced' do
      # TODO: Check that each card produces the same hash if hashed repeatedly
      it 'Check that each card produces the same hash if hashed repeatedly' do
        cards.each do |card|   
          digest = card.hash_secure
          digest_plum = card.hash_secure
          _(digest).must_equal digest_plum
          _(digest).wont_be_nil
        end
      end
    end

    describe 'Check for unique hashes' do
      # TODO: Check that each card produces a different hash than other cards
      it 'Check that each card produces a different hash than other cards' do
        digests = Array.new
        cards.each do |card|   
          digest = card.hash
          digests.append(digest)
          _(digest).wont_be_nil
        end
        _(digests[0]).wont_equal digests[1]
        _(digests[0]).wont_equal digests[2]
        _(digests[1]).wont_equal digests[2]
      end
    end

    describe 'Check regular hash not same as cryptographic hash' do
      # TODO: Check that each card's hash is different from its hash_secure
      it 'Check that each card hash is different from its hash_secure' do
        digests_hash = Array.new
        digests_hash_secure = Array.new
        cards.each do |card|   
          digest_hash = card.hash
          digests_hash.append(digest_hash)
          _(digest_hash).wont_be_nil

          digest_hash_secure = card.hash_secure
          digests_hash_secure.append(digest_hash_secure)
          _(digest_hash_secure).wont_be_nil
        end
        _(digests_hash[0]).wont_equal digests_hash_secure[0]
        _(digests_hash[1]).wont_equal digests_hash_secure[1]
        _(digests_hash[2]).wont_equal digests_hash_secure[2]
      end
    end
  end
end

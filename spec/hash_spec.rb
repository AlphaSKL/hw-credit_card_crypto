require_relative '../credit_card'
require 'minitest/autorun'
require 'set'

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
      it "test ten round hash result is same or not" do
        first = cards[0].hash
        results = (0..10).map do |number|
          cards[0].hash
        end
        results.map do | result |
          _(result).must_equal first
        end
      end
    end

    describe 'Check for unique hashes' do
      # TODO: Check that each card produces a different hash than other cards
      it "test ten round hash result is same or not" do
        results = cards.map do |card|
          card.hash
        end
        results_set = results.to_set
        _(results.length).must_equal results_set.length
      end
    end
  end

  describe 'Test cryptographic hashing' do
    describe 'Check hashes are consistently produced' do
      # TODO: Check that each card produces the same hash if hashed repeatedly
      it "test ten round hash result is same or not" do
        first = cards[0].hash_secure
        results = (0..10).map do |number|
          cards[0].hash_secure
        end
        results.map do | result |
          _(result).must_equal first
        end
      end
    end

    describe 'Check for unique hashes' do
      # TODO: Check that each card produces a different hash than other cards
      it "test ten round hash result is same or not" do
        results = cards.map do |card|
          card.hash_secure
        end
        results_set = results.to_set
        _(results.length).must_equal results_set.length
      end
    end

    describe 'Check regular hash not same as cryptographic hash' do
      # TODO: Check that each card's hash is different from its hash_secure
      it "test ten round hash result is same or not" do
        results = cards.map do |card|
          _(card.hash_secure).wont_equal card.hash
        end
      end
    end
  end
end

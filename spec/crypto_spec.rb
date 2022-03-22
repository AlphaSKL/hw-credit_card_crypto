# frozen_string_literal: true

require_relative '../credit_card'
require_relative '../substitution_cipher'
require_relative '../double_trans_cipher'
require_relative '../sk_cipher'
require 'minitest/autorun'
require 'yaml'

cards = YAML.load_file 'spec/test_numbers.yml'

describe 'Test card info encryption' do
  before do
    @cc = CreditCard.new('4916603231464963', 'Mar-30-2020',
                         'Soumya Ray', 'Visa')
    @key = 3
  end

  describe 'Using Caesar cipher' do
    it 'should encrypt card information' do
      enc = SubstitutionCipher::Caesar.encrypt(@cc, @key)
      _(enc).wont_equal @cc.to_s
      _(enc).wont_be_nil
    end

    it 'should decrypt text' do
      enc = SubstitutionCipher::Caesar.encrypt(@cc, @key)
      dec = SubstitutionCipher::Caesar.decrypt(enc, @key)
      _(dec).must_equal @cc.to_s
    end
  end

  describe 'Using Permutation cipher' do
    it 'should encrypt card information' do
      enc = SubstitutionCipher::Permutation.encrypt(@cc, @key)
      _(enc).wont_equal @cc.to_s
      _(enc).wont_be_nil
    end

    it 'should decrypt text' do
      enc = SubstitutionCipher::Permutation.encrypt(@cc, @key)
      dec = SubstitutionCipher::Permutation.decrypt(enc, @key)
      _(dec).must_equal @cc.to_s
    end
  end

  # TODO: Add tests for double transposition and modern symmetric key ciphers
  #       Can you DRY out the tests using metaprogramming? (see lecture slide)
  describe 'Using DoubleTranspositionCipher cipher' do
    describe 'Happy simple test' do
      it 'should encrypt simple number' do
        @num = "12345678"
        enc = DoubleTranspositionCipher.encrypt(@num, @key)
        _(enc).wont_equal @cc.to_s
        _(enc).wont_be_nil
      end

      it 'should decrypt simple number' do
        @num = "12345678"
        enc = DoubleTranspositionCipher.encrypt(@num, @key)
        dec = DoubleTranspositionCipher.decrypt(enc, @key)
        _(dec).must_equal @num.to_s
      end

      it 'should encrypt card information' do
        enc = DoubleTranspositionCipher.encrypt(@cc, @key)
        _(enc).wont_equal @cc.to_s
        _(enc).wont_be_nil
      end

      it 'should decrypt card information' do
        enc = DoubleTranspositionCipher.encrypt(@cc, @key)
        dec = DoubleTranspositionCipher.decrypt(enc, @key)
        _(dec).must_equal @cc.to_s
      end
    end
    
    cards.each do |name, numbers|
      describe "Test only valid card numbers: #{name}" do
        numbers['valid'].each do |number|
          it "works on card #: #{number}" do
            enc = DoubleTranspositionCipher.encrypt(number, @key)
            dec = DoubleTranspositionCipher.decrypt(enc, @key)
            _(dec).must_equal number
          end
        end
      end
    end
    
    describe "Test a given card info with random keys" do
      (1..10).each do |number|
        it "iteration #: #{number}" do
          @random_key = (rand * 10_000).to_i
          enc = DoubleTranspositionCipher.encrypt(@cc, @random_key)
          dec = DoubleTranspositionCipher.decrypt(enc, @random_key)
          _(dec).must_equal @cc.to_s
        end
      end
    end
  end
end

describe 'Using SymmetricCipher cipher' do
  before do
    @cc = CreditCard.new('4916603231464963', 'Mar-30-2020',
                         'Soumya Ray', 'Visa')
    @key = ModernSymmetricCipher.generate_new_key
  end

  it 'should decrypt text' do
    enc = ModernSymmetricCipher.encrypt(@cc, @key)
    dec = ModernSymmetricCipher.decrypt(enc, @key)
    _(dec).must_equal @cc.to_s
  end

end
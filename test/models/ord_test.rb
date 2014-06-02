require 'test_helper'

class OrdTest < ActiveSupport::TestCase
  # test 'the truth' do
  #   assert true
  # end

  def setup
    @ord = ords(:hello)
  end

  test '#verify compares against the swedish word' do
    assert @ord.verify('hej')
    refute @ord.verify('hello')
  end

  test '#attempt creates a new attempt with whether the attempt was successful or not' do
    assert_difference(lambda { @ord.attempts.count }, 2) do
      attempt1 = @ord.attempt('hej')
      assert attempt1.successful?

      attempt2 = @ord.attempt('hi')
      refute attempt2.successful?
    end
  end

  test '#verify sanitizes input' do
    @ord = ords(:long_word)
    assert @ord.verify('JAG ÄLSKAR DIG')
    assert @ord.verify('    JaG ÄlSKaR DiG')
    assert @ord.verify('jag älskar dig      ')
    assert @ord.verify('jag        älskar        dig      ')
    assert @ord.verify('Jag älskar dig.')
  end

  test '#verify requires proper accents' do
    @ord.swedish = 'äåö'
    assert @ord.verify('äåö')
    refute @ord.verify('aåa')
    refute @ord.verify('aaa')
  end

  test 'last_shown_at is updated whenever a new attempt is made' do
    3.times do
      old_last_shown_at = @ord.last_shown_at
      assert @ord.attempt('hej').successful?
      refute_equal old_last_shown_at, @ord.reload.last_shown_at
    end
  end

  test "#next_question returns the word that hasn't been seen in the longest time" do
   Ord.destroy_all
   ord1 = Ord.create(english: 'hello', swedish: 'hej')
   ord2 = Ord.create(english: 'hey', swedish: 'tjena')
   ord3 = Ord.create(english: 'goodbye', swedish: 'hej då')
   assert 3, Ord.count

   @ord = Ord.next_question
   assert_equal ord1, @ord
   assert @ord.attempt('hej').successful?

   @ord = Ord.next_question
   assert_equal ord2, @ord
   refute @ord.attempt('test').successful?
   assert [ord3.id, ord1.id, ord2.id], Ord.question_order.map(&:id)
  end

  test "#question_order sorts by created_at if last_shown_at is nil" do
    Ord.destroy_all
    ord1 = Ord.create(english: 'hello', swedish: 'hej', created_at: '2010-01-01')
    ord2 = Ord.create(english: 'hey', swedish: 'tjena', created_at: '2012-01-01')
    ord3 = Ord.create(english: 'goodbye', swedish: 'hej då', created_at: '2011-01-01')
    assert_equal [ord1.id, ord3.id, ord2.id], Ord.question_order.map(&:id)
  end

end

class Ord < ActiveRecord::Base
  has_many :attempts

  validates :english, :presence => true, :uniqueness => true
  validates :swedish, :presence => true, :uniqueness => true

  def self.next_question
     question_order.first
  end

  def self.question_order
    Ord.order('coalesce(last_shown_at, created_at)')
  end

  def successful_attempts
    attempts.where(successful: true)
  end

  def failed_attempts
    attempts.where(successful: false)
  end

  def success_ratio
    successful_attempts.count / (attempts.count.nonzero? || 1)
  end

  def verify(word)
    sanitize!(swedish) == sanitize!(word)
  end

  def attempt(word)
    attempts.create(successful: verify(word), body: word)
  end

  private
  def sanitize!(word)
    word.gsub!('.', '')
    word = word.split.join(' ')
    word.strip!
    word = Unicode.downcase(word)
  end
end

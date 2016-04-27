# == Schema Information
#
# Table name: collections
#
#  id         :integer          not null, primary key
#  hashtag    :string
#  start_date :date
#  end_date   :date
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  next_url   :string
#

class Collection < ActiveRecord::Base
  validates :hashtag, :start_date, :end_date, presence: true
  validates :hashtag, uniqueness: { scope: [:start_date, :end_date] }
  validate :end_date_gte_start_date

  has_many :instagram_contents

  def start_date_unix
    start_date.to_datetime.to_i
  end

  def end_date_unix
    end_date.to_datetime.to_i
  end

  private

  def end_date_gte_start_date
    errors.add(:end_date_gte_start_date, I18n.t('start_date_greater_than_end_date')) if end_date < start_date
  end
end

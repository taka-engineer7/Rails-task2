class Reservation < ApplicationRecord
  belongs_to :user
  belongs_to :room

  validate :must_checkin_later_today
  validate :must_checkout_later_checkin
  validate :guest_count_more_one
  validates :checkin_at, :checkout_at, :guest_count, presence: true

  private

  def must_checkin_later_today
    return if checkin_at.blank?
    if checkin_at < Date.current
      errors.add(:checkin_at, "は本日以降の日付で選択してください。")
    end
  end

  def must_checkout_later_checkin
    return if checkout_at.blank? || checkin_at.blank?
    if checkout_at <= checkin_at
      errors.add(:checkout_at, "はチェックイン日より後の日付で選択してください。")
    end
  end

  def guest_count_more_one
    return if guest_count.blank?
    if guest_count < 1
      errors.add(:guest_count, "は1以上を選択してください。")
    end
  end
end

require "rails_helper"

RSpec.describe ReminderMailer, type: :mailer do
  describe ".send_3_days_left_notifications" do
    it "notifies users with active borrows due in three days and marks them sent" do
      user_book = create(:user_book, borrow_time: 27.days.ago)
      returned_user_book = create(:user_book, borrow_time: 27.days.ago, return_time: Time.current)
      recent_user_book = create(:user_book, borrow_time: 26.days.ago)

      expect {
        perform_enqueued_jobs do
          described_class.send_3_days_left_notifications
        end
      }.to change(ActionMailer::Base.deliveries, :count).by(1)

      expect(ActionMailer::Base.deliveries.last.to).to eq([ user_book.user.email ])
      expect(ActionMailer::Base.deliveries.last.body.encoded).to include("due in 3 days")
      expect(user_book.reload.three_days_left_reminder_sent).to be(true)
      expect(returned_user_book.reload.three_days_left_reminder_sent).to be(false)
      expect(recent_user_book.reload.three_days_left_reminder_sent).to be(false)
    end
  end

  describe ".book_expiration_notifications" do
    it "notifies users with active borrows that reach 30 days and marks them sent" do
      user_book = create(:user_book, borrow_time: 31.days.ago)
      returned_user_book = create(:user_book, borrow_time: 30.days.ago, return_time: Time.current)
      recent_user_book = create(:user_book, borrow_time: 29.days.ago)

      expect {
        perform_enqueued_jobs do
          described_class.book_expiration_notifications
        end
      }.to change(ActionMailer::Base.deliveries, :count).by(1)

      expect(ActionMailer::Base.deliveries.last.to).to eq([ user_book.user.email ])
      expect(ActionMailer::Base.deliveries.last.body.encoded).to include(user_book.book.title)
      expect(user_book.reload.book_expiration_reminder_sent).to be(true)
      expect(returned_user_book.reload.book_expiration_reminder_sent).to be(false)
      expect(recent_user_book.reload.book_expiration_reminder_sent).to be(false)
    end
  end
end

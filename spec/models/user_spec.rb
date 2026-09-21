require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'validations' do
    let(:build_user) { build(:user) }
    let(:build_user_without_email) { build(:user, email: nil) }

    it 'is valid with full_name and email' do
      expect(build_user).to be_valid
    end

    it 'is invalid without an email' do
      expect(build_user_without_email).not_to be_valid
    end
  end

  it 'generates a library_card before validation' do
    user = build(:user, library_card: nil)

    expect { user.valid? }.not_to raise_error
    expect(user.library_card).to be_present
  end
end
